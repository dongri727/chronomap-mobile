import "package:acorn_client/acorn_client.dart";
import "package:flutter/material.dart";
import "../../serverpod_client.dart";
import '../bloc_provider.dart';
import 'menu_data.dart';
import "menu_section.dart";
import "../timeline/widget.dart";
import 'package:chronomap_mobile/utils/countries_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Scalable extends StatefulWidget {
  final List<Principal>? principal;
  const Scalable({ super.key , this.principal});

  @override
  ScalableState createState() => ScalableState();
}

class ScalableState extends State<Scalable> {


  /// [MenuData] selects era witch will be displayed at the Timeline
  /// This data is loaded from the asset bundle during [initState()]
  final MenuData _menu = MenuData();

  List<Principal> listPrincipal = [];
  List<int> principalIds = [];

  TextEditingController searchController = TextEditingController();

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


  /// Helper function which sets the [MenuItemData] for the [TimelineWidget].
  /// This will trigger a transition from the current menu to the Timeline,
  /// thus the push on the [Navigator], this widget will know where to scroll to.
  navigateToTimeline(MenuItemData item, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) =>
          TimelineWidget(item, BlocProvider.getTimeline(context)),
    ));
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

    /// Initialize the menu with hardcoded data.
    _menu.initializeWithDefaultData();

    /// Notify the framework that the internal state of this object has changed.
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    //EdgeInsets devicePadding = MediaQuery.of(context).padding;
    final timeline = BlocProvider.getTimeline(context);

    List<Widget> tail = [];

    tail
        .addAll(_menu.sections
        .map<Widget>((MenuSectionData section) => Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: MenuSection(
          section.label,
          section.backgroundColor,
          section.textColor,
          section.items,
          navigateToTimeline,
        )))
        .toList(growable: false)
    );

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("SCALABLE"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0,right: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.scalableA),
                    Row(
                      children: [
                        Expanded(
                          child: Autocomplete<String>(
                            optionsBuilder: (TextEditingValue textEditingValue) {
                              return options.where((String option) {
                                if (textEditingValue.text.isNotEmpty) {
                                  return option.contains(textEditingValue.text[0]
                                      .toUpperCase() +
                                      textEditingValue.text.substring(1).toLowerCase());
                                } else {
                                  return option.contains(textEditingValue.text);
                                }
                              });
                            },
                            onSelected: (String selection) {
                              searchController.text = selection;
                              print(selection);
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await fetchPrincipalByLocation(searchController.text);
                            timeline.gatherEntries(listPrincipal);
                          },
                          icon: const Icon(Icons.search),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text(AppLocalizations.of(context)!.scalableB),
                    ),
                  ] + tail),
            ),
          ),
        )
    );
  }
}