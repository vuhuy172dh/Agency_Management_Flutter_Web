import 'package:flutter/material.dart';

class TimKiem extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController searchMa;
  final TextEditingController searchTen;
  final TextEditingController searchLoai;
  final String hindText1;
  final String hindText2;
  final String hindText3;

  const TimKiem(
      {Key? key,
      required this.formKey,
      required this.searchMa,
      required this.searchTen,
      required this.searchLoai,
      required this.hindText1,
      required this.hindText2,
      required this.hindText3})
      : super(key: key);

  @override
  _TimKiemState createState() => _TimKiemState();
}

class _TimKiemState extends State<TimKiem> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Row(
        children: [
          Container(
              width: 200,
              height: 30,
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 5, top: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white70),
              child: TextFormField(
                cursorColor: Colors.blueGrey[800],
                controller: widget.searchMa,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: widget.hindText1),
              )),
          const SizedBox(
            width: 5,
          ),
          Container(
              width: 200,
              height: 30,
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 5, top: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white70),
              child: TextFormField(
                cursorColor: Colors.blueGrey[800],
                controller: widget.searchTen,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: widget.hindText2),
              )),
          const SizedBox(
            width: 5,
          ),
          Container(
              width: 200,
              height: 30,
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 5, top: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white70),
              child: TextFormField(
                cursorColor: Colors.blueGrey[800],
                controller: widget.searchLoai,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: widget.hindText3),
              )),
          const SizedBox(
            width: 5,
          )
        ],
      ),
    );
  }
}
