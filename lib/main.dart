import 'package:firebase_core/firebase_core.dart';
import 'package:flipr_assignment/firebase_options.dart';
import 'package:flipr_assignment/services/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterNativeSplash.remove();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flipr",
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent), useMaterial3: true),
      home: const AuthPage(),
    );
  }
}