class Message {
  final int id;
  final DateTime sendTime;
  final String text;
  final String senderUsername;
  final String receiverUsername;

  Message(
      {required this.id,
      required this.sendTime,
      required this.text,
      required this.receiverUsername,
      required this.senderUsername});
}
