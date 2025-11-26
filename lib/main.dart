import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crudnote/auth_service.dart';
import 'package:firebase_crudnote/firebase_options.dart';
import 'package:firebase_crudnote/home_page.dart';
import 'package:firebase_crudnote/login_page.dart';
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
    return MaterialApp(
      title: 'Firebase Crud Note',
      theme: ThemeData(primarySwatch: Colors.green),
      home: StreamBuilder(
        stream: AuthService().userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData){
            return HomePage();
          } else {
            return LoginPage();
          }
        }
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
