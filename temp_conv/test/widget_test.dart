// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:temp_conv/main.dart';

void main() {
  testWidgets('Temperature conversion test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TemperatureConverterApp());

    // Verify that the initial UI is displayed.
    expect(find.text('Temperature Converter'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
