import 'package:flutter/cupertino.dart';
import '../models/message_model.dart';

class MsgProvider extends ChangeNotifier {
  List<MessageData> msglist = [];

  void addMsg(MessageData msgdata) {
    msglist.add(msgdata);
    notifyListeners();
  }
}
