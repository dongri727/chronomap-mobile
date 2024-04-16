import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  final List<int> _items = List<int>.generate(5, (int index) => index);
  final List<String> _ansewrs = ['first', 'second', 'third', 'fourth', 'fifth'];
  late List<String> _options;

  @override
  initState() {
    super.initState();
    _options = List<String>.from(_ansewrs)..shuffle();
    print(_items);
    print(_ansewrs);
    print(_options);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReorderableListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            children: <Widget>[
              for (int index = 0; index < _items.length; index += 1)
                ListTile(
                  key: Key('$index'),
                  tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                  title: Text(_options[_items[index]]),
                ),
            ],
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final int item = _items.removeAt(oldIndex);
                _items.insert(newIndex, item);
              });
            },
          ),
          TextButton(onPressed: (){
            for (int index = 0; index < _items.length; index += 1) {
                print('answer: ${_ansewrs[_items[index]]} / option: ${_options[_items[index]]}');
              }
            }, child: Text('Print the first item'))
        ],
      ),
    );
  }
}
