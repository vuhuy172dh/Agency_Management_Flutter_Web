import 'package:do_an/Models/NhanVienClass.dart';
import 'package:do_an/NhanVien/GiaoDienThemNhanVien.dart';
import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/tim_kiem.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class NhanVienScreen extends StatefulWidget {
  const NhanVienScreen({Key? key}) : super(key: key);

  @override
  _NhanVienScreenState createState() => _NhanVienScreenState();
}

class _NhanVienScreenState extends State<NhanVienScreen> {
  final formKeySearch = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  List<int> selectedData = [];
  List<dynamic> selectedRow = [];
  TextEditingController _manhanvien = TextEditingController();
  TextEditingController _tennhanvien = TextEditingController();
  TextEditingController _gioitinh = TextEditingController();
  TextEditingController _chucvu = TextEditingController();
  TextEditingController _sodienthoai = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _searchMa = TextEditingController();
  TextEditingController _searchGioiTinh = TextEditingController();
  TextEditingController _searchChucvu = TextEditingController();

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
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Row(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "DANH S??CH C??C NH??N VI??N",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: TimKiem(
                                  formKey: formKeySearch,
                                  searchMa: _searchMa,
                                  searchTen: _searchGioiTinh,
                                  searchLoai: _searchChucvu,
                                  hindText1: 'Nh???p m?? nh??n vi??n',
                                  hindText2: 'Nh???p gi???i t??nh',
                                  hindText3: "Nh???p ch???c v???")),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey[800]),
                              onPressed: () {
                                setState(() {});
                              },
                              child: Text('Search')),
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey[800]),
                              onPressed: () {
                                _searchMa.clear();
                                _searchGioiTinh.clear();
                                _searchChucvu.clear();
                                setState(() {});
                              },
                              child: Text('Home')),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                // T???o n??t th??m (th??m NH??N VI??N)
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'TH??M NH??N VI??N',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          content: GiaoDienThemNhanVien(
                              formKey: formKey,
                              isCheck: false,
                              newmaNV: _manhanvien,
                              newtenNB: _tennhanvien,
                              newGioiTinh: _gioitinh,
                              newChucVu: _chucvu,
                              newSodienthoai: _sodienthoai,
                              newEmail: _email),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  var addData =
                                      await NhanVien().addNhanVien(
                                          int.parse(_manhanvien.text),
                                          _tennhanvien.text,
                                          _gioitinh.text,
                                          int.parse(_sodienthoai.text),
                                          _email.text,
                                          _chucvu.text);
                                  if (addData != null) {
                                    _showTopFlash(
                                        Colors.white,
                                        TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        'Th??m nh??n vi??n kh??ng th??nh c??ng');
                                  } else {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'Th??m nh??n vi??n th??nh c??ng');
                                  }
                                  _manhanvien.clear();
                                  _tennhanvien.clear();
                                  _gioitinh.clear();
                                  _chucvu.clear();
                                  _sodienthoai.clear();
                                  _email.clear();
                                  selectedData.clear();
                                  selectedRow.clear();
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  _manhanvien.clear();
                                  _tennhanvien.clear();
                                  _gioitinh.clear();
                                  _chucvu.clear();
                                  _sodienthoai.clear();
                                  _email.clear();
                                  selectedData.clear();
                                  selectedRow.clear();
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                child: Text('Cancel',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )))
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 75,
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[800],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'TH??M',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),

                // T???o n??t x??a (x??a NH??N VI??N)
                GestureDetector(
                  onTap: () {
                    if (selectedData.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'ERROR',
                                style: TextStyle(color: Colors.red),
                              ),
                              content:
                                  Text('B???n v???n ch??a ch???n ?????i t?????ng ????? x??a'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blueGrey),
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            );
                          });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('B???n ch???c ch???n mu???n x??a?'),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  var data;
                                  while (selectedData.isNotEmpty) {
                                    data = await NhanVien()
                                        .deleteNhanVien(
                                            selectedData.removeLast());
                                    if (data != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'X??a nh??n vi??n kh??ng th??nh c??ng');
                                      break;
                                    }
                                  }
                                  if (data == null) {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'X??a nh??n vi??n th??nh c??ng');
                                  }
                                  setState(() {
                                    selectedData.clear();
                                    selectedRow.clear();
                                    Navigator.pop(context);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                child: Text(
                                  'YES',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                child: Text(
                                  'NO',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 75,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: selectedData.isEmpty
                            ? Colors.blueGrey[400]
                            : Colors.blueGrey[800],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'X??A',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: selectedData.isEmpty
                              ? Colors.white54
                              : Colors.white),
                    ),
                  ),
                ),

                // T???o n??t s???a (s???a ?????i l??)
                GestureDetector(
                  onTap: () {
                    if (selectedRow.length < 1) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'ERROR',
                                style: TextStyle(color: Colors.red),
                              ),
                              content: Text('B???n ch??a ch???n ?????i t?????ng ????? s???a'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blueGrey),
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            );
                          });
                    } else if (selectedRow.length > 1) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'ERROR',
                                style: TextStyle(color: Colors.red),
                              ),
                              content: Text('B???n ch??? ???????c ch???n M???T ?????i t?????ng'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blueGrey),
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            );
                          });
                    } else {
                      _manhanvien.text = selectedRow[0][0].toString();
                      _tennhanvien.text = selectedRow[0][1].toString();
                      _gioitinh.text = selectedRow[0][2].toString();
                      _chucvu.text = selectedRow[0][3].toString();
                      _sodienthoai.text = selectedRow[0][4].toString();
                      _email.text = selectedRow[0][5].toString();

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'S???A TH??NG TIN NH??N VI??N',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800]),
                            ),
                            content: GiaoDienThemNhanVien(
                                formKey: formKey,
                                isCheck: true,
                                newmaNV: _manhanvien,
                                newtenNB: _tennhanvien,
                                newGioiTinh: _gioitinh,
                                newChucVu: _chucvu,
                                newSodienthoai: _sodienthoai,
                                newEmail: _email),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    var data = await NhanVien()
                                        .updateNhanVien(
                                            int.parse(_manhanvien.text),
                                            _tennhanvien.text,
                                            _gioitinh.text,
                                            int.parse(_sodienthoai.text),
                                            _email.text,
                                            _chucvu.text);

                                    if (data != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'S???a kh??ng th??nh c??ng');
                                    } else {
                                      _showTopFlash(
                                          Colors.green,
                                          TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          'S???a th??nh c??ng');
                                    }
                                    setState(() {
                                      _manhanvien.clear();
                                      _tennhanvien.clear();
                                      _gioitinh.clear();
                                      _chucvu.clear();
                                      _sodienthoai.clear();
                                      _email.clear();
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
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _manhanvien.clear();
                                      _tennhanvien.clear();
                                      _gioitinh.clear();
                                      _chucvu.clear();
                                      _sodienthoai.clear();
                                      _email.clear();
                                      selectedData.clear();
                                      selectedRow.clear();
                                      Navigator.pop(context);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blueGrey),
                                  child: Text('Cancel',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )))
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 75,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        color: selectedRow.length != 1
                            ? Colors.blueGrey[400]
                            : Colors.blueGrey[800],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'S???A',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: selectedRow.length != 1
                              ? Colors.white54
                              : Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: ScrollableWidget(child: buildDataTable()),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDataTable() {
    final columns = [
      'M?? NH??N VI??N',
      'H??? V?? T??N',
      'GI???I T??NH',
      'CH???C V???',
      'S??? ??I???N THO???I',
      'EMAIL',
    ];

    return FutureBuilder(
      future: NhanVien().readNhanVien(
          _searchMa.text, _searchGioiTinh.text, _searchChucvu.text),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return Builder(
          builder: (context) {
            return DataTable(
              columns: getColumns(columns),
              rows: getRows((snapshot.data as List<NhanVien>)),
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

  List<DataRow> getRows(List<NhanVien> users) => users.map((NhanVien user) {
        final cells = [
          user.manhanvien,
          user.hoten,
          user.gioitinh,
          user.chucvu,
          user.sodienthoai,
          user.email
        ];

        return DataRow(
          cells: getCells(cells),
          selected: selectedData.contains(cells[0]),
          onSelectChanged: (isSelected) => setState(() {
            final isAdding = isSelected != null && isSelected;
            isAdding
                ? selectedData.add(cells[0] as int)
                : selectedData.remove(cells[0]);

            isAdding
                ? selectedRow.add(cells)
                : selectedRow.removeWhere((element) => element[0] == cells[0]);
          }),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) {
        return DataCell(Text('$data'));
      }).toList();
}
