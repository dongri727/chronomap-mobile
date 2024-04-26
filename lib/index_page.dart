import 'package:chronomap_mobile/game_page.dart';
import 'package:chronomap_mobile/register/register_page.dart';
import 'package:chronomap_mobile/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'search_page.dart';
import 'package:serverpod_auth_apple_flutter/serverpod_auth_apple_flutter.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('四次元年表 for mobile'),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              // todo テキストをかっこよくする。
              child: Text(
                  'This is a simplified version of\n'
                  '"When-Where-What-Database".\n'
                  'The full version is available for use\n'
                  'on computers and tablets.\n'
                  'https://app.laporte.academy\n'
                  '\n'
                  'これは『四次元年表』簡易版です。 \n'
                  'フルバージョンを利用する場合は\n'
                      'PCやタブレットなどの広い画面から\n'
                  '以下にアクセスしてください。\n'
                  'https://app.laporte.academy\n'

              ),
            ),
            SignInWithAppleButton(
                caller: client.modules.auth,
              onSignedIn: () {
                  Navigator.push<String>(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
              },

            ),
          ],
        ),
      ),
    );
  }
}