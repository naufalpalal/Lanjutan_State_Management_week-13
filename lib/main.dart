import 'package:flutter/material.dart';
import 'stream.dart';

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
  Color bgColor = Colors.blueGrey;
  late ColorStream colorStream;

  @override
  void initState() {
    super.initState();
    colorStream = ColorStream();
    changeColor();
  }

  void changeColor() async {
    //await for (var eventColor in colorStream.getColors()) {
    colorStream.getColors().listen((eventColor) {//menggunakan await for diprosesnya 1/1 jadi sistemnya menunggu 1 1, kalau menggunakan listen setiap event yang diterima mereka dipanggil setiap kali stream mengirimkan event.
      setState(() {
        bgColor = eventColor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
      ),
      body: Container(
        decoration: BoxDecoration(color: bgColor),
      ),
    );
  }
}