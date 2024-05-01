import 'package:chronomap_mobile/scalable/bloc_provider.dart';
import 'package:chronomap_mobile/scalable/timeline/timeline.dart';
import 'package:chronomap_mobile/tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'serverpod_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServerpodClient();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      t: Timeline(Theme.of(context).platform),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChronoMap for Mobile',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xFF2f4f4f),
          //appBarTheme: AppBarTheme(color: Colors.indigo[300]),
          brightness: Brightness.light,
          textTheme: GoogleFonts.sawarabiMinchoTextTheme(),
        ),
        home: const TabWidget(),
      ),
    );
  }
}