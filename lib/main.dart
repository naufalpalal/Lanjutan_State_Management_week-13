import 'package:flutter/material.dart';
import 'stream.dart';
import 'dart:async';
import 'dart:math';

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

  int lastNumber = 0;
  late StreamController numberStreamController;
  late NumberStream numberStream;

  @override
  void initState() {
    numberStream = NumberStream();
    numberStreamController = numberStream.controller;
    Stream stream = numberStreamController.stream;
    stream.listen((event) {
      setState(() {
        lastNumber = event;
      });
    }).onError((error) {
      setState(() {
        lastNumber = -1;
      });//Dalam kode tersebut jika stream terjadi error akan memunculkan nilai -1 sebagai pemberitahuan bahwa ada error
    });//Mengakses stream dari NumberStream yang kemudian setiap kali angka beru ditambahkan ke stream maka angka itu akan diterima dan disimpan dalam variabel lastNumber yang akan digunakan untuk memperbarui tampilannya.
    super.initState();
    //colorStream = ColorStream();
    //changeColor();

    @override
    void dispose() {
      numberStreamController.close();
      super.dispose();
    }
  }

  //Menghasilkan angka acak dan menambahkannya ke dalam stream menggunakan addNumberToSink(), dan angka tersebut kemudian dapat diterima dan diperoses di bagian lain program
  void addRandomNumber() {
    Random random = Random();
    //int myNum = random.nextInt(10);
    //numberStream.addNumberToSink(myNum);
    numberStream.addError();//baris ini memanggil method addError dari NumberStream yang sudah didefinisikan di file stream.dart
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
      /*body: Container(
        decoration: BoxDecoration(color: bgColor),
      ),*/
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(lastNumber.toString()),
            ElevatedButton(
              onPressed: () => addRandomNumber(),
              child: Text('New Random Number'),
            )
          ],
        ),
      ),
    );
  }
}