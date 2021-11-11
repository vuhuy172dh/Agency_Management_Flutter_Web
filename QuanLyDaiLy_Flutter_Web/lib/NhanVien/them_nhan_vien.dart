import 'package:flutter/material.dart';

class ThemNhanVien extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool isCheck;
  final TextEditingController newmaNV;
  final TextEditingController newtenNB;
  final TextEditingController newGioiTinh;
  final TextEditingController newChucVu;
  final TextEditingController newSodienthoai;
  final TextEditingController newEmail;

  const ThemNhanVien(
      {Key? key,
      required this.formKey,
      required this.isCheck,
      required this.newmaNV,
      required this.newtenNB,
      required this.newGioiTinh,
      required this.newChucVu,
      required this.newSodienthoai,
      required this.newEmail})
      : super(key: key);

  @override
  _ThemNhanVienState createState() => _ThemNhanVienState();
}

class _ThemNhanVienState extends State<ThemNhanVien> {
  final gioitinh = ['Nam', 'Nữ'];
  final chucvu = ['Tổng quản lý', 'tài chính', 'quản lý kho', 'thư ký'];
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tạo hàng để điền thông tin MÃ NHÂN VIÊN
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'MÃ NHÂN VIÊN',
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: widget.isCheck
                              ? Colors.blueGrey[300]
                              : Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        enabled: widget.isCheck ? false : true,
                        initialValue: widget.newmaNV.text,
                        style: TextStyle(color: Colors.white),
                        autofocus: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(border: InputBorder.none),
                        onChanged: (value) {
                          widget.newmaNV.text = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bạn chưa nhập MÃ NHÂN VIÊN";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Tạo hàng để điền thông tin HỌ VÀ TÊN
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'HỌ VÀ TÊN',
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        autofocus: widget.isCheck ? false : true,
                        initialValue: widget.newtenNB.text,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(border: InputBorder.none),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bạn chưa nhập HỌ VÀ TÊN";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          widget.newtenNB.text = value;
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Tạo hàng thêm GIỚI TÍNH
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'GIỚI TÍNH',
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: BuildGioiTinhFormField()),
                  )
                ],
              ),
            ),
            // tạo hàng thêm chức vụ
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'CHỨC VỤ',
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: BuildChucVuFormField()),
                  )
                ],
              ),
            ),
            // Tạo hàng thêm SỐ ĐIỆN THOẠI
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'SỐ ĐIỆN THOẠI',
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        initialValue: widget.newSodienthoai.text,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(border: InputBorder.none),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bạn chưa nhập SỐ ĐIỆN THOẠI";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          widget.newSodienthoai.text = value;
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Tạo thàng thêm Email
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'EMAIL',
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        initialValue: widget.newEmail.text,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(border: InputBorder.none),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bạn chưa nhập EMAIL";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          widget.newEmail.text = value;
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildGioiTinhFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.blueGrey[800]),
      cursorColor: Colors.blueGrey[800],
      controller: widget.newGioiTinh,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bạn chưa nhập GIỚI TÍNH";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: widget.newGioiTinh.text,
        border: InputBorder.none,
        suffixIcon: PopupMenuButton<String>(
          color: Colors.blueGrey[100],
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.blueGrey,
          ),
          onSelected: (value) {
            widget.newGioiTinh.text = value;
          },
          itemBuilder: (BuildContext context) {
            return gioitinh.map<PopupMenuItem<String>>((e) {
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

  Widget BuildChucVuFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.blueGrey[800]),
      cursorColor: Colors.blueGrey[800],
      controller: widget.newChucVu,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bạn chưa nhập CHỨC VỤ";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: widget.newChucVu.text,
        border: InputBorder.none,
        suffixIcon: PopupMenuButton<String>(
          color: Colors.blueGrey[100],
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.blueGrey,
          ),
          onSelected: (value) {
            widget.newChucVu.text = value;
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
