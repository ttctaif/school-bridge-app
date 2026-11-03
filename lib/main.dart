import 'package:flutter/material.dart';

import 'views/parent/parent_home_screen.dart';

void main() {
  runApp(const SchoolBridgeApp());
}

class SchoolBridgeApp extends StatelessWidget {
  const SchoolBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Bridge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const ParentHomeScreen(),
    );
  }
}
