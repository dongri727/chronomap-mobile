import 'package:chronomap_mobile/utils/describe_card.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CustomTextContainer(textContent:
              'このアプリは、あなたのどんな個人情報も一切取得しませんし、あなたのデバイス中の情報を追跡、利用することもありません。'),
              CustomTextContainer(textContent:
              'あなたが登録してくださった歴史情報があなたと紐付けられることはありません。あなたがなにを登録し、なにを検索したかはについて、記録は一切残りません。'),
              CustomTextContainer(textContent:
              '『四次元年表』とは宇宙の始原から終わりなき「今」に至る、全ての歴史的事象を、分野にかかわらず網羅するデータベースです。「いつ」だけでなく、｢どこで｣を必須項目とし、時間的距離、空間的距離を正しく表示することを目指します。\n'
                'Web版『四次元年表』\nhttps://app.laporte.academy\n'
                'Web版三次元・四次元表示\nhttps://tempo-spaco.web.app\n'
                '四次元年表の使い方\nhttps://youtube.com/@laporte_academy'),
              CustomTextContainer(textContent:
              '『四次元年表』における歴史的事象とは、「いつ、どこで」の情報を備えた、単一のできごとを指します。例えば「明治維新」は単一のできごととはみなされません。登録に際しては　「1868年４月11日　徳川慶喜　水戸へ　日本　東京（江戸）　寛永寺」のようになります。これを｢明治維新｣として検索可能にする場合は、web版｢四次元年表｣において、termに「明治維新」を追加してください。'),
              CustomTextContainer(textContent:
              '『四次元年表』の趣旨に反する情報は、運営者によって以下の対応を取ります。\n１、修正\n２、閲覧停止（将来公開される可能性あり）\n３、削除'),
              CustomTextContainer(textContent:
              '登録いただいた歴史情報は公共財として扱われ、登録したあなた自身でも削除することはできません。個人情報等を書き込まないようご注意ください。誤って登録した情報を削除したい場合、また、削除すべきと思われる情報を見つけた場合は、下記までご連絡ください。'),
              CustomTextContainer(textContent:
              '『四次元年表』開発をともにする方を求めています。Flutter、AWS、PostgreSQL, Unity等を扱えるエンジニアほか、データ入力やデータ修正等にご協力いただける方は、下記までご連絡ください。'),
              CustomTextContainer(textContent: 'when.where.what.database727@gmail.com'),



            ],
          ),
        ),
      )
    );
  }

}