import 'package:flutter/material.dart';
import 'entry.dart';

class MenuSectionData {
  late String label;
  final Color textColor = Colors.yellow;
  final Color backgroundColor = Colors.white;
  List<MenuItemData> items = [];
}

/// Data container for all the sub-elements of the [MenuSection].
class MenuItemData {
  String label = "";
  double start = 0.0;
  double end = 0.0;
  bool pad = false;
  double padTop = 0.0;
  double padBottom = 0.0;

  MenuItemData();

  /// When initializing this object from a [TimelineEntry], fill in the
  /// fields according to the [entry] provided. The entry in fact specifies
  /// a [label], a [start] and [end] times.
  /// Padding is built depending on the type of the [entry] provided.
  MenuItemData.fromEntry(TimelineEntry entry) {
    label = entry.name;

    /// Pad the edges of the screen.
    pad = true;

    if (entry.type == TimelineEntryType.era) {
      start = entry.start;
      end = entry.end;
    }
  }
}

class MenuData {
  List<MenuSectionData> sections = [];

  void initializeWithDefaultData() {
    List<MenuSectionData> menu = [];
    MenuSectionData menuSection = MenuSectionData();

    menuSection.label = "2. Select Initial Display Era,  You can move, zoom freely after the transition";
    //menuSection.backgroundColor = const Color(0xFF2f4f4f); // Adjusted the color format
    //menuSection.textColor = const Color(0xFF9acd32); // Adjusted the color format

    // Items
    List<MenuItemData> items = [
      MenuItemData()..label = "ALL"..start = -5100000000000..end = 800000,
      MenuItemData()..label = "Billion Years Ago"..start = -5100000000000..end = -366000000000,
      MenuItemData()..label = "Million Years Ago"..start = -366000000000..end = -366000000,
      MenuItemData()..label = "Thousand Years Ago"..start = -366000000..end = -366000,
      MenuItemData()..label = "BCE"..start = -366000..end = 0,
      MenuItemData()..label = "CE"..start = 0..end = 700000,
      MenuItemData()..label = "20th Century"..start = 690000..end = 750000,
      MenuItemData()..label = "21th Century"..start = 730000..end = 800000,
    ];

    menuSection.items = items;
    menu.add(menuSection);

    sections = menu;
  }
}