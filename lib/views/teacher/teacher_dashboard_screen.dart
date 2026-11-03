import 'package:flutter/material.dart';

import '../../core/utils/format_utils.dart';
import '../../models/mock_data.dart';
import 'create_post_screen.dart';
import 'inquiries_inbox_screen.dart';

class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = MockData.instance;
    return Scaffold(
      appBar: AppBar(title: const Text(MockData.currentTeacherName)),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('إعلان جديد'),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CreatePostScreen())),
      ),
      body: ListenableBuilder(
        listenable: data,
        builder: (context, _) {
          final subjects = data.subjectsForTeacher(MockData.currentTeacherId);
          final pending =
              data.pendingCountForTeacher(MockData.currentTeacherId);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  leading: Badge(
                    isLabelVisible: pending > 0,
                    label: Text('$pending'),
                    child: const Icon(Icons.inbox_outlined),
                  ),
                  title: const Text('صندوق الاستفسارات'),
                  subtitle: Text(pending > 0
                      ? '$pending استفسار بانتظار الرد'
                      : 'لا توجد استفسارات معلقة'),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const InquiriesInboxScreen())),
                ),
              ),
              const SizedBox(height: 16),
              Text('الفصول والمواد المسندة',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              for (final s in subjects)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.class_outlined),
                    title: Text('${s.name} - ${s.classLabel}'),
                    subtitle: Text(
                        'ساعات الرد: ${formatWorkWindow(s.workStart, s.workEnd)}'),
                    trailing: Text(
                        '${data.announcementsFor(s.id).length} منشور'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
