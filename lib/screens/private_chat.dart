import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snappio_frontend/services/ws_services.dart';
import '../provider/msg_provider.dart';

class PrivateChat extends StatefulWidget {
  final String userid;
  const PrivateChat({Key? key, required this.userid}) : super(key: key);

  @override
  State<PrivateChat> createState() => _PrivateChatState();
}

class _PrivateChatState extends State<PrivateChat> {
  late String userid = widget.userid;
  final WSServices wsServices = WSServices();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    wsServices.clearMsg(context);
    connect();
    super.initState();
  }

  Future<void> connect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("x-auth");
    wsServices.connectPrivateSocket(context, userid, token!, _scroll);
  }

  void sendMsg(String user) {
    if (_controller.text != "") {
      var dt = DateTime.now();
      String time = "${dt.hour}:${dt.minute}";
      wsServices.sendMsg(context, _controller.text, user, time, false);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final msglist = Provider.of<MsgProvider>(context, listen: true).msglist;

    return Scaffold(
      appBar: AppBar(
        leading: const CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile_avatar.png")),
        title: Text(userid),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scroll,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: msglist.length + 1,
                itemBuilder: (context, index) {
                  if (index == msglist.length) {
                    return const SizedBox(height: 75);
                  }
                  return SingleChildScrollView(
                    child: ChatBubble(
                      clipper: ChatBubbleClipper5(
                        type: (msglist[index].message!.isme!)
                            ? BubbleType.sendBubble
                            : BubbleType.receiverBubble,
                      ),
                      alignment: (msglist[index].message!.isme!)
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 14),
                      backGroundColor: (msglist[index].message!.isme!)
                          ? Colors.indigoAccent
                          : Colors.greenAccent,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Text(
                          "${msglist[index].message!.data!}\n${msglist[index].message!.time}",
                          style: TextStyle(
                              color: (msglist[index].message!.isme!)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Type message",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  ),
                )),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    sendMsg("YOU");
                    _scroll.jumpTo(_scroll.position.maxScrollExtent);
                  },
                  elevation: 0,
                  backgroundColor: Theme.of(context).cardColor,
                  foregroundColor: Theme.of(context).splashColor,
                  child: const Icon(Icons.send_rounded),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
