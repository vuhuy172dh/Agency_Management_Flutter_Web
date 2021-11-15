import 'package:flutter/material.dart';

Widget cardInfor(String title, int soluong, Color backgroundColor,
    Color textColor, IconData icon) {
  return Container(
    height: 100,
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(5))),
    child: Row(
      children: [
        // Thông tin
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
            ),
            Text(
              soluong.toString(),
              style: TextStyle(color: textColor, fontSize: 30),
            )
          ],
        ),
        Expanded(child: Container()),
        // kí hiệu
        Icon(
          icon,
          color: Colors.white38,
        )
      ],
    ),
  );
}
