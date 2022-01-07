import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demoagora/providers/call_provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final FlutterTts tts = FlutterTts();

  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    Future _speak_logout() async {
      await tts.speak("Log out");
    }

    Future _speak_assistance() async {
      await tts.speak("Request assistance");
    }

    return Scaffold(
      backgroundColor: Colors.yellowAccent[100],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "User Home",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
        elevation: 0.0,
        actions: [
          TextButton.icon(
              onPressed: () => _speak_logout(),
              icon: const Icon(
                Icons.person_rounded,
                color: Colors.black,
              ),
              label: const Text(
                "Log Out",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<CallProvider>().setTrue();
            _speak_assistance();
          },
          child: const Text(
            "Request Assistance",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(300, 300), primary: Colors.amberAccent),
        ),
      ),
    );
  }
}
