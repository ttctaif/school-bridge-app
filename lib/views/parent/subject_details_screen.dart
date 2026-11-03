import 'package:flutter/material.dart';

import '../../core/utils/format_utils.dart';
import '../../models/announcement_model.dart';
import '../../models/inquiry_model.dart';
import '../../models/mock_data.dart';
import '../../models/subject_model.dart';
import 'new_inquiry_sheet.dart';

class SubjectDetailsScreen extends StatelessWidget {
  final SubjectModel subject;
  final String studentName;

  const SubjectDetailsScreen({
    super.key,
    required this.subject,
    required this.studentName,
  });

  @override
  Widget build(BuildContext context) {
    final data = MockData.instance;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subject.name),
            Text(subject.teacherName,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
      body: ListenableBuilder(
        listenable: data,
        builder: (context, _) {
          final posts = data.announcementsFor(subject.id);
          final myInquiries =
              data.inquiriesForParent(MockData.currentParentId, subject.id);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const _BroadcastBanner(),
              const SizedBox(height: 12),
              if (posts.isEmpty) const Center(child: Text('لا توجد إعلانات بعد')),
              for (final p in posts) _PostCard(post: p),
              if (myInquiries.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text('استفساراتي',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                for (final q in myInquiries) _MyInquiryCard(inquiry: q),
              ],
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: FilledButton.icon(
            icon: const Icon(Icons.chat_bubble_outline),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('اسأل المعلمة بخصوص ابنتي'),
            ),
            onPressed: () => showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              showDragHandle: true,
              builder: (_) =>
                  NewInquirySheet(subject: subject, studentName: studentName),
            ),
          ),
        ),
      ),
    );
  }
}

class _BroadcastBanner extends StatelessWidget {
  const _BroadcastBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.campaign_outlined),
          SizedBox(width: 8),
          Expanded(
            child: Text(
                'قناة نشر من المعلمة فقط. للاستفسار استخدمي زر السؤال أدناه.'),
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final AnnouncementModel post;
  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    final isHomework = post.type == AnnouncementType.homework;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(isHomework ? Icons.assignment : Icons.menu_book,
                    size: 20),
                const SizedBox(width: 8),
                Text(post.type.label,
                    style: Theme.of(context).textTheme.labelLarge),
                const Spacer(),
                Text(formatDateTime(post.createdAt),
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 8),
            Text(post.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(post.body),
          ],
        ),
      ),
    );
  }
}

class _MyInquiryCard extends StatelessWidget {
  final InquiryModel inquiry;
  const _MyInquiryCard({required this.inquiry});

  @override
  Widget build(BuildContext context) {
    final answered = inquiry.status == InquiryStatus.answered;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(inquiry.question),
        subtitle: Text(answered
            ? 'الرد: ${inquiry.answer}'
            : '${inquiry.category.label} - بانتظار الرد'),
        trailing: Icon(answered ? Icons.check_circle : Icons.schedule,
            color: answered ? Colors.green : Colors.orange),
      ),
    );
  }
}
