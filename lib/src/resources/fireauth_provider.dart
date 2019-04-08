import 'package:firebase_auth/firebase_auth.dart';

class FireauthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> authenticateUser(String email, String password) async {
    final FirebaseUser user = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((onError) => Future(() => throw onError));
    return user;
  }

  Future<FirebaseUser> registerUser(String email, String password) async {
    final FirebaseUser user = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((onError) => Future(() => throw onError));
    return user;
  }

  Future<void> recoveryPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logoutUser() async {
    await _firebaseAuth.signOut();
  }
}
