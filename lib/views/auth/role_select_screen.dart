import 'package:flutter/material.dart';

import '../parent/parent_home_screen.dart';
import '../teacher/teacher_dashboard_screen.dart';

/// Temporary entry point for the MVP; replaced by real login later.
class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.school, size: 72, color: Colors.teal),
                const SizedBox(height: 12),
                Text('جسر المدرسة',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 4),
                const Text('تواصل منظم وآمن بين البيت والمدرسة',
                    textAlign: TextAlign.center),
                const SizedBox(height: 32),
                FilledButton.icon(
                  icon: const Icon(Icons.family_restroom),
                  label: const Text('الدخول كولي أمر'),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ParentHomeScreen())),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.co_present),
                  label: const Text('الدخول كمعلمة'),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const TeacherDashboardScreen())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
