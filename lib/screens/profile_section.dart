import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snappio_frontend/provider/post_provider.dart';
import 'package:snappio_frontend/provider/user_provider.dart';
import 'package:snappio_frontend/services/auth_services.dart';
import 'package:snappio_frontend/services/posts_services.dart';
import 'package:snappio_frontend/widgets/shimmer_card.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({Key? key}) : super(key: key);

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final AuthServices authServices = AuthServices();
  static bool? _loadDone;

  @override
  void initState() {
    super.initState();
    final String? username =
        Provider.of<UserProvider>(context, listen: false).user!.username;
    PostsServices()
        .getUserPosts(context, username)
        .then((value) => setState(() => _loadDone = value));
  }

  @override
  void dispose() {
    _loadDone = null;
    super.dispose();
  }

  void itemClicked(int item) {
    switch (item) {
      case 0:
        authServices.logout(context);
        break;
      case 1:
        authServices.deleteUser(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true).user;
    final posts = Provider.of<PostsProvider>(context, listen: true).posts;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Snappio"),
          centerTitle: true,
          actions: [
            PopupMenuButton<int>(
                onSelected: itemClicked,
                elevation: 0,
                itemBuilder: (context) => [
                      const PopupMenuItem<int>(value: 0, child: Text("Logout")),
                      const PopupMenuItem<int>(
                          value: 1, child: Text("Delete account"))
                    ])
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Center(
                    child: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/profile_avatar.png"),
                  radius: 50,
                )),
                const SizedBox(height: 20),
                RichText(
                    text: TextSpan(
                        text: user!.name,
                        style: const TextStyle(
                          fontFamily: "Rubik",
                          fontSize: 21,
                          color: Colors.blueGrey,
                        ))),
                RichText(
                    text: TextSpan(
                        text: user.username,
                        style: const TextStyle(
                            fontFamily: "Rubik",
                            color: Colors.grey,
                            fontSize: 16))),
                const SizedBox(height: 120),
                _loadDone == null
                    ? const ShimmerCard()
                    : _loadDone == true
                        ? posts.isNotEmpty
                            ? GridView.count(
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
                            : Container(
                                alignment: Alignment.center,
                                child: const Text("No Posts Yet"))
                        : Container()
              ],
            ),
          ),
        ));
  }
}
