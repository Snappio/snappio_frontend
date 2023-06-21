import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';

class PostCard extends StatefulWidget {
  final String user;
  final String imageUrl;
  final String dateTime;
  final String caption;

  const PostCard(
      {Key? key,
      required this.user,
      required this.dateTime,
      required this.imageUrl,
      required this.caption})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late String date =
      DateFormat("dd-MM-yyyy").format(DateTime.parse(widget.dateTime)) ==
              DateFormat("dd-MM-yyyy").format(DateTime.now())
          ? "Today"
          : DateFormat("dd-MM-yyyy").format(DateTime.parse(widget.dateTime));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(children: [
        const SizedBox(height: 24),
        Row(children: [
          const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_avatar.png')),
          const SizedBox(width: 17),
          Expanded(child: Text(widget.user, textScaleFactor: 1.2)),
          Expanded(
              child: Text(
            date,
            style: const TextStyle(color: Colors.blueGrey),
            textAlign: TextAlign.end,
            textScaleFactor: 0.9,
          )),
        ]),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: Text(widget.caption, textScaleFactor: 1.1)),
          const LikeButton()
        ]),
      ]),
    );
  }
}
