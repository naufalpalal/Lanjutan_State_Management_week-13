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
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  Color bgColor = Colors.blueGrey;
  late ColorStream colorStream;

  int lastNumber = 0;
  late StreamController numberStreamController;
  late NumberStream numberStream;
  late StreamTransformer transformer;//digunakan untuk mendeklarasikan variabel yang akan diinisialisasi sebelum digunakan.
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    numberStream = NumberStream();
    numberStreamController = numberStream.controller;
    Stream stream = numberStreamController.stream.asBroadcastStream();
    //Membuat listener untuk stream 
    subscription = stream.listen((event) {
      setState(() {
        lastNumber = event;
      });
    });

    subscription.onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });
    subscription.onDone(() {
      print('OnDone Was Called');
    });

    //Kode ini berguna untuk membuat transformasi custom untuk stream yang menunjukkan bahwa stream inputnya bertipe int dan hasilnya juga bertipe int.
    transformer = StreamTransformer<int, int>.fromHandlers(
      handleData: (value, sink) {
        sink.add(value * 10);
      },
      handleError: (error, trace, sink) {
        sink.add(-1);
      },
      handleDone: (sink) => sink.close());

    stream.transform(transformer).listen((event) {//transform(transformer) digunakan untuk menghubungkan StreamTransformer ke sebuah stream.
      setState(() {
        lastNumber = event;
      });
    }).onError((error) {
      setState(() {
        lastNumber = -1;
      });//Dalam kode tersebut jika stream terjadi error akan memunculkan nilai -1 sebagai pemberitahuan bahwa ada error
    });//Mengakses stream dari NumberStream yang kemudian setiap kali angka beru ditambahkan ke stream maka angka itu akan diterima dan disimpan dalam variabel lastNumber yang akan digunakan untuk memperbarui tampilannya.
    //colorStream = ColorStream();
    //changeColor();

  }

  @override
  void dispose() {
    subscription.cancel();//Membatalkan langganan pada stream.
    numberStreamController.close();
    super.dispose();
  }

  void stopStream() {
    numberStreamController.close();
  }

  //Menghasilkan angka acak dan menambahkannya ke dalam stream menggunakan addNumberToSink(), dan angka tersebut kemudian dapat diterima dan diperoses di bagian lain program
  void addRandomNumber() {
  //Membuat instance Random untuk menghasilkan angka acak
  Random random = Random();
  int myNum = random.nextInt(10);
  //Mengecek apakah numberStreamController masih terbuka dan bisa menerima data.
  if (!numberStreamController.isClosed) {
    numberStream.addNumberToSink(myNum);//Memanggil fungsi addNumberToSink untuk menambahkan angka acak
  } else {//Mengatur lasNumber untuk menjadi -1 menunjukkan bahwa stream sudah tidak aktif
    setState(() {
      lastNumber = -1;
    });
  }
    //numberStream.addNumberToSink(myNum);(Mematikan)
    //numberStream.addError();//baris ini memanggil method addError dari NumberStream yang sudah didefinisikan di file stream.dart
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
              child: const Text('New Random Number'),
            ),

            ElevatedButton(
              onPressed: () => stopStream(),
              child: const Text('Stop Subscription'),
            ),
          ],
        ),
      ),
    );
  }
}