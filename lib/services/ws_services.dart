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

  connectPrivateSocket(
    BuildContext context,
    String userid,
    String token,
    ScrollController scroll )
  {
    try{
      channel = IOWebSocketChannel.connect(
        "${_baseurl}user/$userid/",
        headers: {
          "Authorization": "Bearer $token",
        }
      );
      channel.stream.listen((message) {
        var jsonData = jsonDecode(message);
        MessageData msgdata = MessageData(
            message: jsonData["message"],
            isme: false
        );
        Provider.of<MsgProvider>(context, listen: false).addMsg(msgdata);
        scroll.jumpTo(scroll.position.maxScrollExtent);
      },
        onError: (error) {
          showSnackBar(context, "Something went wrong...check username");
          Navigator.of(context).pop();
          log(error.toString());
        }
      );
    } catch (e) {
      showSnackBar(context, "Something went wrong...check username");
      Navigator.of(context).pop();
      log(e.toString());
    }
  }

  connectRoomSocket(
    BuildContext context,
    String roomId,
    ScrollController scroll )
  {
    try{
      channel = IOWebSocketChannel.connect("${_baseurl}rooms/$roomId/");
      channel.stream.listen((message) {
        print(message);
        var jsonData = jsonDecode(message);
        MessageData msgdata = MessageData(
          message: jsonData["message"],
          isme: false
        );
        Provider.of<MsgProvider>(context, listen: false).addMsg(msgdata);
        scroll.jumpTo(scroll.position.maxScrollExtent);
      },
        onError: (error) {
          showSnackBar(context, "Something went wrong...change room id");
          Navigator.of(context).pop();
          log(error.toString());
        }
      );
    } catch (e) {
      showSnackBar(context, "Something went wrong...change room id");
      Navigator.of(context).pop();
      log(e.toString());
    }
  }

  Future<void> sendMsg(
    BuildContext context,
    String textmsg,
  ) async {
    String message = '{"message":"$textmsg"}';
    MessageData msgdata = MessageData(
      message: textmsg,
      isme: true,
    );
    Provider.of<MsgProvider>(context, listen: false).addMsg(msgdata);
    channel.sink.add(message);
  }
}
