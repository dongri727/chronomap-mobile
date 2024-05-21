import 'package:flutter/material.dart';

class AutocompleteWithClear extends StatefulWidget {
  final List<String> options;
  final TextEditingController searchController;
  final VoidCallback onSearch;
  final VoidCallback onPressed;

  const AutocompleteWithClear({
    required this.options,
    required this.searchController,
    required this.onSearch,
    required this.onPressed,
    super.key,
  });

  @override
  AutocompleteWithClearState createState() => AutocompleteWithClearState();
}

class AutocompleteWithClearState extends State<AutocompleteWithClear> {
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
            fieldViewBuilder: (BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted) {
              textEditingController.text = widget.searchController.text;
              textEditingController.addListener(() {
                widget.searchController.text = textEditingController.text;
              });
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: widget.onPressed,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              );
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

class GameAutocompleteWithClear extends StatefulWidget {
  final List<String> value;
  final TextEditingController searchController;
  final VoidCallback onPressed;

  const GameAutocompleteWithClear({
    required this.value,
    required this.searchController,
    required this.onPressed,
    super.key,
  });

  @override
  GameAutocompleteWithClearState createState() => GameAutocompleteWithClearState();
}

class GameAutocompleteWithClearState extends State<GameAutocompleteWithClear> {
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
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        textEditingController.text = widget.searchController.text;
        textEditingController.addListener(() {
          widget.searchController.text = textEditingController.text;
        });
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: widget.onPressed,
              icon: const Icon(Icons.clear),
            ),
          ),
        );
      },
    );
  }
}