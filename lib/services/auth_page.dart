import 'package:firebase_auth/firebase_auth.dart';
import 'package:flipr_assignment/screens/home_screen.dart';
import 'package:flipr_assignment/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return const HomeScreen();
            }
            else{
              return const WelcomeScreen();
            }
          }),
    );
  }
}
