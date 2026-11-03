import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'views/auth/role_select_screen.dart';

void main() {
  runApp(const SchoolBridgeApp());
}

class SchoolBridgeApp extends StatelessWidget {
  const SchoolBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'جسر المدرسة',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      home: const RoleSelectScreen(),
    );
  }
}
