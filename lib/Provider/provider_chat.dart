import 'dart:math';

import 'package:flutter/material.dart';

class ProviderChat with ChangeNotifier {

  // TTS 목소리
  final List<String> _voices = [
    "en-US-Neural2-A",
    "en-US-Neural2-C",
    "en-US-Neural2-D",
    "en-US-Neural2-E",
    "en-US-Neural2-F",
    "en-US-Neural2-G",
    "en-US-Neural2-H",
    "en-US-Neural2-1",
    "en-US-Neural2-J",
    "en-US-News-K",
    "en-US-News-L",
    "en-US-News-M",
    "en-US-News-N",
    "en-US-Standard-A",
    "en-US-Standard-B",
    "en-US-Standard-C",
    "en-US-Standard-D",
    "en-US-Standard-E",
    "en-US-Standard-F",
    "en-US-Standard-G",
    "en-US-Standard-H",
    "en-US-Standard-I",
    "en-US-Standard-J"
  ];
  int _voiceIndex = 0;
  String _randomVoice = "en-US-Neural2-A";
  String get randomVoice => _randomVoice;


  void updateRandomVoice() {
    _voiceIndex = Random().nextInt(_voices.length);
    _randomVoice = _voices[_voiceIndex];
    notifyListeners();
  }
}
