import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yesno_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final getYesNoAnswer = GetYesNoAnswer();
  List<Message> messages = [
    Message(text: 'Hola', isMine: true),
    Message(text: 'Ya regresaste?', isMine: true)
  ];

  Future<void> sendMessage(String text) async {
    final newMessage = Message(text: text, isMine: true);
    messages.add(newMessage);
    if (text.endsWith('?')) {
      await herReply();
    }
    notifyListeners();
    moveScrollToBottom();
  }

  void moveScrollToBottom() async {
    await Future.delayed(const Duration(microseconds: 100));
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messages.add(herMessage);
    notifyListeners();
    moveScrollToBottom();
  }
}
