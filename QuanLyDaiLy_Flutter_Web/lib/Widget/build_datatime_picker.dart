import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildDateTimePicker(String data, TextEditingController _controller,
    String error_text, Color textColor,
    {Color? error_color = null, bool isCheck = true}) {
  return TextFormField(
    validator: (value) {
      if (data.isEmpty) {
        return isCheck ? error_text : null;
      } else {
        return null;
      }
    },
    enabled: false,
    decoration: InputDecoration(
        errorStyle:
            TextStyle(color: error_color == null ? Colors.red : error_color),
        border: InputBorder.none,
        hintText: data.isEmpty ? _controller.text : data,
        hintStyle: TextStyle(color: textColor),
        suffixIcon: Icon(
          Icons.calendar_today,
          color: textColor,
        )),
  );
}
