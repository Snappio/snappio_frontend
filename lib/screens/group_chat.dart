import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:provider/provider.dart';
import 'package:snappio_frontend/provider/msg_provider.dart';
import '../provider/user_provider.dart';
import '../services/ws_services.dart';

class GroupChat extends StatefulWidget {
  final String roomName;
  const GroupChat({Key? key, required this.roomName}) : super(key: key);

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  late final String roomId = widget.roomName;
  final WSServices wsServices = WSServices();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    wsServices.clearMsg(context);
    wsServices.connectRoomSocket(context, roomId, _scroll);
    super.initState();
  }

  void sendMsg(String username) {
    if (_controller.text != "") {
      var dt = DateTime.now();
      String time = "${dt.hour}:${dt.minute}";
      wsServices.sendMsg(context, _controller.text, username, time, false);
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
    final username =
        Provider.of<UserProvider>(context, listen: true).user!.name;

    return Scaffold(
      appBar: AppBar(
        leading: const CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile_avatar.png")),
        title: Text(roomId),
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
                    return const SizedBox(height: 80);
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
                          "${msglist[index].message!.user}:\n${msglist[index].message!.data!}\n${msglist[index].message!.time}",
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
                    sendMsg(username!);
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
