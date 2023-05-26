import 'package:firebase_auth/firebase_auth.dart';

UseFirebaseAuth useFirebaseAuth() {
  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  return UseFirebaseAuth(signIn: signIn, signUp: signUp, signOut: signOut);
}

class UseFirebaseAuth {
  final Future<void> Function(String email, String password) signIn;
  final Future<void> Function(String email, String password) signUp;
  final Future<void> Function() signOut;
  UseFirebaseAuth(
      {required this.signIn, required this.signUp, required this.signOut});
}
