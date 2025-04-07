import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Save additional user data to Firestore with specific error handling
      if (userCredential.user != null) {
        try {
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
                'fullName': fullName,
                'email': email,
                'createdAt': FieldValue.serverTimestamp(),
              });
        } catch (firestoreError) {
          // Log Firestore-specific error but don't fail the auth
          print('Firestore error: $firestoreError');
          // We still return the credential since auth succeeded
        }
      }

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get user data from Firestore
  Future<Map<String, dynamic>?> getUserData() async {
    if (currentUser == null) return null;

    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(currentUser!.uid).get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }

      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  // Update user data in Firestore
  Future<void> updateUserData(Map<String, dynamic> userData) async {
    if (currentUser == null) return;

    try {
      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .update(userData);
    } catch (e) {
      // If document doesn't exist, create it
      if (e is FirebaseException && e.code == 'not-found') {
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .set(userData);
      } else {
        print('Error updating user data: $e');
        rethrow;
      }
    }
  }

  // Password reset
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
