import 'package:firebase_auth/firebase_auth.dart';

class FbAuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return null;
    }
  }

  Future<UserCredential?> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return null;
    }
  }

  Future<UserCredential?> loginAsVisitor() async {
    try {
      return await _auth.signInAnonymously();
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
