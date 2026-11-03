import 'package:flutter/material.dart';

import '../../models/subject_model.dart';

class SubjectDetailsScreen extends StatelessWidget {
  final SubjectModel subject;

  const SubjectDetailsScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subject.name)),
      body: const Center(child: Text('الملخصات والواجبات')),
    );
  }
}
