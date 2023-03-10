import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) =>
        User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  final int id;
  final String username;
  final String email;
  final String name;
  final String password;
  final String access;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.password,
    required this.access,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    name: json["name"],
    password: json["password"],
    access: json["access"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "name": name,
    "password": password,
    "access": access,
  };
}
