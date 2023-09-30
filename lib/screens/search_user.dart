import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:snappio_frontend/services/posts_services.dart';
import '../provider/post_provider.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  static bool? loadDone;
  final TextEditingController _controller = TextEditingController();
  final _usernameKey = GlobalKey<FormState>();

  void searchUser() async {
    if (await PostsServices().getUserPosts(context, _controller.text)) {
      setState(() {
        loadDone = true;
      });
    } else {
      setState(() {
        loadDone = false;
      });
    }
  }

  void revert() {
    setState(() {
      loadDone = null;
      _controller.clear();
    });
  }

  @override
  void dispose() {
    loadDone = null;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var posts = Provider.of<PostsProvider>(context, listen: true).posts;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Snappio"),
          centerTitle: true,
          actions: [
            loadDone == true
                ? IconButton(
                    onPressed: revert, icon: const Icon(Ionicons.close))
                : const Text("")
          ],
        ),
        body: loadDone == null
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
                      onTap: searchUser,
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
                  const Text("Search a friend", textScaleFactor: 1.2),
                  Expanded(
                      child: Image.asset("assets/images/friend.png",
                          alignment: Alignment.bottomCenter))
                ]),
              )
            : loadDone == true && posts.isNotEmpty
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60),
                          const Center(
                              child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/profile_avatar.png"),
                            radius: 50,
                          )),
                          const SizedBox(height: 20),
                          Text(_controller.text, textScaleFactor: 1.4),
                          const SizedBox(height: 110),
                          GridView.count(
                              physics: const ScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6,
                              shrinkWrap: true,
                              children: List.generate(posts.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(posts[index].image!),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                );
                              }))
                        ],
                      ),
                    ),
                  )
                : const Center(child: Text("No posts found of the user")));
  }
}
