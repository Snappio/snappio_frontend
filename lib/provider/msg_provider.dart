import 'package:flutter/cupertino.dart';
import '../models/message_model.dart';

class MsgProvider extends ChangeNotifier {
  List<MsgData> msglist = [];

  void addMsg(MsgData msgdata) {
    msglist.add(msgdata);
    notifyListeners();
  }

  void clearList() {
    msglist.clear();
    notifyListeners();
  }
}
