import 'package:chronomap_mobile/register_page.dart';
import 'package:flutter/material.dart';
import 'search_page.dart';

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

            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  // todo テキストをかっこよくする。
                  child: Text('This is a simplified version of\n'
                      '"When-Where-What-Database".\n'
                      'The full version is available for use\n'
                      'on computers and tablets.\n'
                      'https://app.laporte.academy'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Registration",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Search & View",
                    ),
                  ),
                ),
              ],
            ),],
        ),
      ),
    );
  }
}