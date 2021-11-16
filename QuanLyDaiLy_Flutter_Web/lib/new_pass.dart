import 'package:flutter/material.dart';

class NewPass extends StatefulWidget {
  final GlobalKey<FormFieldState> formKey;
  final TextEditingController new_pass;
  const NewPass({Key? key, required this.formKey, required this.new_pass})
      : super(key: key);

  @override
  _NewPassState createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey.shade600),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextFormField(
        key: widget.formKey,
        controller: widget.new_pass,
        obscureText: true,
        autofocus: true,
        style: TextStyle(color: Colors.blueGrey),
        cursorColor: Colors.blueGrey,
        decoration: InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Vui lòng nhập password';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
