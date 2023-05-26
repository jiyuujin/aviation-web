import 'package:aviation_web/hooks/use_firebase.dart';
import 'package:aviation_web/hooks/use_firebase_auth.dart';
import 'package:aviation_web/pages/auth_page.dart';
import 'package:aviation_web/pages/new_flight_page.dart';
import 'package:aviation_web/pages/primary_page.dart';
import 'package:aviation_web/pages/secondary_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Web Auth',
      theme: ThemeData(primaryColor: Colors.red),
      home: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Object>(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return TopApp();
            }),
      ),
    );
  }
}

class TopApp extends StatelessWidget {
  TopApp({super.key});

  final firebaseHook = useFirebase();
  final firebaseAuthHook = useFirebaseAuth();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
        stream: firebaseAuthHook.authStateChanges(),
        builder: (context, user) {
          if (user.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!user.hasData) return const AuthPage();
          return StreamBuilder(
            stream: firebaseHook.fetchItems(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Text('Loading...');
                default:
                  return DefaultTabController(
                    length: choices.length,
                    child: TabBarView(children: [
                      Scaffold(
                        appBar: AppBar(
                          title: const Text('Aviation Web'),
                          actions: [
                            ElevatedButton.icon(
                              icon: const Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Sign out',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                firebaseAuthHook.signOut();
                              },
                            )
                          ],
                          bottom: TabBar(
                            tabs: choices.map((Choice choice) {
                              return Tab(
                                text: choice.title,
                                icon: Icon(choice.icon),
                              );
                            }).toList(),
                          ),
                        ),
                        body: Column(
                          children: [
                            Expanded(
                              child: PrimaryPage(),
                            ),
                          ],
                        ),
                      ),
                      Scaffold(
                        appBar: AppBar(
                          title: const Text('Aviation Web'),
                          actions: [
                            ElevatedButton.icon(
                              icon: const Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Sign out',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                firebaseAuthHook.signOut();
                              },
                            )
                          ],
                          bottom: TabBar(
                            tabs: choices.map((Choice choice) {
                              return Tab(
                                text: choice.title,
                                icon: Icon(choice.icon),
                              );
                            }).toList(),
                          ),
                        ),
                        body: Column(
                          children: [
                            Expanded(
                              child: SecondaryPage(),
                            ),
                          ],
                        ),
                      ),
                      Scaffold(
                        appBar: AppBar(
                          title: const Text('Aviation Web'),
                          actions: [
                            ElevatedButton.icon(
                              icon: const Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Sign out',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                firebaseAuthHook.signOut();
                              },
                            )
                          ],
                          bottom: TabBar(
                            tabs: choices.map((Choice choice) {
                              return Tab(
                                text: choice.title,
                                icon: Icon(choice.icon),
                              );
                            }).toList(),
                          ),
                        ),
                        body: Column(
                          children: const [
                            Expanded(
                              child: NewFlightPage(),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  );
              }
            },
          );
        });
  }
}

class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'OVERVIEW', icon: Icons.app_registration),
  Choice(title: 'DETAIL', icon: Icons.airplane_ticket),
  Choice(title: 'ADD', icon: Icons.add_alert),
];
