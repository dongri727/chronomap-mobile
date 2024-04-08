import 'package:chronomap_mobile/register_page.dart';
import 'package:flutter/material.dart';
import 'search_page.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Index'),
      ),
      body: Center(
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: SizedBox(
                height: 300,
              ),
            ),
            Expanded(
                flex: 4,
                child: Column(
                  children: [
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
                )
            ),],
        ),
      ),
    );
  }
}