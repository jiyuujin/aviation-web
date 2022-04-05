import 'package:aviation_web/pages/auth_page.dart';
import 'package:aviation_web/pages/top_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Web Auth',
      theme: ThemeData(primaryColor: Colors.red),
      home: FutureBuilder<Object>(
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
                  return const TopPage();
                });
          }),
    );
  }
}
