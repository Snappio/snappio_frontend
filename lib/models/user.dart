import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) =>
        User.fromJson(x)));

// String userToJson(List<User> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  final String username;
  final String email;
  final String name;
  final String password;

  User({
    required this.username,
    required this.email,
    required this.name,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    email: json["email"],
    name: json["name"],
    password: json["password"],
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "username": username,
  //   "email": email,
  //   "name": name,
  // };
}
