import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: 'Hola!', fromWho: FromWho.me),
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);

    if (text.endsWith('?')) {
      await hisReply();
    }

    notifyListeners();
    await moveScrollToBottom();
  }

  Future<void> hisReply() async {
    final hisMessage = await getYesNoAnswer.getAnswer();
    messageList.add(hisMessage);
    notifyListeners();

    await moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    await chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
