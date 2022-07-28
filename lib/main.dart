import 'package:bankqrcodeproj/states/authen.dart';
import 'package:bankqrcodeproj/states/main_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (context) => const Authen(),
  '/mainHome': (context) => const MainHome(),
};

String? firstStates;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    FirebaseAuth.instance.authStateChanges().listen((event) { 
      if (event == null) {
        firstStates = '/authen';
        runApp(const MyApp());
      } else {
        firstStates = '/mainHome';
        runApp(const MyApp());
      }
    });
  });

  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      routes: map,
      initialRoute: firstStates ?? '/authen',
    );
  }
}
