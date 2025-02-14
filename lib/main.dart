import 'package:flutter/material.dart';
import 'package:todo/pages/register_page.dart';
import 'package:todo/routes/route.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => RegisterPage(),
        MyRoutes.registerRoute:(context) => RegisterPage()
      },
    );
  }
}
