import 'package:flutter/material.dart';
import 'package:iron_byte/presentation/screens/home_screen.dart';

void main() {
  runApp(App());
}



class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomeScreen());
  }
}
