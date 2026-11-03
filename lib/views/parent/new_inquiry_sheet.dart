import 'package:flutter/material.dart';

class NewInquirySheet extends StatelessWidget {
  final String subjectId;

  const NewInquirySheet({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        maxLines: 4,
        decoration: InputDecoration(labelText: 'نص الاستفسار'),
      ),
    );
  }
}
