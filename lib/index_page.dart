import 'package:chronomap_mobile/register/register_page.dart';
import 'package:chronomap_mobile/serverpod_client.dart';
import 'package:chronomap_mobile/utils/describe_card.dart';
import 'package:chronomap_mobile/utils/shadowed_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:serverpod_auth_apple_flutter/serverpod_auth_apple_flutter.dart';

import 'acount/acount_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  _IndexPageState createState() => _IndexPageState();

}

class _IndexPageState extends State<IndexPage> {
  bool _isVisible = false; // テキストの表示状態を管理するフラグ

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible; // 表示状態を切り替える
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('四次元年表 for mobile'),
      ),
      body: Center(
        child: Column(
          children: [
            IconButton(
                onPressed: _toggleVisibility,
                icon: const Icon(
                    Icons.question_mark_sharp,
                  color: Colors.green),
                ),
            Visibility(
              visible: _isVisible,
              child: Column(
                children: [
                  const CustomTextContainer(textContent:
                    '『四次元年表』のうち\n'
                    '必須項目の入力\n'
                    '国別検索のみご利用いただけます。\n'
                    '詳細登録、各種検索等\n'
                    'フルバージョンをご利用の場合は\n'
                    'PCやタブレットなどの広い画面から\n'
                    '以下にアクセスしてください。\n'
                    'https://app.laporte.academy',
                  ),
                const CustomTextContainer(textContent:
              '『四次元年表』のデータベースは\n'
                  '英語表記で運用されています。\n'
                  '国名は予測変換を用いて \n'
                  '必ず英語で登録してください。\n'
                  'できごとを日本語で登録された場合\n、'
                  '順次、英語に修正されます。'
              ),
                const CustomTextContainer(textContent:
                  '国名の先頭文字を入力して選択してください。\n'
                  'アメリカUnited States\n'
                  'イギリスはUnited Kingdom\n'
                  '大韓民国はSouth Korea\n'
                  '朝鮮民主主義人民共和国は\n'
                  'North Koreaとなります。',
              ),
                IconButton(
                  onPressed: _toggleVisibility,
                  icon: const Icon(
                      Icons.thumb_up_alt_sharp,
                    color: Colors.green,
                  )),
                      ]),
            ),


/*            SignInWithAppleButton(
                caller: client.modules.auth,
              onSignedIn: () {
                  Navigator.push<String>(
                    context,
                    MaterialPageRoute(builder: (context) => const AccountPage()),
                  );
              },
            ),*/
          ],
        ),
      ),
    );
  }
}