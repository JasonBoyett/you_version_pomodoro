import 'package:flutter/material.dart';

import 'pages/home/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tomoto Timer',
      home: HomePage(),
    );
  }
}
