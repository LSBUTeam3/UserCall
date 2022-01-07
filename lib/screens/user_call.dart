import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:demoagora/providers/call_provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

const app_id = ""; //will need to be replaced
const token = "";
const channelName = "";

RtcEngineContext context = RtcEngineContext(app_id);
var engine;

class VideoCall extends StatefulWidget {
  VideoCall({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<VideoCall> {
  bool _joined = false;
  int _remoteUid = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    await [Permission.camera, Permission.microphone].request();

    engine = await RtcEngine.createWithContext(context);
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      print('joinChannelSuccess $channel $uid');
      setState(() {
        _joined = true;
      });
    }, userJoined: (int uid, int elapsed) {
      print('userJoined $uid');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline $uid');
      setState(() {
        _remoteUid = 0;
      });
    }));
    await engine.enableVideo();
    await engine.enableAudio();

    await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await engine.setClientRole(ClientRole.Broadcaster);
    await engine.joinChannel(token, channelName, null, 0);
    await engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    final FlutterTts tts = FlutterTts();
    bool facing_forward = false;

    Future _speak_leave() async {
      await tts.speak("Leave call");
    }

    Future _speak_swap() async {
      if (facing_forward == true) {
        await tts.speak("Rear camera");
      } else {
        await tts.speak("Front camera");
      }
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellowAccent[100],
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "User Video Call",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.amber,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                leaveChannel(engine);
                context.read<CallProvider>().setFalse();
                _speak_leave();
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 300), primary: Colors.amberAccent),
              icon: const Icon(
                Icons.call_end,
                color: Colors.black,
              ),
              label: const Text(
                "Leave Call",
                style: TextStyle(color: Colors.black, fontSize: 28),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                engine.switchCamera();
                _speak_swap();
                facing_forward = !facing_forward;
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 300), primary: Colors.amberAccent),
              icon: const Icon(
                Icons.switch_camera,
                color: Colors.black,
              ),
              label: const Text(
                "Switch Camera",
                style: TextStyle(fontSize: 28, color: Colors.black),
              ),
            ),
          ],
        )),
      ),
    );
  }

  void leaveChannel(RtcEngine engine) {
    engine.leaveChannel();
  }
}
