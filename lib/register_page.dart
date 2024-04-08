import 'package:flutter/material.dart';
import 'package:acorn_client/acorn_client.dart';
import 'main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {

  TextEditingController whatController = TextEditingController(); // 検索キーワードを入力するためのController




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register an Event'),
      ),
      body: Column( // Columnウィジェットを使用して、TextFieldとListView.builderを縦に並べます
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
