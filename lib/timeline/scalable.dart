import "package:acorn_client/acorn_client.dart";
import "package:chronomap_mobile/search_page.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "../utils/confirm_text.dart";
import "../utils/shadowed_container.dart";
import 'bloc_provider.dart';
import 'pont_data.dart';
import "menu_section.dart";
import "widget.dart";

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


  /// Helper function which sets the [MenuItemData] for the [TimelineWidget].
  /// This will trigger a transition from the current menu to the Timeline,
  /// thus the push on the [Navigator], this widget will know where to scroll to.
  navigateToTimeline(MenuItemData item, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) =>
          TimelineWidget(item, BlocProvider.getTimeline(context)),
    ));
  }

/*  @override
  initState() {
    super.initState();

    /// The [_menu] loads a JSON file that's stored in the assets folder.
    /// This asset provides all the necessary information.
    _menu.loadFromBundle("assets/menu.json").then((bool success) {
      if (success) setState(() {}); // Load the menu.
    });
  }*/

  @override
  void initState() {
    super.initState();

    /// Initialize the menu with hardcoded data.
    _menu.initializeWithDefaultData();

    /// Notify the framework that the internal state of this object has changed.
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    final timeline = BlocProvider.getTimeline(context);

/*    String displayText;
    if (widget.principal!.isNotEmpty) {
      displayText = widget.principal![0].affair;
      if (widget.principal!.length > 1) {
        displayText += ' +etc';
      }
    } else {
      displayText = '';
    }*/

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push<String>(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
          title: const Text("SCALABLE"),
        ),
        endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 70,
              child: const DrawerHeader(
                child: Text('VIEW CHOICE',style: TextStyle(fontSize: 18),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                // leading: Icon(Icons.circle,),
                title: const Text('CLASSIC'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
            child: ListTile(
              // leading: Icon(Icons.settings),
              title: const Text('SCALABLE'),
              onTap: () {
                Navigator.pop(context);
              },
            ),),
            // More ListTiles...
          ],
        ),
      ),
        body: Padding(
          padding: EdgeInsets.only(top: devicePadding.top),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ShadowedContainer(
                    child: TextButton(
                        child: const Text(
                          "1. SUBMIT",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          timeline.gatherEntries(widget.principal);
                        }
                    ),
                  ),
                ),
                ..._menu.sections
                    .map<Widget>(
                        (MenuSectionData section) => Builder(builder: (context) {
                      return MenuSection(
                        section.label,
                        section.backgroundColor,
                        section.textColor,
                        section.items,
                            (item, context) =>
                            navigateToTimeline(item, context),
                      );
                    }))
                    //.toList(growable: false)
              ]),
        )
    );
  }
}