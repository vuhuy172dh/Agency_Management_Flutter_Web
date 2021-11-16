import 'package:do_an/Kho_hang_Manager/chi_tiet_phieu_xuat.dart';
import 'package:do_an/Kho_hang_Manager/them_phieu_xuat.dart';
import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class PhieuXuatList extends StatefulWidget {
  const PhieuXuatList({Key? key}) : super(key: key);

  @override
  _PhieuXuatListState createState() => _PhieuXuatListState();
}

class _PhieuXuatListState extends State<PhieuXuatList> {
  final datasets = <String, dynamic>{};
  List<int> selectedData = [];
  List<dynamic> selectedRow = [];
  SupabaseManager supabaseManager = SupabaseManager();
  final formKey = GlobalKey<FormState>();
  TextEditingController _newMaPhieuXuat = TextEditingController();
  TextEditingController _newNgayXuat = TextEditingController();
  TextEditingController _newMaDaiLy = TextEditingController();
  TextEditingController _newThanhTien = TextEditingController();
  TextEditingController _newSoTienNo = TextEditingController();
  final ValueNotifier<DateTime?> _ngayxuatSub = ValueNotifier(null);
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
                        'DANH SÁCH PHIẾU XUẤT',
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
                                    hintText: "Nhập mã phiếu"),
                              )),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey[800]),
                          onPressed: () {},
                          child: Text('Search'),
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
                              content: Text(
                                  'Bạn chưa chọn đối tượng để xem chi tiết'),
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
                              content: Text('Bạn chỉ được chọn MỘT đối tượng'),
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
                            title: Text(
                              'CHI TIẾT PHIẾU',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            content: ChiTietPhieuXuat(
                              maphieuxuat: selectedData.removeLast(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.blueGrey[800]),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.white,
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
                      'XEM CHI TIẾT',
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
                          insetPadding: EdgeInsets.symmetric(vertical: 100),
                          title: Text(
                            'PHIẾU XUẤT KHO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          content: ThemPhieuXuatKho(
                            formkey: formKey,
                            isCheck: false,
                            newMaDaiLy: _newMaDaiLy,
                            newMaPhieuXuat: _newMaPhieuXuat,
                            newNgayXuat: _newNgayXuat,
                            newSoTienNo: _newSoTienNo,
                            newThanhTien: _newThanhTien,
                            ngayxuatSub: _ngayxuatSub,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  var addData =
                                      await supabaseManager.addDataPhieuXuat(
                                          int.parse(_newMaPhieuXuat.text),
                                          int.parse(_newMaDaiLy.text),
                                          int.parse(_newSoTienNo.text),
                                          _newNgayXuat.text);
                                  _newMaDaiLy.clear();
                                  _newMaPhieuXuat.clear();
                                  _newSoTienNo.clear();
                                  _newThanhTien.clear();
                                  _newNgayXuat.clear();
                                  _ngayxuatSub.value = null;
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                  if (addData != null) {
                                    _showTopFlash(
                                        Colors.white,
                                        TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        'Thêm phiếu nhập không thành công');
                                  } else {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'Thêm phiếu nhập thành công!!!');
                                  }
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
                                  _newMaDaiLy.clear();
                                  _newMaPhieuXuat.clear();
                                  _newSoTienNo.clear();
                                  _newThanhTien.clear();
                                  _newNgayXuat.clear();
                                  _ngayxuatSub.value = null;
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
                      'THÊM',
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
                                  Text('Bạn vẫn chưa chọn đối tượng để xóa'),
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
                            title: Text('Bạn chắc chắn muốn xóa?'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  while (selectedData.isNotEmpty) {
                                    var delData = await supabaseManager
                                        .deleteDataPhieuXuat(
                                            selectedData.removeLast());
                                    if (delData != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'Xóa phiếu nhập không thành công');
                                    }
                                    break;
                                  }
                                  if (selectedData.isEmpty) {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'Xóa phiếu nhập thành công!!!');
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
                      'XÓA',
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
                              content: Text('Bạn chưa chọn đối tượng để sửa'),
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
                              content: Text('Bạn chỉ được chọn MỘT đối tượng'),
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
                      _newMaPhieuXuat.text = selectedRow[0][0].toString();
                      _newNgayXuat.text = selectedRow[0][1].toString();
                      _newMaDaiLy.text = selectedRow[0][2].toString();
                      _newThanhTien.text = selectedRow[0][3].toString();
                      _newSoTienNo.text = selectedRow[0][4].toString();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding: EdgeInsets.symmetric(vertical: 100),
                            title: Text(
                              'SỬA PHIẾU XUẤT',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800]),
                            ),
                            content: ThemPhieuXuatKho(
                              formkey: formKey,
                              isCheck: true,
                              newMaDaiLy: _newMaDaiLy,
                              newMaPhieuXuat: _newMaPhieuXuat,
                              newNgayXuat: _newNgayXuat,
                              newSoTienNo: _newSoTienNo,
                              newThanhTien: _newThanhTien,
                              ngayxuatSub: _ngayxuatSub,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    var updateData = await supabaseManager
                                        .updatePhieuXuatData(
                                            int.parse(_newMaPhieuXuat.text),
                                            int.parse(_newMaDaiLy.text),
                                            _newNgayXuat.text,
                                            int.parse(_newSoTienNo.text));
                                    if (updateData != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'Sửa không thành công');
                                    } else {
                                      _showTopFlash(
                                          Colors.green,
                                          TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          'Sửa thành công!!!');
                                    }
                                    setState(() {
                                      _newMaDaiLy.clear();
                                      _newMaPhieuXuat.clear();
                                      _newNgayXuat.clear();
                                      _newSoTienNo.clear();
                                      _newThanhTien.clear();
                                      _ngayxuatSub.value = null;
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
                                      _newMaDaiLy.clear();
                                      _newMaPhieuXuat.clear();
                                      _newNgayXuat.clear();
                                      _newSoTienNo.clear();
                                      _newThanhTien.clear();
                                      _ngayxuatSub.value = null;
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
                      'SỬA',
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
          Expanded(child: ListPhieuXuat())
        ],
      ),
    );
  }

  Widget ListPhieuXuat() {
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
    final columns = [
      'MÃ PHIẾU XUẤT',
      'NGÀY XUẤT',
      'MÃ ĐẠI LÝ',
      'THÀNH TIỀN',
      'SỐ TIỀN NỢ',
    ];

    SupabaseManager supabaseManager = SupabaseManager();
    return FutureBuilder(
      future: supabaseManager.readData('PHIEUXUATHANG'),
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
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ))
      .toList();

  List<DataRow> getRows(List<dynamic> users) => users.map((dynamic user) {
        final temp = (user as Map<String, dynamic>);
        final cells = [
          temp['maphieuxuat'],
          temp['ngayxuat'],
          temp['madaily'],
          temp['thanhtien'],
          temp['sotienno'],
        ];

        return DataRow(
          cells: getCells(cells),
          selected: selectedData.contains(cells[0]),
          onSelectChanged: (isSelected) => setState(() {
            final isAdding = isSelected != null && isSelected;
            isAdding
                ? selectedData.add(cells[0])
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
