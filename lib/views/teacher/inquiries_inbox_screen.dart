import 'package:flutter/material.dart';

import '../../core/utils/format_utils.dart';
import '../../models/inquiry_model.dart';
import '../../models/mock_data.dart';

class InquiriesInboxScreen extends StatelessWidget {
  const InquiriesInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = MockData.instance;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الاستفسارات'),
          bottom: const TabBar(tabs: [
            Tab(text: 'بانتظار الرد'),
            Tab(text: 'تم الرد'),
          ]),
        ),
        body: ListenableBuilder(
          listenable: data,
          builder: (context, _) {
            final all = data.inquiriesForTeacher(MockData.currentTeacherId);
            return TabBarView(children: [
              _InquiryList(
                  items: all
                      .where((q) => q.status == InquiryStatus.pending)
                      .toList()),
              _InquiryList(
                  items: all
                      .where((q) => q.status != InquiryStatus.pending)
                      .toList()),
            ]);
          },
        ),
      ),
    );
  }
}

class _InquiryList extends StatelessWidget {
  final List<InquiryModel> items;
  const _InquiryList({required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const Center(child: Text('لا توجد استفسارات'));
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _InquiryCard(inquiry: items[i]),
    );
  }
}

class _InquiryCard extends StatelessWidget {
  final InquiryModel inquiry;
  const _InquiryCard({required this.inquiry});

  void _reply(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _ReplySheet(inquiry: inquiry),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subject = MockData.instance.subjectById(inquiry.subjectId);
    final answered = inquiry.status == InquiryStatus.answered;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Chip(
                  label: Text(inquiry.category.label),
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                      'ولي أمر ${inquiry.studentName} - ${subject.name}',
                      overflow: TextOverflow.ellipsis),
                ),
                Text(formatDateTime(inquiry.createdAt),
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 8),
            Text(inquiry.question),
            if (answered) ...[
              const Divider(height: 24),
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 18),
                  const SizedBox(width: 6),
                  Expanded(child: Text(inquiry.answer ?? '')),
                ],
              ),
            ] else ...[
              const SizedBox(height: 12),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: FilledButton.icon(
                  icon: const Icon(Icons.reply),
                  label: const Text('إرسال الإجابة'),
                  onPressed: () => _reply(context),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ReplySheet extends StatefulWidget {
  final InquiryModel inquiry;
  const _ReplySheet({required this.inquiry});

  @override
  State<_ReplySheet> createState() => _ReplySheetState();
}

class _ReplySheetState extends State<_ReplySheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    MockData.instance.answerInquiry(widget.inquiry.id, text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 0, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.inquiry.question),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            maxLines: 4,
            autofocus: true,
            decoration: const InputDecoration(
                labelText: 'الإجابة', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          FilledButton(onPressed: _send, child: const Text('إرسال الإجابة')),
        ],
      ),
    );
  }
}
