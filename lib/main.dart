import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:range_selector/randomizer_change_notifier.dart';
import 'package:range_selector/range_selector_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RandomizerChangeNotifier(),
      child: MaterialApp(
        home: RangeSelectorPage(),
      ),
    );
  }
}
