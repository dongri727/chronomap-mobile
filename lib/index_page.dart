import 'package:chronomap_mobile/register/register_page.dart';
import 'package:chronomap_mobile/serverpod_client.dart';
import 'package:chronomap_mobile/utils/describe_card.dart';
import 'package:chronomap_mobile/utils/shadowed_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:serverpod_auth_apple_flutter/serverpod_auth_apple_flutter.dart';

import 'acount/acount_page.dart';
import 'info_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  IndexPageState createState() => IndexPageState();

}

class IndexPageState extends State<IndexPage> {
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
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, 
                    MaterialPageRoute(
                        builder: (context) => InfoPage()));
              }, 
              icon: const Icon(Icons.info_outline))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Visibility(
                visible: !_isVisible,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: _toggleVisibility,
                        icon: const Icon(
                            Icons.question_mark_sharp,
                            color: Colors.green),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60, 20, 60, 60),
                        child: ShadowedContainer(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                  child: Image.asset('assets/images/cover.png')),
                            )),
                      ),
                    ],
                  )
                  ),
              Visibility(
                visible: _isVisible,
                child: Column(
                  children: [
                    const CustomTextContainer(textContent:
                        '『四次元年表』のうち必須項目の入力と国別検索のみご利用いただけます。詳細登録、各種検索等フルバージョンをご利用の場合は、PCやタブレットなど広い画面から以下にアクセスしてください。\n'
                            'https://app.laporte.academy',
                    ),
                  const CustomTextContainer(textContent:
                      '『四次元年表』のデータベースは英語表記で運用されています。国名は予測変換を用いて、必ず英語で登録してください。なお、\n'
                          'アメリカUnited States\n'
                          'イギリスはUnited Kingdom\n'
                          '大韓民国はSouth Korea\n'
                          '朝鮮民主主義人民共和国はNorth Korea\nとなります。'
                ),
                    const CustomTextContainer(textContent:
                    '事象名を日本語で登録された場合、順次、英語に修正されますのでご了承ください。CLASSIC表示とゲームの事象名はコピーしてお手持ちの自動翻訳に掛けることができます。'
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
      ),
    );
  }
}