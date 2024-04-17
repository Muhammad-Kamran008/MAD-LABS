

import 'package:flutter/material.dart';
import 'ui/api_call_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Back From the Future',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Back From the Future'),
        ),
        body: ApiCallScreen(),
      ),
    );
  }
}


