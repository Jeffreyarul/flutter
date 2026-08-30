import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_2/main.dart';

void main() {
  testWidgets('Responsive app loads dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const ResponsiveStudentApp());

    expect(find.text('Responsive Student Dashboard'), findsOneWidget);
    expect(find.text('Students'), findsOneWidget);
    expect(find.text('Courses'), findsOneWidget);
  });
}
