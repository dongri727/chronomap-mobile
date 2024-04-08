import 'package:acorn_client/acorn_client.dart';
import 'package:chronomap_mobile/search_page.dart';
import 'package:chronomap_mobile/timeline/bloc_provider.dart';
import 'package:chronomap_mobile/timeline/timeline.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

var client = Client('https://api.laporte.academy/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          brightness: Brightness.light,
        ),
        home: const SearchPage(),
      ),
    );
  }
}