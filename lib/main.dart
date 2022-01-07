// ignore_for_file: avoid_print
import 'package:demoagora/providers/call_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => CallProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Wrapper(),
    );
  }
}
