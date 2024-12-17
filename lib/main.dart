import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const StreamHomePage(title: 'Naufal'),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key, required String title});

  @override
  State<StreamHomePage> createState() => _StremHomePageState();
}

class _StremHomePageState extends State<StreamHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}