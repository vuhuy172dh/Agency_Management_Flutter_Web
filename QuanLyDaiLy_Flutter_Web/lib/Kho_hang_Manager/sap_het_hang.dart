import 'package:flutter/material.dart';

class SapHetHang extends StatefulWidget {
  const SapHetHang({Key? key}) : super(key: key);

  @override
  _SapHetHangState createState() => _SapHetHangState();
}

class _SapHetHangState extends State<SapHetHang> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: Text("SAP HET HANG"),
    );
  }
}
