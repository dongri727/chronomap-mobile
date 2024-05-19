import 'package:flutter/material.dart';
import 'package:chronomap_mobile/register/register_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameBottomSheet extends StatelessWidget {
  const GameBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.blue[200],
      child: Column(
        children: [
          Text(AppLocalizations.of(context)!.gameAlertA),
          Text(AppLocalizations.of(context)!.gameAlertB),
          TextButton(
            child: Text(AppLocalizations.of(context)!.gameAlertC),
            onPressed: () {
              Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
            },
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.gameAlertD),
            onPressed: () {
              Navigator.of(context).pop(); // ダイアログを閉じる
              // setState(() {
              //   selectCountry = false; // 国を選ぶステップに戻る
              // });
            },
          ),
        ],
      ),
    );
  }
}
