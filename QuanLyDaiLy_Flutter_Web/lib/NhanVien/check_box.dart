import 'package:flutter/material.dart';

class PhanQuyen extends StatefulWidget {
  final TextEditingController cv;
  final TextEditingController ten;
  final GlobalKey<FormState> formKey;
  const PhanQuyen(
      {Key? key, required this.cv, required this.ten, required this.formKey})
      : super(key: key);

  @override
  _PhanQuyenState createState() => _PhanQuyenState();
}

class _PhanQuyenState extends State<PhanQuyen> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Container(
            width: 400,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: 150,
                  child: Text(
                    'CHỦ SỞ HỮU',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: TextFormField(
                    decoration: InputDecoration(border: InputBorder.none),
                    cursorColor: Colors.blueGrey,
                    controller: widget.ten,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Chưa nhập tên';
                      } else {
                        return null;
                      }
                    },
                  ),
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 400,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: 150,
                  child: Text(
                    'CHỨC VỤ',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: BuildChucVuFormField()))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget BuildChucVuFormField() {
    List<String> chucvu = [
      'QUẢN LÝ ĐẠI LÝ',
      'QUẢN LÝ KHO HÀNG',
      'QUẢN LÝ TÀI CHÍNH',
      'QUẢN LÝ NHÂN VIÊN'
    ];
    return TextFormField(
      readOnly: true,
      enabled: true,
      controller: widget.cv,
      validator: (value) {
        if (value!.isEmpty) {
          return "Chưa chọn chức vụ";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: widget.cv.text,
        border: InputBorder.none,
        suffixIcon: PopupMenuButton<String>(
          color: Colors.blueGrey[100],
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.blueGrey,
          ),
          onSelected: (value) {
            widget.cv.text = value;
          },
          itemBuilder: (BuildContext context) {
            return chucvu.map<PopupMenuItem<String>>((e) {
              return PopupMenuItem(
                value: e,
                child: Text(
                  e,
                  style: TextStyle(color: Colors.blueGrey[800]),
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
