import 'package:flutter/material.dart';

import '../../core/utils/format_utils.dart';
import '../../models/inquiry_model.dart';
import '../../models/mock_data.dart';
import '../../models/subject_model.dart';

class NewInquirySheet extends StatefulWidget {
  final SubjectModel subject;
  final String studentName;

  const NewInquirySheet({
    super.key,
    required this.subject,
    required this.studentName,
  });

  @override
  State<NewInquirySheet> createState() => _NewInquirySheetState();
}

class _NewInquirySheetState extends State<NewInquirySheet> {
  final _controller = TextEditingController();
  InquiryCategory _category = InquiryCategory.academic;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final data = MockData.instance;
    data.addInquiry(InquiryModel(
      id: data.nextId('q'),
      subjectId: widget.subject.id,
      parentId: MockData.currentParentId,
      studentName: widget.studentName,
      category: _category,
      question: text,
      createdAt: DateTime.now(),
    ));
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(
      const SnackBar(
          content: Text('تم إرسال الاستفسار، وسيصلك الرد في ساعات العمل')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final window =
        formatWorkWindow(widget.subject.workStart, widget.subject.workEnd);
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 0, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('استفسار جديد', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                for (final c in InquiryCategory.values)
                  ChoiceChip(
                    label: Text(c.label),
                    selected: _category == c,
                    onSelected: (_) => setState(() => _category = c),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'نص الاستفسار',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('ساعات الرد المعتمدة للمعلمة: $window.\n'
                        'يتم الرد على الاستفسارات خلال هذه الساعات فقط.'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.lock_outline, size: 16),
                SizedBox(width: 6),
                Expanded(
                  child: Text('أرقام الهواتف وبيانات الهوية لا تظهر للمعلمة.',
                      style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FilledButton(onPressed: _submit, child: const Text('إرسال')),
          ],
        ),
      ),
    );
  }
}
