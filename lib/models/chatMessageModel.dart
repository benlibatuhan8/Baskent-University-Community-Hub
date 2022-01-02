import 'package:flutter/cupertino.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  String messageSender;
  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      required this.messageSender});
}
