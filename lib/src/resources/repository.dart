import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firestore_provider.dart';
import 'fireauth_provider.dart';
//import 'mlkit_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();
  final _fireauthProvider = FireauthProvider();
  //final _mlkitProvider = MLkitProvider();

  Future<FirebaseUser> authenticateUser(String email, String password) =>
      _fireauthProvider.authenticateUser(email, password);

  Future<void> registerUser(String email, String password) =>
      _fireauthProvider.registerUser(email, password);

  Future<void> logoutUser() => _fireauthProvider.logoutUser();
}
