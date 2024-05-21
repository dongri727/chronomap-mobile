import 'package:flutter/material.dart';

class AutocompleteFormat extends StatefulWidget {
  final List<String> options;
  final TextEditingController searchController;
  final VoidCallback onSearch;

  const AutocompleteFormat({
    required this.options,
    required this.searchController,
    required this.onSearch,
    super.key,
  });

  @override
  AutocompleteFormatState createState() => AutocompleteFormatState();
}

class AutocompleteFormatState extends State<AutocompleteFormat> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              return widget.options.where((String option) {
                if (textEditingValue.text.isNotEmpty) {
                  return option.contains(textEditingValue.text[0].toUpperCase() +
                      textEditingValue.text.substring(1).toLowerCase());
                } else {
                  return option.contains(textEditingValue.text);
                }
              });
            },
            onSelected: (String selection) {
              widget.searchController.text = selection;
            },
          ),
        ),
        IconButton(
          onPressed: widget.onSearch,
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}

class GameAutocompleteFormat extends StatefulWidget {
  final List<String> value;
  final TextEditingController searchController;

  const GameAutocompleteFormat({
    required this.value,
    required this.searchController,
    super.key,
  });

  @override
  GameAutocompleteFormatState createState() => GameAutocompleteFormatState();
}

class GameAutocompleteFormatState extends State<GameAutocompleteFormat> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return widget.value.where((String value) {
          if (textEditingValue.text.isNotEmpty) {
            return value.contains(textEditingValue.text[0].toUpperCase() +
                textEditingValue.text.substring(1).toLowerCase());
          } else {
            return value.contains(textEditingValue.text);
          }
        });
      },
      onSelected: (String selection) {
        widget.searchController.text = selection;
      },
    );
  }
}

