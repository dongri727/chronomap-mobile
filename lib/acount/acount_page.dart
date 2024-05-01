import 'package:chronomap_mobile/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

import '../index_page.dart';
import '../search_page.dart';
import '../serverpod_client.dart';
import 'acount_model.dart';


class AccountPage extends StatelessWidget {
  const AccountPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AccountModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Account Page'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Moving On'),
          onPressed: () {
            Navigator.push<String>(
              context,
              MaterialPageRoute(
                builder: (context) => sessionManager.isSignedIn
                    ? const RegisterPage()
                    : const SearchPage(),
              ),
            );
          },
        ),
        body: Consumer<AccountModel>(
            builder: (context, model, child) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/both.png'), fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(children: [
                        Expanded(
                            flex: 3,
                            child: ListView(children: [
                              ListTile(
                                contentPadding:
                                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                leading: CircularUserImage(
                                  userInfo: sessionManager.signedInUser,
                                  size: 42,
                                ),
                                title: Text(sessionManager.signedInUser!.userName,
                                    style:
                                    const TextStyle(color: Colors.white, fontSize: 20)),
                                subtitle: Text(sessionManager.signedInUser!.email ?? '',
                                    style:
                                    const TextStyle(color: Colors.white, fontSize: 20)),
                              )
                            ])),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () {
                                var userId = sessionManager.signedInUser?.id ?? 0;
                                model.fetchPrincipalByUserId(userId: userId);
                              },
                              child: const Text('My Events'),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () {
                                sessionManager.signOut();
                                Navigator.push<String>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const IndexPage(),
                                  ),
                                );
                              },
                              child: const Text('Sign out'),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      flex: 6,
                      child: ListView.builder(
                        itemCount: model.principal.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Card(
                              color: const Color(0xFFe6e6fa),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Text('${model.principal[index].annee}-${model.principal[index].month}-${model.principal[index].day}' ,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  title: Text(model.principal[index].affair,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  trailing: Text('${model.principal[index].location}, ${model.principal[index].precise}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),)
                  ],
                ),
              );}
        ),
      ),
    );
  }
}