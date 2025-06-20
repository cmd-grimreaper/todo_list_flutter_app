import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final myBox = await Hive.openBox('myBox');

  runApp(MyApp(myBox: myBox));
}

class MyApp extends StatelessWidget {
  final Box myBox;

  const MyApp({super.key, required this.myBox});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(myBox: myBox),
    );
  }
}

