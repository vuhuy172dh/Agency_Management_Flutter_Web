import 'dart:ui';

import 'package:do_an/NhanVien/check_box.dart';
import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class TaoTaiKhoan extends StatefulWidget {
  const TaoTaiKhoan({Key? key}) : super(key: key);

  @override
  _TaoTaiKhoanState createState() => _TaoTaiKhoanState();
}

const supabaseUrl = "https://tkabbsxsoektqmhvlrln.supabase.co";
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzNjA0MTUyNCwiZXhwIjoxOTUxNjE3NTI0fQ.I0vC0LT6CHleFUjuNJTzBht11jH-W_lAvXhphj4vp4g';

class _TaoTaiKhoanState extends State<TaoTaiKhoan> {
  final _formKey = GlobalKey<FormState>();
  final _formKeySua = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _manhanvien = TextEditingController();
  TextEditingController _tennhanvien = TextEditingController();
  TextEditingController _chucvu = TextEditingController();
  TextEditingController _cv = TextEditingController();
  TextEditingController _ten = TextEditingController();
  SupabaseManager supabaseManager = SupabaseManager();
  final client = SupabaseClient(supabaseUrl, supabaseKey);
  final datasets = <String, dynamic>{};
  List<String> selectedData = [];
  List<dynamic> selectedRow = [];

  void _showTopFlash(
      Color? backgroundcolor, TextStyle? contentStyle, String content) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 2),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          backgroundColor: backgroundcolor,
          brightness: Brightness.light,
          boxShadows: [BoxShadow(blurRadius: 4)],
          barrierDismissible: true,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          margin: EdgeInsets.only(
              top: 10,
              left: 10,
              right: MediaQuery.of(context).size.width - 350),
          position: FlashPosition.top,
          behavior: FlashBehavior.floating,
          controller: controller,
          child: FlashBar(
            content: Text(
              content,
              style: contentStyle,
            ),
            showProgressIndicator: true,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.blueGrey[100],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // List danh sách tài khoản
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.blueGrey[200],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 3,
                          blurRadius: 3,
                          color: Colors.blueGrey.shade400)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Tiêu đề của danh sách
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'DANH SÁCH TÀI KHOẢN',
                            style: TextStyle(
                                color: Colors.blueGrey[900],
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          ),
                          Expanded(child: Container()),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey),
                              onPressed: () async {
                                if (selectedData.isEmpty) {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Thông Báo'),
                                          content:
                                              Text('Bạn chưa chọn đối tượng'),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.blueGrey),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
                                          ],
                                        );
                                      });
                                } else if (selectedData.length > 1) {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Thông Báo'),
                                          content: Text(
                                              'Bạn chỉ được chọn một đối tượng'),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.blueGrey),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
                                          ],
                                        );
                                      });
                                } else {
                                  _ten.text = selectedRow[0][0];
                                  _cv.text = selectedRow[0][2];
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              vertical: 250),
                                          title: Center(
                                            child: Text(
                                              'SỬA THÔNG TIN',
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          content: PhanQuyen(
                                            formKey: _formKeySua,
                                            cv: _cv,
                                            ten: _ten,
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () async {
                                                  var isValid = _formKeySua
                                                      .currentState!
                                                      .validate();
                                                  if (isValid) {
                                                    var data =
                                                        await supabaseManager
                                                            .updateAcountData(
                                                                selectedRow[0]
                                                                    [1],
                                                                _ten.text,
                                                                _cv.text);
                                                    if (data != null) {
                                                      _showTopFlash(
                                                          Colors.white,
                                                          TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          'Sửa không thành công');
                                                    } else {
                                                      _showTopFlash(
                                                          Colors.green,
                                                          TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          'Sửa thành công');
                                                    }
                                                    setState(() {
                                                      _ten.clear();
                                                      _cv.clear();
                                                      selectedData.clear();
                                                      selectedRow.clear();
                                                      Navigator.pop(context);
                                                    });
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.blueGrey),
                                                child: Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            ElevatedButton(
                                                onPressed: () {
                                                  _cv.clear();
                                                  _ten.clear();
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.blueGrey),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
                                          ],
                                        );
                                      });
                                }
                              },
                              child: Text('sửa')),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: ScrollableWidget(child: buildTaiKhoanTable())),
                  ],
                )),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // tiêu để
                      Container(
                        height: 25,
                        margin: EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            'THÊM TÀI KHOẢN',
                            style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // chỗ thông tin đăng kí
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Thông tin đăng kí tài khoản
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      border: InputBorder.none),
                                  controller: _email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Mật khẩu',
                                      border: InputBorder.none),
                                  controller: _password,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập mật khẩu';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Xác nhận mật khẩu',
                                      border: InputBorder.none),
                                  controller: _confirmPassword,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập mật khẩu';
                                    }

                                    if (value != _password.text) {
                                      return 'Không khớp mật khẩu';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          // Thông tin chủ sở hữu tài khoản
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Mã Nhân Viên',
                                      border: InputBorder.none),
                                  controller: _manhanvien,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập mã nhân viên';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Tên Nhân Viên',
                                      border: InputBorder.none),
                                  controller: _tennhanvien,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập tên nhân viên';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  width: 350,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: BuildChucVuFormField()),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          child: Text('Signup'),
                          onPressed: _signup,
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey[800]),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: double.maxFinite,
                        margin: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.black, width: 1)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: Text(
                                  'THÔNG TIN VỀ CHỨC VỤ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Text(
                                  'QUẢN LÝ ĐẠI LÝ : Được sử dụng mọi chức năng trong trang ĐẠI LÝ',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Text(
                                  'QUẢN LÝ KHO HÀNG: Được sử dụng mọi chức năng trong trang KHO HÀNG',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Text(
                                  'QUẢN LÝ TÀI CHÍNH: Được sử dụng mọi chức năng trong trang TÀI CHÍNH',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Text(
                                  'QUẢN LÝ NHÂN VIÊN: Được sử dụng mọi chức năng trong trang NHÂN VIÊN',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ))
        ],
      ),
    );
  }

  Widget buildTaiKhoanTable() {
    final columns = [
      'CHỦ SỞ HỮU',
      'TÊN ĐĂNG NHẬP',
      'CHỨC VỤ',
    ];
    return FutureBuilder(
      future: supabaseManager.readDataAcount(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final doc = snapshot.data as PostgrestResponse?;
        if (doc == null) {
          return const SizedBox();
        }

        final datasets = this.datasets;
        datasets['Supabase Query'] = doc.data as List<dynamic>? ?? <dynamic>[];

        return Builder(
          builder: (context) {
            return DataTable(
              dividerThickness: 2,
              columns: getColumns(columns),
              rows: getRows((datasets['Supabase Query'] as List<dynamic>)),
            );
          },
        );
      },
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(
              column,
              style: TextStyle(
                  color: Colors.blueGrey[800],
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ))
      .toList();

  List<DataRow> getRows(List<dynamic> users) => users.map((dynamic user) {
        final temp = (user as Map<String, dynamic>);
        final cells = [temp['chusohuu'], temp['tendangnhap'], temp['status']];
        return DataRow(
          cells: getCells(cells),
          selected: selectedData.contains(temp['tendangnhap']),
          onSelectChanged: (isSelected) => setState(() {
            final isAdding = isSelected != null && isSelected;
            isAdding
                ? selectedData.add(temp['tendangnhap'])
                : selectedData.remove(temp['tendangnhap']);

            isAdding
                ? selectedRow.add(cells)
                : selectedRow.removeWhere((element) => element[1] == cells[1]);
          }),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) {
        return DataCell(Text('$data'));
      }).toList();

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
      controller: _chucvu,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng chọn chức vụ";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: _chucvu.text.isEmpty ? 'Chức Vụ' : _chucvu.text,
        border: InputBorder.none,
        suffixIcon: PopupMenuButton<String>(
          color: Colors.blueGrey[100],
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.blueGrey,
          ),
          onSelected: (value) {
            _chucvu.text = value;
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

  Future _signup() async {
    if (_formKey.currentState!.validate()) {
      var data = await supabaseManager.addDataAccount(
          _email.text, _tennhanvien.text, _chucvu.text);
      if (data != null) {
        _showTopFlash(
            Colors.white,
            TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            'Tạo tài khoản không thành công');
      } else {
        var verify = await client.auth.signUp(_email.text, _password.text);
        if (verify.error != null) {
          _showTopFlash(
              Colors.white,
              TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              'Tạo tài khoản không thành công');
          supabaseManager.deleteDataAcountUser(_email.text);
        } else {
          _showTopFlash(
              Colors.green,
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              'Tạo tài khoản thành công');
          _tennhanvien.clear();
          _chucvu.clear();
          _manhanvien.clear();
          _email.clear();
          _password.clear();
          _confirmPassword.clear();
        }
      }
      setState(() {});
    }
  }
}
