import 'dart:convert';
// List<User> userFromJson(String str) =>
//     List<User>.from(json.decode(str).map((x) =>
//         User.fromJson(x)));

// String userToJson(List<User> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  int? id;
  String? username;
  String? email;
  String? name;
  String? access;
  List? posts;

  User({
    this.id,
    this.username,
    this.email,
    this.name,
    this.access,
    this.posts,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    name: json["name"],
    access: json["access"],
    posts: json["posts"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "name": name,
    "access": access,
    "posts": posts,
  };
}
