import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snappio_frontend/router.dart';
import 'package:snappio_frontend/themes.dart';
import 'package:snappio_frontend/screens/login_page.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp()
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: Themes.lightMode(context),
      darkTheme: Themes.darkMode(context),
      title: "Snappio",
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const LoginPage(),
    );
  }
}
