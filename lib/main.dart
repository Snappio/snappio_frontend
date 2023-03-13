import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snappio_frontend/provider/user_provider.dart';
import 'package:snappio_frontend/router.dart';
import 'package:snappio_frontend/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: Themes.lightMode(context),
        darkTheme: Themes.darkMode(context),
        title: "Snappio",
        onGenerateRoute: (settings) => generateRoute(settings),
        initialRoute: '/login',
      ),
    );
  }
}
