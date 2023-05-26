import 'package:firebase_auth/firebase_auth.dart';

UseFirebaseAuth useFirebaseAuth() {
  Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  return UseFirebaseAuth(
      authStateChanges: authStateChanges,
      signIn: signIn,
      signUp: signUp,
      signOut: signOut);
}

class UseFirebaseAuth {
  final Stream<User?> Function() authStateChanges;
  final Future<void> Function(String email, String password) signIn;
  final Future<void> Function(String email, String password) signUp;
  final Future<void> Function() signOut;
  UseFirebaseAuth(
      {required this.authStateChanges,
      required this.signIn,
      required this.signUp,
      required this.signOut});
}
