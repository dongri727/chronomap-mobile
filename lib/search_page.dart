import 'package:chronomap_mobile/timeline/scalable.dart';
import 'package:chronomap_mobile/utils/button.dart';
import 'package:flutter/material.dart';
import 'package:acorn_client/acorn_client.dart';
import 'main.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<Principal> listPrincipal = [];
  List<int> principalIds = [];
  TextEditingController searchController = TextEditingController(); // 検索キーワードを入力するためのController

  Future<void> fetchPrincipalByLocation(String keywords) async {
    try {
      // 文字列をリストに変換してkeywords引数を渡す
      List<String> location = keywords.split(',').map((e) => e.trim()).toList();
      listPrincipal = await client.principal.getPrincipal(keywords: location);
      print("Getting principal with keywords: $location");
      principalIds = listPrincipal.map((item) => item.id as int).toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChronoMap Search'),
      ),
      body: Column( // Columnウィジェットを使用して、TextFieldとListView.builderを縦に並べます
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "Witch Country's History do you search?",
              ),
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
                    onPressed: () => fetchPrincipalByLocation(searchController.text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonFormat(
                    label: 'SCALABLE',
                    onPressed: _onScalablePressed),
              )
            ],
          ),
          Expanded( // ListView.builderをExpandedで囲むことで、利用可能なスペースを埋めます
            child: ListView.builder(
              itemCount: listPrincipal.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Text(
                      '${listPrincipal[index].annee}-${listPrincipal[index].month}-${listPrincipal[index].day}',
                      style: const TextStyle(fontSize: 11),
                    ),
                    title: Text(
                      listPrincipal[index].affair,
                      style: const TextStyle(fontSize: 11),
                    ),
                    //TEST
                    subtitle: Text(
                      'Test',
                      style: const TextStyle(fontSize: 11),
                    ),
                    //TEST
                    trailing: Text(
                      '${listPrincipal[index].location}, ${listPrincipal[index].precise}',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                );
              },
            )
          ),
        ],
      ),
    );
  }
}
