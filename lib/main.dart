import 'package:firebase_core/firebase_core.dart';
import 'package:rd_investment_platform/firebase_options.dart';
import 'package:rd_investment_platform/services/gorouter.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: createRouter(),
      debugShowCheckedModeBanner: false,
    );
  }
}

