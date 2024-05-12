import 'package:acorn_client/acorn_client.dart';
import 'package:chronomap_mobile/register/register_page.dart';
import 'package:flutter/material.dart';
import 'serverpod_client.dart';
import 'utils/countries_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => GamePageState();
}

class GamePageState extends State<GamePage> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _animation;

  List<String> values = [];
  void getCountries() {
    for (var country in countries) {
      values.add(country['name']);
    }
  }

  final List<int> _items = List<int>.generate(5, (int index) => index);
  List answers = [];
  List options = [];
  int correctAnswer = 0;
  int incorrectAnswer = 0;
  bool answered = false;
  bool selectCountry = false;

  final List<Color> backgroundColors =
      List.filled(5, Colors.grey.withOpacity(0.15));
  final Color correctBackgroundColor = Colors.green.withOpacity(0.15);
  final List<Color> stringColors = List.filled(5, Colors.black);
  final Color incorrectStingColor = Colors.red;

  List<Principal> listPrincipal = [];
  List<int> principalIds = [];

  Future<void> fetchPrincipalByLocation(String keywords) async {
    try {
      List<String> location = keywords.split(',').map((e) => e.trim()).toList();
      listPrincipal = await client.principal.getPrincipal(keywords: location);
      principalIds = listPrincipal.map((item) => item.id as int).toList();

      if (!mounted) return;

      if (listPrincipal.length < 5) {
        // データが5件に満たない場合、アラートを表示
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.gameAlertA),
              content: Text(AppLocalizations.of(context)!.gameAlertB),
              actions: <Widget>[
                TextButton(
                  child: Text(AppLocalizations.of(context)!.gameAlertC),
                  onPressed: () {
                    Navigator.push<String>(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()));
                  },
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.gameAlertD),
                  onPressed: () {
                    Navigator.of(context).pop(); // ダイアログを閉じる
                    setState(() {
                      selectCountry = false; // 国を選ぶステップに戻る
                    });
                  },
                ),
              ],
            );
          },
        );
      } else {
        // データが5件以上存在する場合、ゲームのオプションを設定
        for (var item in listPrincipal) {
          options.add([item.affair, item.point]);
        }
        options = List.from(options)..shuffle();
        options = options.sublist(0, 5);
        answers = List.from(options);
        answers.sort((a, b) => a[1].compareTo(b[1]));
        setState(() {});
      }
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> _answer() async {
    correctAnswer = 0;
    incorrectAnswer = 0;
    answered = true;
    for (int index = 0; index < _items.length; index += 1) {
      if (answers[index] == options[_items[index]]) {
        correctAnswer += 1;
        backgroundColors[index] = correctBackgroundColor;
      } else {
        incorrectAnswer += 1;
        stringColors[index] = incorrectStingColor;
      }
    }

    setState(() {});

    if (correctAnswer == _items.length) {
      _animationController.forward(from: 0.0).then((_) {
        _resetGame();
      });
    } else {
      _showRetryOrNewGameDialog();
    }
  }

  void _showRetryOrNewGameDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AlertDialog(
                backgroundColor: Colors.white.withOpacity(0.5),
                title: Text(AppLocalizations.of(context)!.gameDialogA),
                content: Text(AppLocalizations.of(context)!.gameDialogB),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _retry(); // 同じカードで再挑戦
                    },
                    child: Text(AppLocalizations.of(context)!.gameDialogC),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _resetGame(); // 新しいゲームを開始
                    },
                    child: Text(AppLocalizations.of(context)!.gameDialogD),
                  ),
                ],
              ),
            ],
          );
        }
    );
  }

  void _resetGame() {
    // ゲーム状態のリセット
    for (int index = 0; index < 5; index += 1) {
      backgroundColors[index] = Colors.grey.withOpacity(0.15);
      stringColors[index] = Colors.black;
    }
    correctAnswer = 0;
    incorrectAnswer = 0;
    answered = false;
    selectCountry = false;
    options.clear();
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
    options.shuffle();
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    getCountries();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
        vsync: this);
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn
    );
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
      ),
      body: !selectCountry
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(AppLocalizations.of(context)!.gameA,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 80.0),
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      return values.where((String value) {
                        if (textEditingValue.text.isNotEmpty) {
                          return value.contains(textEditingValue.text[0]
                                  .toUpperCase() +
                              textEditingValue.text.substring(1).toLowerCase());
                        } else {
                          return value.contains(textEditingValue.text);
                        }
                      });
                    },
                    onSelected: (String selection) {
                      searchController.text = selection;
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    fetchPrincipalByLocation(searchController.text);
                    selectCountry = true;
                  },
                  child: const Text('Start Game'),
                )
              ],
            )
          : options.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !answered
                        ? Text(AppLocalizations.of(context)!.gameB,
                            style: const TextStyle(fontSize: 18),
                          )
                        : Column(
                          children: [
                            Text(
                                '👍: $correctAnswer / 👎: $incorrectAnswer',
                                style: const TextStyle(fontSize: 18),
                              ),
                            FadeTransition(
                              opacity: _animation,
                              child: const Center(
                                child: Text(
                                  'Perfect!',
                                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.green),
                                ),
                              ),
                            )
                          ],
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
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.blueGrey, // 枠線の色
                                  width: 1.0, // 枠線の幅
                                ),
                              ),
                              key: Key('$index'),
                              child: ListTile(
                                tileColor: backgroundColors[index],
                                title: Text(
                                  options[_items[index]][0],
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
                       ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[600],
                                foregroundColor: Colors.white,
                                elevation: 2),
                            onPressed: _answer,
                            child: const Text('Answer'))
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }
}
