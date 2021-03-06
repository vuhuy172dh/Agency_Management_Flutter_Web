import 'package:do_an/Models/QuyCheToChucClass.dart';
import 'package:do_an/Models/QuyDinhTienNoClass.dart';
import 'package:do_an/QuyDinh_CaiDat.dart/GiaoDienThemQuyDinh.dart';
import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/card_information.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class QuyDinh extends StatefulWidget {
  const QuyDinh({Key? key}) : super(key: key);

  @override
  _QuyDinhState createState() => _QuyDinhState();
}

class _QuyDinhState extends State<QuyDinh> {
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  List<String> selectedData = [];
  List<dynamic> selectedRow = [];
  List<int> selectedLoaiData = [];
  List<dynamic> selectedLoaiRow = [];
  final formKeyToChuc = GlobalKey<FormState>();
  final formKeyTienNo = GlobalKey<FormState>();
  TextEditingController _quan = TextEditingController();
  TextEditingController _soluong = TextEditingController();
  TextEditingController _loai = TextEditingController();
  TextEditingController _tienno = TextEditingController();

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
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Quy chế tổ chức
          Container(
            margin: EdgeInsets.only(left: 5, right: 2.5, top: 5, bottom: 5),
            width: MediaQuery.of(context).size.width / 2 - 7.5,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                // Phần hiện danh sách
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey.shade400,
                            spreadRadius: 2,
                            blurRadius: 2)
                      ]),
                  child: Column(
                    children: [
                      // Tiêu để QUY CHẾ TỔ CHỨC
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'QUY CHẾ TỔ CHỨC',
                              style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            'THÊM QUY ĐỊNH',
                                            style: TextStyle(
                                                color: Colors.blueGrey[600],
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          content: GiaoDienThemQuyDinh(
                                              isChecked: false,
                                              formKey: formKeyToChuc,
                                              ten: _quan,
                                              noidung: _soluong,
                                              tieude1: 'QUẬN',
                                              tieude2: 'SỐ LƯỢNG ĐẠI LÝ'),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () async {
                                                  var isValid = formKeyToChuc
                                                      .currentState!
                                                      .validate();
                                                  if (isValid) {
                                                    var data =
                                                        await QuyCheToChuc()
                                                            .addQuyCheToChuc(
                                                                _quan.text,
                                                                int.parse(
                                                                    _soluong
                                                                        .text));
                                                    if (data != null) {
                                                      _showTopFlash(
                                                          Colors.white,
                                                          TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          'Thêm quy định không thành công');
                                                    } else {
                                                      _showTopFlash(
                                                          Colors.green,
                                                          TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          'Thêm quy định thành công');
                                                    }

                                                    setState(() {
                                                      _quan.clear();
                                                      _soluong.clear();
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
                                                  setState(() {
                                                    _quan.clear();
                                                    _soluong.clear();
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.blueGrey),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ],
                                        );
                                      });
                                },
                                child: Text('thêm')),
                            const SizedBox(
                              width: 3,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () async {
                                  if (selectedRow.length == 1) {
                                    _quan.text = selectedRow[0][0];
                                    _soluong.text =
                                        selectedRow[0][1].toString();
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              'SỬA QUY ĐỊNH',
                                              style: TextStyle(
                                                  color: Colors.blueGrey[600],
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            content: GiaoDienThemQuyDinh(
                                              isChecked: true,
                                              formKey: formKeyToChuc,
                                              noidung: _soluong,
                                              ten: _quan,
                                              tieude1: 'QUẬN',
                                              tieude2: 'SỐ LƯỢNG ĐẠI LÝ',
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    var isValid = formKeyToChuc
                                                        .currentState!
                                                        .validate();
                                                    if (isValid) {
                                                      var Updatedata =
                                                          await QuyCheToChuc()
                                                              .updateQuyCheToChuc(
                                                                  _quan.text,
                                                                  int.parse(
                                                                      _soluong
                                                                          .text));

                                                      if (Updatedata != null) {
                                                        _showTopFlash(
                                                            Colors.white,
                                                            TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            'Sửa quy định không thành công');
                                                      } else {
                                                        _showTopFlash(
                                                            Colors.green,
                                                            TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            'Sửa quy định thành công');
                                                      }
                                                      setState(() {
                                                        selectedData.clear();
                                                        selectedRow.clear();
                                                        _quan.clear();
                                                        _soluong.clear();
                                                        Navigator.pop(context);
                                                      });
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.blueGrey),
                                                  child: Text(
                                                    'Submit',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    _quan.clear();
                                                    _soluong.clear();
                                                    selectedData.clear();
                                                    selectedRow.clear();
                                                    setState(() {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.blueGrey),
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ],
                                          );
                                        });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Thông báo'),
                                            content: Text(
                                                'Đối tượng để sửa không rõ ràng'),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.blueGrey),
                                                  child: Text(
                                                    'OK',
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
                              width: 3,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () {
                                  if (selectedData.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Thông báo'),
                                            content: Text(
                                                'Bạn chưa chọn đối tượng để xóa'),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.blueGrey),
                                                  child: Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ],
                                          );
                                        });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Thông báo'),
                                            content:
                                                Text('Bạn chắc chắn muốn xóa'),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    var data;
                                                    while (selectedData
                                                        .isNotEmpty) {
                                                      data = await QuyCheToChuc()
                                                          .deleteQuyCheToChuc(
                                                              selectedData
                                                                  .removeLast());
                                                      if (data != null) {
                                                        _showTopFlash(
                                                            Colors.white,
                                                            TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            'Xóa không thành công');
                                                        break;
                                                      }
                                                    }
                                                    if (data == null) {
                                                      _showTopFlash(
                                                          Colors.green,
                                                          TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          'Xóa thành công');
                                                    }
                                                    selectedData.clear();
                                                    selectedLoaiRow.clear();
                                                    setState(() {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.blueGrey),
                                                  child: Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.blueGrey),
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
                                child: Text('xóa')),
                          ],
                        ),
                      ),
                      // danh sách
                      Container(
                        height: MediaQuery.of(context).size.height - 170,
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(5),
                        child: ScrollableWidget(child: buildDataTable()),
                      ),
                    ],
                  ),
                ),
                // Thông tin
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 10, left: 5),
                          child: soluongquan()),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'QUY CHẾ TỔ CHỨC',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25),
                              ),
                            ),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 15),
                                    children: [
                                  TextSpan(
                                      text: 'Quy chế tổ chức',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  TextSpan(text: ' quy định số lượng '),
                                  TextSpan(
                                      text: 'quận',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  TextSpan(text: ' và số lượng '),
                                  TextSpan(
                                      text: 'đại lý tối đa',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  TextSpan(text: ' của từng quận cụ thể.')
                                ]))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // Quy định tiền nợ
          Container(
            margin: EdgeInsets.only(left: 2.5, right: 5, top: 5, bottom: 5),
            width: MediaQuery.of(context).size.width / 2 - 7.5,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                // Phần hiện danh sách
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey.shade400,
                            spreadRadius: 2,
                            blurRadius: 1)
                      ]),
                  child: Column(
                    children: [
                      // Tiêu để QUY Định tiền nợ
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'QUY ĐỊNH TIỀN NỢ',
                              style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            'THÊM QUY ĐỊNH',
                                            style: TextStyle(
                                                color: Colors.blueGrey[600],
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          content: GiaoDienThemQuyDinh(
                                              isChecked: false,
                                              formKey: formKeyTienNo,
                                              ten: _loai,
                                              noidung: _tienno,
                                              tieude1: 'LOẠI ĐẠI LÝ',
                                              tieude2: 'TIỀN NỢ TỐI ĐA'),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () async {
                                                  var isValid = formKeyTienNo
                                                      .currentState!
                                                      .validate();
                                                  if (isValid) {
                                                    var data =
                                                        await QuyDinhTienNo()
                                                            .addQuyDinhTienNo(
                                                                int.parse(
                                                                    _loai.text),
                                                                int.parse(
                                                                    _tienno
                                                                        .text));
                                                    if (data != null) {
                                                      _showTopFlash(
                                                          Colors.white,
                                                          TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          'Thêm quy định không thành công');
                                                    } else {
                                                      _showTopFlash(
                                                          Colors.green,
                                                          TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          'Thêm quy định thành công');
                                                    }
                                                    setState(() {
                                                      _loai.clear();
                                                      _tienno.clear();
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
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.blueGrey),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ],
                                        );
                                      });
                                },
                                child: Text('thêm')),
                            const SizedBox(
                              width: 3,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () {
                                  if (selectedLoaiRow.length == 1) {
                                    _loai.text =
                                        selectedLoaiRow[0][0].toString();
                                    _tienno.text =
                                        selectedLoaiRow[0][1].toString();
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              'SỬA QUY ĐỊNH',
                                              style: TextStyle(
                                                  color: Colors.blueGrey[600],
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            content: GiaoDienThemQuyDinh(
                                              isChecked: true,
                                              formKey: formKeyTienNo,
                                              noidung: _tienno,
                                              ten: _loai,
                                              tieude1: 'LOẠI ĐẠI LÝ',
                                              tieude2: 'TIỀN NỢ TỐI ĐA',
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    var isValid = formKeyTienNo
                                                        .currentState!
                                                        .validate();
                                                    if (isValid) {
                                                      var Updatedata =
                                                          await QuyDinhTienNo()
                                                              .updateQuyDinhTienNo(
                                                                  int.parse(_loai
                                                                      .text),
                                                                  int.parse(
                                                                      _tienno
                                                                          .text));

                                                      if (Updatedata != null) {
                                                        _showTopFlash(
                                                            Colors.white,
                                                            TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            'Sửa quy định không thành công');
                                                      } else {
                                                        _showTopFlash(
                                                            Colors.green,
                                                            TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            'Sửa quy định thành công');
                                                      }
                                                      setState(() {
                                                        selectedLoaiData
                                                            .clear();
                                                        selectedLoaiRow.clear();
                                                        _loai.clear();
                                                        _tienno.clear();
                                                        Navigator.pop(context);
                                                      });
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.blueGrey),
                                                  child: Text(
                                                    'Submit',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    _loai.clear();
                                                    _tienno.clear();
                                                    selectedLoaiData.clear();
                                                    selectedLoaiRow.clear();
                                                    setState(() {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.blueGrey),
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ],
                                          );
                                        });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Thông báo'),
                                            content: Text(
                                                'Đối tượng để sửa không rõ ràng'),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.blueGrey),
                                                  child: Text(
                                                    'OK',
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
                              width: 3,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () async {
                                  if (selectedLoaiData.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Thông báo'),
                                            content: Text(
                                                'Bạn chưa chọn đối tượng để xóa'),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.blueGrey),
                                                  child: Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ],
                                          );
                                        });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Thông báo'),
                                            content:
                                                Text('Bạn chắc chắn muốn xóa'),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    var dataLoai;

                                                    while (selectedLoaiData
                                                        .isNotEmpty) {
                                                      dataLoai = await QuyDinhTienNo()
                                                          .deleteQuyDinhTienNo(
                                                              selectedLoaiData
                                                                  .removeLast());
                                                      if (dataLoai != null) {
                                                        _showTopFlash(
                                                            Colors.white,
                                                            TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            'Xóa không thành công');
                                                        break;
                                                      }
                                                    }
                                                    if (dataLoai == null) {
                                                      _showTopFlash(
                                                          Colors.green,
                                                          TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          'Xóa thành công');
                                                    }
                                                    selectedLoaiData.clear();
                                                    selectedLoaiRow.clear();
                                                    setState(() {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.blueGrey),
                                                  child: Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.blueGrey),
                                                  child: Text(
                                                    'CANCEL',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ],
                                          );
                                        });
                                  }
                                },
                                child: Text('xóa')),
                          ],
                        ),
                      ),
                      // danh sách
                      Container(
                        height: MediaQuery.of(context).size.height - 170,
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        padding: EdgeInsets.all(5),
                        child: ScrollableWidget(child: buildDataLoaiTable()),
                      ),
                    ],
                  ),
                ),
                // Thông tin
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 10, left: 5),
                          child: soluongloaidl()),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'QUY ĐỊNH TIỀN NỢ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25),
                              ),
                            ),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 15),
                                    children: [
                                  TextSpan(
                                      text: 'Quy định tiền nợ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  TextSpan(text: ' quy định số lượng '),
                                  TextSpan(
                                      text: 'loại đại lý',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  TextSpan(text: ' và số '),
                                  TextSpan(
                                      text: 'nợ tối đa',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  TextSpan(
                                      text: ' của từng loại đại lý cụ thể.')
                                ]))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDataTable() {
    final columns = ['QUẬN', 'SỐ LƯỢNG ĐẠI LÝ TỐI ĐA'];

    return FutureBuilder(
      future: QuyCheToChuc().readQuyCheToChuc(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return Builder(
          builder: (context) {
            return DataTable(
              columns: getColumns(columns),
              rows: getRows((snapshot.data as List<QuyCheToChuc>)),
            );
          },
        );
      },
    );
  }

  Widget buildDataLoaiTable() {
    final columns = ['LOẠI ĐẠI LÝ', 'SỐ TIỀN NỢ TỐI ĐA'];

    return FutureBuilder(
      future: QuyDinhTienNo().readQuyDinhTienNo(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return Builder(
          builder: (context) {
            return DataTable(
              columns: getColumns(columns),
              rows: getLoaiRows((snapshot.data as List<QuyDinhTienNo>)),
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

  List<DataRow> getRows(List<QuyCheToChuc> users) => users.map((QuyCheToChuc user) {
        final cells = [user.quan, user.soluongdaily];

        return DataRow(
          cells: getCells(cells),
          selected: selectedData.contains(cells[0]),
          onSelectChanged: (isSelected) => setState(() {
            final isAdding = isSelected != null && isSelected;
            isAdding
                ? selectedData.add(cells[0] as String)
                : selectedData.remove(cells[0]);

            isAdding
                ? selectedRow.add(cells)
                : selectedRow.removeWhere((element) => element[0] == cells[0]);
          }),
        );
      }).toList();

  List<DataRow> getLoaiRows(List<QuyDinhTienNo> users) => users.map((QuyDinhTienNo user) {
        final cells = [user.loaidaily, user.tiennotoida];

        return DataRow(
          cells: getCells(cells),
          selected: selectedLoaiData.contains(cells[0]),
          onSelectChanged: (isSelected) => setState(() {
            final isAdding = isSelected != null && isSelected;
            isAdding
                ? selectedLoaiData.add(cells[0] as int)
                : selectedLoaiData.remove(cells[0]);

            isAdding
                ? selectedLoaiRow.add(cells)
                : selectedLoaiRow
                    .removeWhere((element) => element[0] == cells[0]);
          }),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) {
        return DataCell(Text('$data'));
      }).toList();

  Widget soluongquan() {
    int slquan;
    return FutureBuilder(
      future: supabaseManager.readDataSoluongQuan(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final doc = snapshot.data as PostgrestResponse?;
        if (doc == null) {
          return const SizedBox();
        }

        final datasets = <String, dynamic>{};
        datasets['Supabase Query'] = doc.data as int;
        slquan = datasets['Supabase Query'];
        return Builder(
          builder: (context) {
            return cardInfor(
                'Tổng số quận có đại lý',
                slquan,
                Colors.red.withOpacity(0.8),
                Colors.white,
                Icons.location_city_outlined);
          },
        );
      },
    );
  }

  Widget soluongloaidl() {
    int slloaidl;
    return FutureBuilder(
      future: supabaseManager.readDataSoluongLoaiDL(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final doc = snapshot.data as PostgrestResponse?;
        if (doc == null) {
          return const SizedBox();
        }

        final datasets = <String, dynamic>{};
        datasets['Supabase Query'] = doc.data as int;
        slloaidl = datasets['Supabase Query'];
        return Builder(
          builder: (context) {
            return cardInfor(
                'Tổng số loại đại lý',
                slloaidl,
                Colors.brown.withOpacity(0.8),
                Colors.white,
                Icons.account_tree_outlined);
          },
        );
      },
    );
  }
}
