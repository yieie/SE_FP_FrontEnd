import 'package:flutter/material.dart';
import 'package:front_end/features/presentation/pages/sign_up_page.dart';
import 'package:front_end/injection_container.dart';
Future<void> main() async{
  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}