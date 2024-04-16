import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  final List<int> _items = List<int>.generate(5, (int index) => index);
  final Color correctColor = Colors.red.withOpacity(0.15);
  final Color IncorrectColor = Colors.blue.withOpacity(0.15);
  final List<String> ansewrs = ['first', 'second', 'third', 'fourth', 'fifth'];
  final List<Color> colors = List.filled(5, Colors.grey.withOpacity(0.15));
  late List<String> _options;
  int correctAnswer = 0;
  int incorrectAnswer = 0;

  @override
  initState() {
    super.initState();
    _options = List<String>.from(ansewrs)..shuffle();
    print(_items);
    print(ansewrs);
    print(_options);
    print(colors);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            child: ReorderableListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              children: <Widget>[
                for (int index = 0; index < _items.length; index += 1)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // 枠線の色
                        width: 1.0, // 枠線の幅
                      ),
                    ),
                    key: Key('$index'),
                    child: ListTile(
                      tileColor: colors[index],
                      title: Text(_options[_items[index]]),
                    ),
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
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, foregroundColor: Colors.white),
              onPressed: () {
                correctAnswer = 0;
                incorrectAnswer = 0;
                for (int index = 0; index < _items.length; index += 1) {
                  print(
                      'answer: ${ansewrs[index]} / option: ${_options[_items[index]]}');
                  if (ansewrs[index] == _options[_items[index]]) {
                    correctAnswer += 1;
                    colors[index] = correctColor;
                  } else {
                    incorrectAnswer += 1;
                    colors[index] = IncorrectColor;
                  }
                }
                setState(() {});
              },
              child: Text('Answer')),
          const SizedBox(
            height: 30,
          ),
          Text('Correct: $correctAnswer / Incorrect: $incorrectAnswer'),
        ],
      ),
    );
  }
}
