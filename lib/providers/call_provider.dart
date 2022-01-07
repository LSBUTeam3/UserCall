import 'package:flutter/material.dart';

class CallProvider with ChangeNotifier {
  bool _inCall = false;

  bool get inCall => _inCall;

  void setTrue() {
    _inCall = true;
    notifyListeners();
  }

  void setFalse() {
    _inCall = false;
    notifyListeners();
  }
}
