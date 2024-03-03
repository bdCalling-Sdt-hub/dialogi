class ChatMessageModel {
  final String time;
  final String text;
  final String image;
  final bool isMe;
  final bool isQuestion;
  final bool isNotice;

  ChatMessageModel({
    required this.time,
    required this.text,
    required this.image,
    required this.isMe,
    this.isQuestion = false,
    this.isNotice = false,
  });
}
