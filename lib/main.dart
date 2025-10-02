import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scire/config/dependencies.dart';
import 'package:scire/routing/router.dart';

void main() {
  runApp(MultiProvider(
    providers: providers,
    child: const App()
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Scire",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
