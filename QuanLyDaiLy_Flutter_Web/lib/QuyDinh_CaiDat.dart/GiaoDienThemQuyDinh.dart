import 'package:flutter/material.dart';

class GiaoDienThemQuyDinh extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController ten;
  final TextEditingController noidung;
  final String tieude1;
  final String tieude2;
  final bool isChecked;
  const GiaoDienThemQuyDinh(
      {Key? key,
      required this.formKey,
      required this.ten,
      required this.noidung,
      required this.tieude1,
      required this.tieude2,
      required this.isChecked})
      : super(key: key);

  @override
  _GiaoDienThemQuyDinhState createState() => _GiaoDienThemQuyDinhState();
}

class _GiaoDienThemQuyDinhState extends State<GiaoDienThemQuyDinh> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Form(
        key: widget.formKey,
        child: Container(
          child: Column(
            children: [
              // tên
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        widget.tieude1,
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 150,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Colors.blueGrey)),
                      child: TextFormField(
                        enabled: widget.isChecked ? false : true,
                        controller: widget.ten,
                        autofocus: true,
                        cursorColor: Colors.blueGrey,
                        decoration: InputDecoration(border: InputBorder.none),
                        style: TextStyle(color: Colors.blueGrey),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Bạn chưa nhập thông tin';
                          } else {
                            return null;
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Nội dung
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        widget.tieude2,
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 150,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Colors.blueGrey)),
                      child: TextFormField(
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: widget.noidung,
                        autofocus: true,
                        cursorColor: Colors.blueGrey,
                        style: TextStyle(color: Colors.blueGrey),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Bạn chưa nhập thông tin';
                          } else {
                            return null;
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
