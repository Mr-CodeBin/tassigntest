import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await sendEmailVerification();

    User? user = _firebaseAuth.currentUser;
    await FirebaseFirestore.instance.collection('teachers').doc(user!.uid).set({
      'name': name,
      'email': email,
    });
  }

  Future<void> sendEmailVerification() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      throw FirebaseAuthException(
        code: 'ERROR_EMAIL_NOT_VERIFIED',
        message: 'Email not verified',
      );
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
