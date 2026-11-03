import 'package:flutter/material.dart';

import '../../core/utils/format_utils.dart';
import '../../models/mock_data.dart';
import '../../models/student_model.dart';
import 'subject_details_screen.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  final _data = MockData.instance;
  late StudentModel _student = _data.students.first;

  @override
  Widget build(BuildContext context) {
    final subjects = _data.subjectsForStudent(_student);
    return Scaffold(
      appBar: AppBar(
        title: _StudentSwitcher(
          students: _data.students,
          selected: _student,
          onChanged: (s) => setState(() => _student = s),
        ),
      ),
      body: ListenableBuilder(
        listenable: _data,
        builder: (context, _) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: subjects.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final subject = subjects[i];
            final latest = _data.latestFor(subject.id);
            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SubjectDetailsScreen(
                      subject: subject, studentName: _student.firstName),
                )),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              child: Text(subject.name.characters.first)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(subject.name,
                                    style:
                                        Theme.of(context).textTheme.titleMedium),
                                Text(subject.teacherName),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_left),
                        ],
                      ),
                      const Divider(height: 24),
                      if (latest == null)
                        const Text('لا توجد إعلانات بعد')
                      else ...[
                        Row(
                          children: [
                            Chip(
                              label: Text(latest.type.label),
                              visualDensity: VisualDensity.compact,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(latest.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(formatDateTime(latest.createdAt),
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StudentSwitcher extends StatelessWidget {
  final List<StudentModel> students;
  final StudentModel selected;
  final ValueChanged<StudentModel> onChanged;

  const _StudentSwitcher({
    required this.students,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final label = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(selected.name, style: Theme.of(context).textTheme.titleMedium),
        Text(selected.gradeLabel, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
    if (students.length < 2) return label;
    return PopupMenuButton<StudentModel>(
      tooltip: 'تبديل الطالبة',
      onSelected: onChanged,
      itemBuilder: (_) => [
        for (final s in students)
          PopupMenuItem(value: s, child: Text('${s.name} - ${s.gradeLabel}')),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [label, const Icon(Icons.arrow_drop_down)],
      ),
    );
  }
}
