import 'package:flutter/material.dart';
import 'package:flutter_agus/pages/post/list_post_screen.dart';
import 'package:flutter_agus/pages/post/quran/list_quran_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(title: Text('Fetch Data')),
        body: ListQuranScreen(),
      ),
    );
  }
}
