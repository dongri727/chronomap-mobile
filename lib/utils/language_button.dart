import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LanguageDropdownButton extends StatefulWidget {
  const LanguageDropdownButton({super.key});

  @override
  LanguageDropdownButtonState createState() => LanguageDropdownButtonState();
}

class LanguageDropdownButtonState extends State<LanguageDropdownButton> {
  String? currentLanguage = 'ja';  // 初期値として'ja' (日本の国旗) を設定

  void _changeLanguage(String languageCode) async {
    Locale newLocale = Locale(languageCode);

    // 言語を保存する
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);

    MyApp.setLocale(context, newLocale); // MyApp内のsetLocaleメソッドを呼び出し

    // setStateを呼び出して、UIを更新
    setState(() {
      currentLanguage = languageCode;  // 現在の言語を更新
    });

    print('現在のlanguageCodeは、$languageCode');
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentLanguage,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            currentLanguage = newValue;
            _changeLanguage(newValue);  // 選択された言語コードを_changeLanguageに渡す
          });
        }
      },
      items: <String>['en', 'ja', 'fr']  // 言語コードのリスト
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value == 'en' ? '🇬🇧' : value == 'ja' ? '🇯🇵' : '🇫🇷'),  // 国旗の表示
        );
      }).toList(),
    );
  }
}
