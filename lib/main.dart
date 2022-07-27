import 'package:aviation_web/pages/auth_page.dart';
import 'package:aviation_web/pages/detail_page.dart';
import 'package:aviation_web/pages/new_flight_page.dart';
import 'package:aviation_web/pages/top_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return StreamBuilder<dynamic>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, user) {
                    if (user.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!user.hasData) return const AuthPage();
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('flights')
                          .orderBy('time', descending: true)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');

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
                                          await FirebaseAuth.instance.signOut();
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
                                        child: TopPage(),
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
                                          await FirebaseAuth.instance.signOut();
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
                                          await FirebaseAuth.instance.signOut();
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
                                        child: DetailPage(),
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
            }),
      ),
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'OVERVIEW', icon: Icons.app_registration),
  Choice(title: 'ADD', icon: Icons.add_alert),
  Choice(title: 'DETAIL', icon: Icons.airplane_ticket),
];
