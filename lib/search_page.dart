import 'package:chronomap_mobile/timeline/scalable.dart';
import 'package:chronomap_mobile/utils/button.dart';
import 'package:chronomap_mobile/utils/navi_button.dart';
import 'package:flutter/material.dart';
import 'package:acorn_client/acorn_client.dart';
import 'index_page.dart';
import 'main.dart';
import 'utils/countries_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<Principal> listPrincipal = [];
  List<int> principalIds = [];
  TextEditingController searchController =
      TextEditingController(); // 検索キーワードを入力するためのController

  Future<void> fetchPrincipalByLocation(String keywords) async {
    try { 
      // 文字列をリストに変換してkeywords引数を渡す
      List<String> location = keywords.split(',').map((e) => e.trim()).toList();
      listPrincipal = await client.principal.getPrincipal(keywords: location);
      print("Getting principal with keywords: $location");
      principalIds = listPrincipal.map((item) => item.id as int).toList();
      print(listPrincipal.toString());
      setState(() {}); // データの更新をUIに反映させる
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  void _onScalablePressed() async {
    await fetchPrincipalByLocation(searchController.text);
    if (listPrincipal.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scalable(principal: listPrincipal),
        ),
      );
    }
  }

  List<String> options = [];
  void getOptions() {
    for (var country in countries) {
      options.add(country['name']);
    }
  }

  @override
  void initState() {
    super.initState();
    getOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationButton(
          destinationPage: IndexPage(),
          buttonText: 'index',
        ),
        leadingWidth: 80,
        title: const Text('ChronoMap Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return options.where((String option) {
                  if(textEditingValue.text.isNotEmpty){
                  return option.contains(textEditingValue.text[0].toUpperCase() + textEditingValue.text.substring(1).toLowerCase());
                  }else {
                    return option.contains(textEditingValue.text);
                  }
                });
              },
              onSelected: (String selection) {
                searchController.text = selection;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('VIEW CHOICE'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonFormat(
                  label: 'CLASSIC',
                  onPressed: () =>
                      fetchPrincipalByLocation(searchController.text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonFormat(
                    label: 'SCALABLE', onPressed: _onScalablePressed),
              )
            ],
          ),
          Expanded(
              // ListView.builderをExpandedで囲むことで、利用可能なスペースを埋めます
              child: ListView.builder(
            itemCount: listPrincipal.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${listPrincipal[index].annee}-${listPrincipal[index].month}-${listPrincipal[index].day}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(listPrincipal[index].affair,
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        '${listPrincipal[index].location}, ${listPrincipal[index].precise}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
