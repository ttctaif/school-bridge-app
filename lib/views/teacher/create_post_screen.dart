import 'package:flutter/material.dart';

import '../../models/announcement_model.dart';
import '../../models/mock_data.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _data = MockData.instance;
  final _title = TextEditingController();
  final _body = TextEditingController();
  late final _subjects = _data.subjectsForTeacher(MockData.currentTeacherId);
  late String _subjectId = _subjects.first.id;
  AnnouncementType _type = AnnouncementType.homework;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  void _publish() {
    if (_title.text.trim().isEmpty || _body.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('أكملي العنوان والنص')));
      return;
    }
    _data.addAnnouncement(AnnouncementModel(
      id: _data.nextId('a'),
      subjectId: _subjectId,
      type: _type,
      title: _title.text.trim(),
      body: _body.text.trim(),
      createdAt: DateTime.now(),
    ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعلان جديد')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            value: _subjectId,
            decoration: const InputDecoration(
                labelText: 'المادة والفصل', border: OutlineInputBorder()),
            items: [
              for (final s in _subjects)
                DropdownMenuItem(
                    value: s.id, child: Text('${s.name} - ${s.classLabel}')),
            ],
            onChanged: (v) => setState(() => _subjectId = v!),
          ),
          const SizedBox(height: 16),
          SegmentedButton<AnnouncementType>(
            segments: [
              for (final t in AnnouncementType.values)
                ButtonSegment(value: t, label: Text(t.label)),
            ],
            selected: {_type},
            onSelectionChanged: (s) => setState(() => _type = s.first),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _title,
            decoration: const InputDecoration(
                labelText: 'العنوان', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _body,
            maxLines: 6,
            decoration: const InputDecoration(
                labelText: 'المحتوى', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            icon: const Icon(Icons.send),
            label: const Text('نشر'),
            onPressed: _publish,
          ),
        ],
      ),
    );
  }
}
