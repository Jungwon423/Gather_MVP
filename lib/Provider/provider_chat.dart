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

  // 복습 제목
  String _reviewTitle = '';

  String get reviewTitle => _reviewTitle;

  void setReviewTitle(String newReviewTitle) {
    _reviewTitle = newReviewTitle;
    notifyListeners();
  }

  // 첫 GPT의 응답
  String _initialChat = '';

  String get initialChat => _initialChat;

  void setInitialChat(String initialChat) {
    _initialChat = initialChat;
    notifyListeners();
  }

  // ChatId
  String _chatId = '';

  String get chatId => _chatId;

  void updateChatId(String updatedChatId) {
    _chatId = updatedChatId;
    notifyListeners();
  }

  // Chat의 summary (또는 situation)
  String _chatTitle = '';

  String get chatTitle => _chatTitle;

  void updateChatTitle(String selectedChatType) {
    _chatTitle = selectedChatType;
    notifyListeners();
  }

  // Chat의 Image
  String _imageUrl = '';

  String get imageUrl => _imageUrl;

  void resetImageUrl() {
    _imageUrl = '';
    notifyListeners();
  }

  void updateImageUrl(String newImageUrl) {
    _imageUrl = newImageUrl;
    notifyListeners();
  }
}
