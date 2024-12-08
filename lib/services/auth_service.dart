import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up Email & Password
  Future<User?> signupWithEmailPass(String email, String password) async{
    try{
      final userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection("users").doc(userCredentials.user?.uid).set({
        "email": email,
        "createdAt": DateTime.now()
      });
      return userCredentials.user;
    }
    catch(e){
      throw Exception("Sign-up failed due to: $e");
    }
  }
  // Sign in Email & Password
  Future<User?> signinWithEmailPass(String email, String password) async{
    try{
      final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredentials.user;
    }
    catch(e){
      throw Exception("Login failed due to: $e");
    }
  }

  // Sign in with Google
  Future<User?> signinWithGoogle() async{
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credentials = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    try{
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credentials);
      return userCredential.user;
    }
    catch(e){
      throw UnimplementedError("Google Sign-in failed due to: $e");
    }
  }

  User? getCurrentUser(){
    return _firebaseAuth.currentUser;
  }

  // Fetch user details
  Future<Map<String, dynamic>?> fetchUserDetails(String uid) async{
    try{
      final DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if(doc.exists){
        return doc.data() as Map<String, dynamic>;
      }
    }
    catch(e){
      throw Exception("Failed to fetch user details: $e");
    }
    return null;
  }

  // Sign out function
  signOut() async{
    try{
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().disconnect();
      await GoogleSignIn().signOut();
      return true;
    }
    catch(e){
      ScaffoldMessenger.of(this as BuildContext).showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }
}