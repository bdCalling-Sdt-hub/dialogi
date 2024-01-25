class ChatMessageModel {
  final String sender;
  final String text;
  final bool isMe;
  final bool isQuestion;

  ChatMessageModel(this.sender, this.text, this.isMe,
      {this.isQuestion = false});
}
