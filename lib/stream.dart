import 'package:flutter/material.dart';
import 'dart:async';

class ColorStream {
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
    Colors.black,
    Colors.blue,
    Colors.blueAccent,
    Colors.red,
    Colors.purple
  ];

  Stream<Color> getColors() async* {
    yield* Stream.periodic( //yield* berguna untuk menggabungkan stream yang sudah ada ke dalam steam yang baru//
      const Duration(seconds: 1), (int t) {
        int index = t % colors.length;
        return colors[index];
      }
    );
  }//kode ini berguna untuk membuat animasi berulang setiap 1 detik.
}

class NumberStream {
  final StreamController<int> controller = StreamController<int>();

  void addNumberToSink(int newNumber) {
  controller.sink.add(newNumber);
    close() {
      controller.close();
    }
  }

  //Metode yang digunakan untuk menambahkan pesan error kw stream yang menggunakan StreamController.
  addError() {
    controller.sink.addError('error');
  }
}