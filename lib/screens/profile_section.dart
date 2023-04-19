import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snappio_frontend/provider/user_provider.dart';
import 'package:snappio_frontend/services/auth_services.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({Key? key}) : super(key: key);

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final AuthServices authServices = AuthServices();

  void itemClicked(int item) {
    switch(item){
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
              const PopupMenuItem<int>(value: 1, child: Text("Delete account"))
            ]
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          const Center(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile_avatar.png"),
              radius: 50,
          )),
          const SizedBox(height: 20),
          RichText(text: TextSpan(
            text: user!.name,
            style: const TextStyle(
              fontFamily: "Rubik",
              fontSize: 21,
              color: Colors.blueGrey,
            )
          )),
          RichText(text: TextSpan(
              text: user.username,
              style: const TextStyle(fontFamily: "Rubik",color: Colors.grey)
          )),
        ],
      )
    );
  }
}
