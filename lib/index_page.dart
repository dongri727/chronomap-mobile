import 'package:chronomap_mobile/register/register_page.dart';
import 'package:chronomap_mobile/serverpod_client.dart';
import 'package:chronomap_mobile/utils/shadowed_container.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_apple_flutter/serverpod_auth_apple_flutter.dart';

import 'acount/acount_page.dart';

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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ShadowedContainer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.lightGreen[100],
                  ),
                
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                            '『四次元年表』のデータベースは\n'
                                '英語表記で運用されています。\n'
                            '日本語で新規登録されたものも \n'
                            '順次、英語に変換されますので\n'
                                'ご了承ください。 \n'
                        'フルバージョンをご利用の場合は\n'
                            'PCやタブレットなどの広い画面から\n'
                        '以下にアクセスしてください。\n'
                        'https://app.laporte.academy\n',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ShadowedContainer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.lightGreen[100],
                  ),

                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '国名の入力には\n'
                          '英語表記での予測変換が適用されます。\n'
                          'また\n'
                          'アメリカUnited States\n'
                          'イギリスはUnited Kingdom\n'
                          '大韓民国はSouth Korea\n'
                          '朝鮮民主主義人民共和国は\n'
                          'North Koreaとなります。\n',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
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