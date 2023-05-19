class ChatInChat {
  DateTime dateTime; // 정렬 용도
  String chat; // 대화 내용
  String sender; // 보낸 사람
  bool isWaiting; // 대기 중 여부
  List<String> helpText; // TIP -> 일단 무시
  bool tipExist; // TIP 존재 여부

  ChatInChat(this.dateTime, this.chat, this.sender, this.isWaiting, this.helpText, this.tipExist);
}
