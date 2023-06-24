import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  static bool? _loadDone = null;
  final TextEditingController _controller = TextEditingController();
  final _usernameKey = GlobalKey<FormState>();

  void searchUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Snappio"),
          centerTitle: true,
          actions: [
            _loadDone == true
                ? IconButton(onPressed: () {}, icon: const Icon(Ionicons.close))
                : const Text("")
          ],
        ),
        body: _loadDone == null
            ? Container(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Row(children: [
                    Expanded(
                        child: TextFormField(
                      key: _usernameKey,
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Enter username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(26)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return "Enter username first";
                        return null;
                      },
                    )),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).cardColor),
                        child: const Icon(Ionicons.search, size: 30),
                      ),
                    )
                  ]),
                  const SizedBox(height: 45),
                  const Text("Search a friend", textScaleFactor: 1.1),
                  Expanded(
                      child: Image.asset("assets/images/friend.png",
                          alignment: Alignment.bottomCenter))
                ]),
              )
            : _loadDone == true
                ? Container()
                : Container());
  }
}
