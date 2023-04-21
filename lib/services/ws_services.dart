import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:snappio_frontend/constants/snackbar.dart';
import 'package:snappio_frontend/models/message_model.dart';
import 'package:snappio_frontend/provider/msg_provider.dart';
import 'package:web_socket_channel/io.dart';

class WSServices {
  late IOWebSocketChannel channel;
  final String _baseurl = "wss://api-snappio.onrender.com/ws/";

  connectPrivateSocket(BuildContext context, String userid, String token, String username, ScrollController scroll) {
    try {
      channel =
          IOWebSocketChannel.connect("${_baseurl}user/$userid/", headers: {
        "Authorization": "Bearer $token",
      });

      channel.stream.listen((message) {
        Map<String, dynamic> jsonData = jsonDecode(message);
        var msgData = MsgData.fromJson(jsonData);
        if (msgData.message!.user != username) {
          Provider.of<MsgProvider>(context, listen: false).addMsg(msgData);
        }
        scroll.jumpTo(scroll.position.maxScrollExtent);
      }, onDone: () {
        connectPrivateSocket(context, userid, token, username, scroll);
      }, onError: (error) {
        showSnackBar(context, "Something went wrong...check username");
        Navigator.of(context).pop();
        log(error.toString());
      });
    } catch (e) {
      showSnackBar(context, "Something went wrong...check username");
      Navigator.of(context).pop();
      log(e.toString());
    }
  }

  connectRoomSocket(BuildContext context, String roomId, String username,
      ScrollController scroll) {
    try {
      channel = IOWebSocketChannel.connect("${_baseurl}rooms/$roomId/");

      channel.stream.listen((message) {
        Map<String, dynamic> jsonData = jsonDecode(message);
        var msgData = MsgData.fromJson(jsonData);
        if (msgData.message!.user != username) {
          Provider.of<MsgProvider>(context, listen: false).addMsg(msgData);
        }
        scroll.jumpTo(scroll.position.maxScrollExtent);
      }, onDone: () {
        connectRoomSocket(context, roomId, username, scroll);
      }, onError: (error) {
        showSnackBar(context, "Something went wrong...change room id");
        Navigator.of(context).pop();
        log(error.toString());
      });
    } catch (e) {
      showSnackBar(context, "Something went wrong...change room id");
      Navigator.of(context).pop();
      log(e.toString());
    }
  }

  Future<void> sendMsg(
    BuildContext context,
    String textmsg,
    String username,
    String time,
    bool isme,
  ) async {
    Map<String, dynamic> messageData = <String, dynamic>{};
    messageData["message"] = <String, dynamic>{};
    messageData["message"]["data"] = textmsg;
    messageData["message"]["user"] = username;
    messageData["message"]["time"] = time;
    messageData["message"]["isme"] = isme;

    MsgData msgData = MsgData(
        message: Message(
      data: textmsg,
      user: username,
      time: time,
      isme: true,
    ));

    Provider.of<MsgProvider>(context, listen: false).addMsg(msgData);
    channel.sink.add(jsonEncode(messageData));
  }

  void clearMsg(BuildContext context) {
    Provider.of<MsgProvider>(context, listen: false).clearList();
  }
}
