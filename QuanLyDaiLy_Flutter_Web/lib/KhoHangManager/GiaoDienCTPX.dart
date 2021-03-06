import 'package:do_an/KhoHangManager/GiaoDienThemCTPX.dart';
import 'package:do_an/Models/ChiTietPhieuXuatClass.dart';
import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flutter/material.dart';

class ChiTietPhieuXuat extends StatefulWidget {
  final int maphieuxuat;
  const ChiTietPhieuXuat({Key? key, required this.maphieuxuat})
      : super(key: key);

  @override
  _ChiTietPhieuXuatState createState() => _ChiTietPhieuXuatState();
}

class _ChiTietPhieuXuatState extends State<ChiTietPhieuXuat> {
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  List<int> selectedData = [];
  TextEditingController _newMaMH = TextEditingController();
  TextEditingController _newSoluong = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.blueGrey[200],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Row(
              children: [
                // Hiện thị mã phiếu nhập
                Container(
                  margin: EdgeInsets.all(10),
                  height: 30,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.blueGrey[300]),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'MÃ PHIẾU XUẤT',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.maphieuxuat.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(child: Container()),
                // Tạo nút thêm
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.symmetric(vertical: 190),
                          title: Text(
                            'THÊM MẶT HÀNG XUẤT',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          content: GiaoDienThemMHCTPX(
                            formKey: formKey,
                            maMH: _newMaMH,
                            soluong: _newSoluong,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                var isValid = formKey.currentState!.validate();
                                if (isValid) {
                                  var addData = await CTPX()
                                      .addChiTietPhieuXuat(
                                          widget.maphieuxuat,
                                          int.parse(_newMaMH.text),
                                          int.parse(_newSoluong.text));
                                  _newMaMH.clear();
                                  _newSoluong.clear();
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                  if (addData != null) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                      addData,
                                      style: TextStyle(color: Colors.red),
                                    )));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                      'Nhập thành công',
                                    )));
                                  }
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
                                  _newMaMH.clear();
                                  _newSoluong.clear();
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel',
                                    style: TextStyle(
                                        color: Colors.blueGrey[800],
                                        fontWeight: FontWeight.bold)))
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 75,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[500],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'THÊM',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                // Thêm nút xóa
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
                            title: Text('Bạn chắc chắn muốn xóa'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  while (selectedData.isNotEmpty) {
                                    await CTPX().deleteChiTietPhieuXuat(
                                        widget.maphieuxuat,
                                        selectedData.removeLast());
                                  }
                                  setState(() {
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
                    height: 30,
                    width: 75,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: selectedData.isEmpty
                            ? Colors.blueGrey[200]
                            : Colors.blueGrey[500],
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
              ],
            ),
            Container(
                height: 500,
                child: ScrollableWidget(
                    child: buildDataTableChitietPhieu(widget.maphieuxuat))),
          ],
        ));
  }

  Widget buildDataTableChitietPhieu(int _maphieuxuat) {
    final columns = [
      'MÃ MẶT HÀNG',
      'TÊN MẶT HÀNG',
      'ĐƠN VỊ',
      'SỐ LƯỢNG',
      'GIÁ XUẤT'
    ];

    return FutureBuilder(
      future: CTPX().readChiTietPhieuXuat(_maphieuxuat),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return Builder(
          builder: (context) {
            return DataTable(
              columns: getColumns(columns),
              rows: getRowsChiTietPhieu((snapshot.data as List<CTPX>)),
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

  List<DataRow> getRowsChiTietPhieu(List<CTPX> users) => users.map((CTPX user) {
        final cells = [
          user.mamathang,
          user.tenmathang,
          user.donvi,
          user.soluongxuat,
          user.giaxuat
        ];
        return DataRow(
          cells: getCells(cells),
          selected: selectedData.contains(cells[0]),
          onSelectChanged: (isSelected) => setState(() {
            final isAdding = isSelected != null && isSelected;
            isAdding
                ? selectedData.add(cells[0] as int)
                : selectedData.remove(cells[0]);
          }),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) {
        return DataCell(Text('$data'));
      }).toList();
}
