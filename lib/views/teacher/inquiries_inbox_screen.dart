import 'package:flutter/material.dart';

class InquiriesInboxScreen extends StatelessWidget {
  const InquiriesInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الاستفسارات')),
      body: const Center(child: Text('صندوق الاستفسارات')),
    );
  }
}
