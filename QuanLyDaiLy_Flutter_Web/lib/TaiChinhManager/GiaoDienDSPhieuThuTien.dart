import 'package:do_an/Models/PhieuThuTienClass.dart';
import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/TaiChinhManager/GiaoDienThemPhieuThuTien.dart';
import 'package:do_an/Widget/tim_kiem.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class HoaDonList extends StatefulWidget {
  const HoaDonList({Key? key}) : super(key: key);

  @override
  _HoaDonListState createState() => _HoaDonListState();
}

class _HoaDonListState extends State<HoaDonList> {
  final formKeySearch = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  List<int> selectedData = [];
  List<dynamic> selectedRow = [];
  TextEditingController _newMaHoaDon = TextEditingController();
  TextEditingController _newMaDL = TextEditingController();
  TextEditingController _newNgayThu = TextEditingController();
  TextEditingController _newSoTienThu = TextEditingController();
  final ValueNotifier<DateTime?> _ngaythuSub = ValueNotifier(null);
  TextEditingController _searchMa = TextEditingController();
  TextEditingController _searchMaDl = TextEditingController();
  TextEditingController _searchTenDL = TextEditingController();

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
                          "DANH S??CH PHI???U THU TI???N",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: TimKiem(
                                  formKey: formKeySearch,
                                  searchMa: _searchMa,
                                  searchTen: _searchMaDl,
                                  searchLoai: _searchTenDL,
                                  hindText1: "Nh???p m?? phi???u",
                                  hindText2: "Nh???p m?? ?????i l??",
                                  hindText3: "Nh???p t??n ?????i l??")),
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
                                _searchMaDl.clear();
                                _searchTenDL.clear();
                                setState(() {});
                              },
                              child: Text('Home')),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(child: Container()),
                // T???o n??t th??m (th??m H??A ????N)
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.symmetric(vertical: 100),
                          title: Text(
                            'TH??M PHI???U THU TI???N',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          content: GiaoDienThemHoaDon(
                            formKey: formKey,
                            isCheck: false,
                            newMaPhieu: _newMaHoaDon,
                            newMaDL: _newMaDL,
                            newSoTienThu: _newSoTienThu,
                            newNgayThu: _newNgayThu,
                            ngaythuSub: _ngaythuSub,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  var addData =
                                      await PhieuThuTien().addPhieuThuTien(
                                          int.parse(_newMaHoaDon.text),
                                          _newNgayThu.text,
                                          int.parse(_newMaDL.text),
                                          int.parse(_newSoTienThu.text));
                                  if (addData != null) {
                                    _showTopFlash(
                                        Colors.white,
                                        TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        'Th??m h??a ????n kh??ng th??nh c??ng');
                                  } else {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'Th??m h??a ????n th??nh c??ng!!!');
                                  }
                                  setState(() {
                                    _newMaDL.clear();
                                    _newMaHoaDon.clear();
                                    _newNgayThu.clear();
                                    _newSoTienThu.clear();
                                    _ngaythuSub.value = null;
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.blueGrey[800]),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  _newMaDL.clear();
                                  _newMaHoaDon.clear();
                                  _newNgayThu.clear();
                                  _newSoTienThu.clear();
                                  _ngaythuSub.value = null;
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.blueGrey[800]),
                                child: Text('Cancel',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)))
                          ],
                        );
                      },
                    );
                    setState(() {});
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

                // T???o n??t x??a (x??a h??a ????n)
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
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          color: Colors.blueGrey[800],
                                          fontWeight: FontWeight.bold),
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
                              TextButton(
                                onPressed: () async {
                                  var delData;
                                  while (selectedData.isNotEmpty) {
                                    delData =
                                        await PhieuThuTien().deletePhieuThuTien(
                                            selectedData.removeLast());
                                    if (delData != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'X??a h??a ????n kh??ng th??nh c??ng');
                                      break;
                                    }
                                  }
                                  if (delData == null) {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'X??a h??a ????n th??nh c??ng!!!');
                                  }
                                  selectedData.clear();
                                  selectedRow.clear();
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'YES',
                                  style: TextStyle(
                                      color: Colors.blueGrey[800],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'NO',
                                  style: TextStyle(
                                      color: Colors.blueGrey[800],
                                      fontWeight: FontWeight.bold),
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
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          color: Colors.blueGrey[800],
                                          fontWeight: FontWeight.bold),
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
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          color: Colors.blueGrey[800],
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            );
                          });
                    } else {
                      _newMaHoaDon.text = selectedRow[0][0].toString();
                      _newMaDL.text = selectedRow[0][1].toString();
                      _newNgayThu.text = selectedRow[0][7].toString();
                      _newSoTienThu.text = selectedRow[0][6].toString();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding: EdgeInsets.symmetric(vertical: 100),
                            title: Text(
                              'S???A PHI???U THU TI???N',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800]),
                            ),
                            content: GiaoDienThemHoaDon(
                              formKey: formKey,
                              isCheck: true,
                              newMaPhieu: _newMaHoaDon,
                              newMaDL: _newMaDL,
                              newSoTienThu: _newSoTienThu,
                              newNgayThu: _newNgayThu,
                              ngaythuSub: _ngaythuSub,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    var updateData =
                                        await PhieuThuTien().updatePhieuThuTien(
                                            int.parse(_newMaHoaDon.text),
                                            _newNgayThu.text,
                                            int.parse(_newMaDL.text),
                                            int.parse(_newSoTienThu.text));
                                    if (updateData != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'S???a h??a ????n kh??ng th??nh c??ng');
                                    } else {
                                      _showTopFlash(
                                          Colors.green,
                                          TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          'S???a h??a ????n th??nh c??ng!!!');
                                    }
                                    setState(() {
                                      _newMaDL.clear();
                                      _newMaHoaDon.clear();
                                      _newNgayThu.clear();
                                      _newSoTienThu.clear();
                                      _ngaythuSub.value = null;
                                      selectedData.clear();
                                      selectedRow.clear();
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.blueGrey[800],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _newMaDL.clear();
                                      _newMaHoaDon.clear();
                                      _newNgayThu.clear();
                                      _newSoTienThu.clear();
                                      _ngaythuSub.value = null;
                                      selectedData.clear();
                                      selectedRow.clear();
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text('Cancel',
                                      style: TextStyle(
                                          color: Colors.blueGrey[800],
                                          fontWeight: FontWeight.bold)))
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
      'M?? PHI???U THU TI???N',
      'M?? ?????I L??',
      'T??N ?????I L??',
      'QU???N',
      'S??? ??I???N THO???I',
      'EMAIL',
      'S??? TI???N THU',
      'NG??Y THU'
    ];

    return FutureBuilder(
      future: PhieuThuTien().readPhieuThuTien(
          _searchMa.text, _searchMaDl.text, _searchTenDL.text),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return Builder(
          builder: (context) {
            return DataTable(
              columns: getColumns(columns),
              rows: getRows(snapshot.data as List<PhieuThuTien>),
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

  List<DataRow> getRows(List<PhieuThuTien> users) => users.map((PhieuThuTien user) {
        final cells = [
          user.maphieuthu,
          user.madaily,
          user.tendaily,
          user.quan,
          user.sodienthoai,
          user.email,
          user.sotienthu,
          user.ngaythu
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
