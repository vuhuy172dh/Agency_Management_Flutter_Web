import 'package:do_an/KhoHangManager/GiaoDienCTPN.dart';
import 'package:do_an/KhoHangManager/GiaoDienThemPhieuNhap.dart';
import 'package:do_an/Models/PhieuNhapKhoClass.dart';
import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class PhieuNhapList extends StatefulWidget {
  const PhieuNhapList({Key? key}) : super(key: key);

  @override
  _PhieuNhapListState createState() => _PhieuNhapListState();
}

class _PhieuNhapListState extends State<PhieuNhapList> {
  final datasets = <String, dynamic>{};
  List<int> selectedData = [];
  List<dynamic> selectedRow = [];
  final formKey = GlobalKey<FormState>();
  SupabaseManager supabaseManager = SupabaseManager();
  TextEditingController _newMaPhieu = TextEditingController();
  TextEditingController _newThanhTien = TextEditingController();
  TextEditingController _newNgayNhap = TextEditingController();
  final ValueNotifier<DateTime?> _ngaynhapSub = ValueNotifier(null);
  TextEditingController _searchMa = TextEditingController();

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'DANH S??CH PHI???U NH???P',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                              width: 200,
                              height: 30,
                              padding: EdgeInsets.only(
                                  left: 20, right: 10, bottom: 5, top: 5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white70),
                              child: TextFormField(
                                cursorColor: Colors.blueGrey[800],
                                controller: _searchMa,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Nh???p m?? phi???u"),
                              )),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey[800]),
                          onPressed: () {
                            setState(() {});
                          },
                          child: Text('Search'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey[800]),
                          onPressed: () {
                            _searchMa.clear();
                            setState(() {});
                          },
                          child: Text('Home'),
                        ),
                      ],
                    )
                  ],
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () async {
                    selectedRow.clear();
                    if (selectedData.length < 1) {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'ERROR',
                                style: TextStyle(color: Colors.red),
                              ),
                              content: Text('B???n ch??a ch???n ?????i t?????ng ????? xem'),
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
                    } else if (selectedData.length > 1) {
                      await showDialog(
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
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text(
                              'CHI TI???T PHI???U',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            content: ChiTietPhieuNhap(
                              maphieunhap: selectedData.removeLast(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Text(
                                  'Cancel',
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
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    // width,
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: selectedData.length == 1
                            ? Colors.blueGrey[800]
                            : Colors.blueGrey[400],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'XEM CHI TI???T',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: selectedData.length == 1
                              ? Colors.white
                              : Colors.white54),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.symmetric(vertical: 190),
                          title: Text(
                            'PHI???U NH???P KHO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          content: GiaoDienThemPhieuNhapKho(
                              formkey: formKey,
                              isCheck: false,
                              newMaPhieuNhap: _newMaPhieu,
                              newThanhTien: _newThanhTien,
                              newNgayNhap: _newNgayNhap,
                              ngaynhapSub: _ngaynhapSub),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  var addData =
                                      await PhieuNhapKho().addPhieuNhap(
                                    int.parse(_newMaPhieu.text),
                                    _newNgayNhap.text,
                                  );
                                  if (addData != null) {
                                    _showTopFlash(
                                        Colors.white,
                                        TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        'Th??m phi???u nh???p kh??ng th??nh c??ng');
                                  } else {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'Th??m phi???u nh???p th??nh c??ng!!!');
                                  }
                                  setState(() {
                                    _newMaPhieu.clear();
                                    _newNgayNhap.clear();
                                    _newThanhTien.clear();
                                    _ngaynhapSub.value = null;
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
                                  _newMaPhieu.clear();
                                  _newNgayNhap.clear();
                                  _newThanhTien.clear();
                                  _ngaynhapSub.value = null;
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
                GestureDetector(
                  onTap: () async {
                    if (selectedData.isEmpty) {
                      return await showDialog(
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
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('B???n ch???c ch???n mu???n x??a'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  var delData;
                                  while (selectedData.isNotEmpty) {
                                    delData = await PhieuNhapKho()
                                        .deletePhieuNhap(
                                            selectedData.removeLast());
                                    if (delData != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'X??a phi???u nh???p kh??ng th??nh c??ng');
                                      break;
                                    }
                                  }
                                  if (delData == null) {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'X??a phi???u nh???p th??nh c??ng!!!');
                                  }
                                  setState(() {
                                    selectedData.clear();
                                    selectedRow.clear();
                                    Navigator.pop(context);
                                  });
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
                      _newMaPhieu.text = selectedRow[0][0].toString();
                      _newThanhTien.text = selectedRow[0][1].toString();
                      _newNgayNhap.text = selectedRow[0][2];

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding: EdgeInsets.symmetric(vertical: 200),
                            title: Text(
                              'S???A PHI???U NH???P',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800]),
                            ),
                            content: GiaoDienThemPhieuNhapKho(
                              formkey: formKey,
                              isCheck: true,
                              newMaPhieuNhap: _newMaPhieu,
                              newThanhTien: _newThanhTien,
                              newNgayNhap: _newNgayNhap,
                              ngaynhapSub: _ngaynhapSub,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    var data =
                                        await PhieuNhapKho().updatePhieuNhap(
                                      int.parse(_newMaPhieu.text),
                                      _newNgayNhap.text,
                                    );
                                    if (data != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'S???a phi???u nh???p kh??ng th??nh c??ng');
                                    } else {
                                      _showTopFlash(
                                          Colors.green,
                                          TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          'S???a phi???u nh???p th??nh c??ng!!!');
                                    }

                                    setState(() {
                                      _newMaPhieu.clear();
                                      _newThanhTien.clear();
                                      _newNgayNhap.clear();
                                      _ngaynhapSub.value = null;
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
                                      _newMaPhieu.clear();
                                      _newThanhTien.clear();
                                      _newNgayNhap.clear();
                                      _ngaynhapSub.value = null;
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
                    margin: EdgeInsets.only(right: 20),
                    height: 50,
                    width: 75,
                    decoration: BoxDecoration(
                      color: selectedRow.length != 1
                          ? Colors.blueGrey[400]
                          : Colors.blueGrey[800],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
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
          Expanded(child: ListPhieuNhap())
        ],
      ),
    );
  }

  // Danh s??ch phi???u nh???p
  Widget ListPhieuNhap() {
    return Container(
      margin: EdgeInsets.all(5),
      alignment: Alignment.topCenter,
      width: double.maxFinite,
      //height: 500,
      decoration: BoxDecoration(color: Colors.blueGrey[200]),
      child: Container(
          height: 500, child: ScrollableWidget(child: buildDataTable())),
    );
  }

  Widget buildDataTable() {
    final columns = ['M?? PHI??U NH???P', 'TH??NH TI???N', 'NG??Y NH???P'];

    return FutureBuilder(
      future: PhieuNhapKho().readPhieuNhapKho(_searchMa.text),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return Builder(
          builder: (context) {
            return DataTable(
              columns: getColumns(columns),
              rows: getRows((snapshot.data as List<PhieuNhapKho>)),
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
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ))
      .toList();

  List<DataRow> getRows(List<PhieuNhapKho> users) =>
      users.map((PhieuNhapKho user) {
        final cells = [user.maphieunhap, user.thanhtien, user.ngaynhap];

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
