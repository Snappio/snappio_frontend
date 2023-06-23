import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:snappio_frontend/screens/upload_section.dart';
import 'package:snappio_frontend/services/posts_services.dart';
import 'package:snappio_frontend/themes.dart';
import 'package:snappio_frontend/widgets/post_card.dart';
import '../models/posts_model.dart';
import '../provider/post_provider.dart';

class PostsFeed extends StatefulWidget {
  const PostsFeed({Key? key}) : super(key: key);

  @override
  State<PostsFeed> createState() => _PostsFeedState();
}

class _PostsFeedState extends State<PostsFeed> {
  bool? isDone;

  @override
  void initState() {
    super.initState();
    PostsServices()
        .fetchPosts(context)
        .then((value) => setState(() => {isDone = value}));
  }

  @override
  Widget build(BuildContext context) {
    final List<PostsModel> allposts =
        Provider.of<PostsProvider>(context, listen: true).posts;

    return Scaffold(
      appBar: AppBar(title: const Text("Snappio"), centerTitle: true, actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(UploadSection.routeName);
            },
            child: Text("Post",
                style: TextStyle(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? Themes.lightBg
                        : Colors.black87,
                    fontWeight: FontWeight.bold),
                textScaleFactor: 1.2))
      ]),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            isDone = null;
          });
          return PostsServices()
              .fetchPosts(context)
              .then((value) => setState(() => {isDone = value}));
        },
        child: isDone == null
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Theme.of(context).cardColor, size: 75),
              )
            : isDone == false
                ? const Center(
                    child: Text("Oops! Something's wrong 😢"),
                  )
                : allposts.isEmpty
                    ? const Center(
                        child: Text("No Posts Yet"),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allposts.length,
                        itemBuilder: (context, index) => PostCard(
                            user: allposts[index].user!,
                            dateTime: allposts[index].timestamp!,
                            imageUrl: allposts[index].image!,
                            caption: allposts[index].content!)),
      ),
    );
  }
}
