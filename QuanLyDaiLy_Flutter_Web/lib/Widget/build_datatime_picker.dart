import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildDateTimePicker(String data, TextEditingController _controller,
    String error_text, Color textColor) {
  return TextFormField(
    validator: (value) {
      if (data.isEmpty) {
        return error_text;
      } else {
        return null;
      }
    },
    enabled: false,
    decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.red),
        border: InputBorder.none,
        hintText: data.isEmpty ? _controller.text : data,
        hintStyle: TextStyle(color: textColor),
        suffixIcon: Icon(
          Icons.calendar_today,
          color: textColor,
        )),
  );
}
