import 'package:flutter_test/flutter_test.dart';
import 'package:school_bridge_app/main.dart';

void main() {
  testWidgets('shows role selection', (tester) async {
    await tester.pumpWidget(const SchoolBridgeApp());
    expect(find.text('الدخول كولي أمر'), findsOneWidget);
    expect(find.text('الدخول كمعلمة'), findsOneWidget);
  });
}
