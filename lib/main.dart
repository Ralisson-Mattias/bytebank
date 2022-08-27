import 'package:bytebank/screens/transfer_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ByteBankApp());

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Transferlist(),
      theme: ThemeData.dark(),
    );
  }
}
