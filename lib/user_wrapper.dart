import 'package:demoagora/screens/user_home.dart';
import 'package:demoagora/screens/user_call.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demoagora/providers/call_provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<CallProvider>().inCall == true) {
      return VideoCall();
    } else {
      return Home();
    }
  }
}
