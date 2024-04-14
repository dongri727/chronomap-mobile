import 'package:chronomap_mobile/index_page.dart';
import 'package:chronomap_mobile/utils/navi_button.dart';
import 'package:flutter/material.dart';
import 'package:acorn_client/acorn_client.dart';
import 'main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {

  //todo 年代区分、年月日、国、出来事、の４項目を入力する。
  //todo 国についてはリストを用意し、オートコンプリートを使用する。

  TextEditingController whatController = TextEditingController(); // 検索キーワードを入力するためのController




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationButton(
          destinationPage: IndexPage(),
          buttonText: 'index',
        ),
        leadingWidth: 80,
        title: const Text('Register an Event'),
      ),
      body: Column( // Columnウィジェットを使用して、TextFieldとListView.builderを縦に並べます
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            //todo
            child: TextField(
              controller: whatController,
              decoration: const InputDecoration(
                labelText: "What Happened ?",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
