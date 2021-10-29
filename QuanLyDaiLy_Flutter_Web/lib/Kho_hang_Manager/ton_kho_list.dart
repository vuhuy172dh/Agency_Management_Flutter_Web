import 'package:flutter/material.dart';

class TonKhoList extends StatefulWidget {
  const TonKhoList({Key? key}) : super(key: key);

  @override
  _TonKhoListState createState() => _TonKhoListState();
}

class _TonKhoListState extends State<TonKhoList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: Text('TON KHO'),
    );
  }
}
