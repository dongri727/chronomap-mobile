import 'package:acorn_client/acorn_client.dart';
import 'package:chronomap_mobile/main.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  final List<int> _items = List<int>.generate(5, (int index) => index);
  final List<String> ansewrs = [];
  List<String> options = [];
  int correctAnswer = 0;
  int incorrectAnswer = 0;
  bool answered = false;

  final List<Color> backgroundColors =
      List.filled(5, Colors.grey.withOpacity(0.15));
  final Color correctBackgroundColor = Colors.green.withOpacity(0.15);
  final List<Color> stringColors = List.filled(5, Colors.black);
  final Color incorrectStingColor = Colors.red;

  List<Principal> listPrincipal = [];
  List<int> principalIds = [];

  Future<void> fetchPrincipalByLocation() async {
    try {
      List<String> location = 'Japan'.split(',').map((e) => e.trim()).toList();
      listPrincipal = await client.principal.getPrincipal(keywords: location);
      principalIds = listPrincipal.map((item) => item.id as int).toList();
      for (int index = 0; index < 5; index += 1) {
        ansewrs.add(listPrincipal[index].affair);
      }
      options = List<String>.from(ansewrs)..shuffle();
      setState(() {});
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  void _answer() {
    correctAnswer = 0;
    incorrectAnswer = 0;
    answered = true;
    for (int index = 0; index < _items.length; index += 1) {
      if (ansewrs[index] == options[_items[index]]) {
        correctAnswer += 1;
        backgroundColors[index] = correctBackgroundColor;
      } else {
        incorrectAnswer += 1;
        stringColors[index] = incorrectStingColor;
      }
    }
    setState(() {});
  }

  void _retry() {
    for (int index = 0; index < 5; index += 1) {
      backgroundColors[index] = Colors.grey.withOpacity(0.15);
      stringColors[index] = Colors.black;
    }
    correctAnswer = 0;
    incorrectAnswer = 0;
    answered = false;
    options = List<String>.from(ansewrs)..shuffle();
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    fetchPrincipalByLocation();
    print(ansewrs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Page'),
      ),
      body: options.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !answered
                    ? const Text(
                        'Arrange items in chronological order',
                        style: TextStyle(fontSize: 18),
                      )
                    : Text(
                        'Correct: $correctAnswer / Incorrect: $incorrectAnswer',
                        style: const TextStyle(fontSize: 18),
                      ),
                const SizedBox(height: 40),
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
                            tileColor: backgroundColors[index],
                            title: Text(
                              options[_items[index]],
                              style: TextStyle(color: stringColors[index]),
                            ),
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
                  height: 40,
                ),
                !answered
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[600],
                            foregroundColor: Colors.white,
                            elevation: 2),
                        onPressed: _answer,
                        child: const Text('Answer'))
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey[800],
                            elevation: 2),
                        onPressed: _retry,
                        child: const Text('Retry')),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
