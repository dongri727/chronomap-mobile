import 'package:chronomap_mobile/index_page.dart';
import 'package:chronomap_mobile/register/register_model.dart';
import 'package:chronomap_mobile/utils/navi_button.dart';
import 'package:chronomap_mobile/utils/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/dropdown_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterModel>(
        create: (_) => RegisterModel(),
        child: Consumer<RegisterModel>(builder: (_, model, child) {
          return Scaffold(
            appBar: AppBar(
              leading: const NavigationButton(
                destinationPage: IndexPage(),
                buttonText: 'index',
              ),
              leadingWidth: 80,
              title: const Text('入力'),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  model.convertPoint();
                  int result = await model.save();
                  String title;
                  String content;

                  switch (result) {
                    case 0:
                      title = 'Succeeded';
                      content = 'Thank you for adding Information';
                      break;
                    case 1:
                      title = 'Failed';
                      content = 'Oops! Something went wrong...';
                      break;
                    case 2:
                      title = 'Failed';
                      content = 'Required fields are missing';
                      break;
                    default:
                      title = 'Unexpected Error';
                      content = 'Please try again later';
                      break;
                  }
                  model.showCustomDialog(context, title, content);
                },
                label: const Text('登録')),
            body: Column(
              children: [
                const Text('いつ'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomDropdownButton(
                    selectedValue: model.selectedCalendar,
                    options: model.periods,
                    onChanged: (value) {
                      model.setCalendar(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TffFormat(
                    hintText: 'year',
                    onChanged: (value) {
                      model.setNewYearD(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TffFormat(
                    hintText: "month 1-12 or 0",
                    onChanged: (value) {
                      model.setNewMonth(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TffFormat(
                    hintText: "date 1-31 or 0",
                    onChanged: (value) {
                      model.setNewDay(value);
                      print(value);
                    },
                  ),
                ),
                const Text('どの国で'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      } else {
                        return model.options.where((String option) {
                          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                        });
                      }
                    },
                    onSelected: (String selection) {
                      model.setSelectedCountry(selection);
                      print(selection);
                    },
                  ),
                ),
                const Text('なにがあった？'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TffFormat(
                    hintText: "",
                    onChanged: (text) {
                      model.setNewName(text);
                      print(text);
                    },
                  ),
                ),
              ],
            ),
          );
        })
    );
  }
}