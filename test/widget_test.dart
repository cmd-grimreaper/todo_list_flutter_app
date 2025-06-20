import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/pages/home_page.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  late Box testBox;

  setUp(() async {
    testBox = await Hive.openBox('testBox');
    await testBox.clear(); // Clean before each test
  });

  testWidgets('HomePage loads without error', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(myBox: testBox), // ✅ Pass required parameter
      ),
    );

    expect(find.text('To-Do List'), findsOneWidget);
  });
}

