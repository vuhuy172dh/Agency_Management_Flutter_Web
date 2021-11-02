import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
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
  String _maphieu = "";
  String _ngay = "";
  String _madaily = "";
  String _mamathang = "";
  String _soluong = "";
  String _gia = "";
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
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'DANH SÁCH PHIẾU XUẤT',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.symmetric(vertical: 50),
                          title: Text(
                            'PHIẾU XUẤT KHO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          content: phieuxuat(),
                          actions: [
                            TextButton(
                              onPressed: () {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  supabaseManager.addDataPhieuXuat(
                                      int.parse(_maphieu),
                                      int.parse(_madaily),
                                      int.parse(_mamathang),
                                      _ngay,
                                      int.parse(_soluong),
                                      int.parse(_gia));
                                  setState(() {
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
                                onPressed: () {
                                  print(selectedData);
                                  while (selectedData.isNotEmpty) {
                                    supabaseManager.deleteDataPhieuXuat(
                                        selectedData.removeLast());
                                  }
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
                      _maphieu = selectedRow[0][1].toString();
                      _ngay = selectedRow[0][2].toString();
                      _madaily = selectedRow[0][3].toString();
                      _mamathang = selectedRow[0][4].toString();
                      _soluong = selectedRow[0][5].toString();
                      _gia = selectedRow[0][6].toString();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'SỬA PHIẾU XUẤT',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800]),
                            ),
                            content: phieuxuat(),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    supabaseManager.updatePhieuXuatData(
                                        int.parse(_maphieu),
                                        int.parse(_madaily),
                                        int.parse(_mamathang),
                                        _ngay,
                                        int.parse(_soluong),
                                        int.parse(_gia));
                                    setState(() {
                                      _maphieu = "";
                                      _ngay = "";
                                      _madaily = "";
                                      _mamathang = "";
                                      _soluong = "";
                                      _gia = "";
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
                                      _maphieu = "";
                                      _ngay = "";
                                      _madaily = "";
                                      _mamathang = "";
                                      _soluong = "";
                                      _gia = "";
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
      'MÃ MẶT HÀNG',
      'SỐ LƯỢNG',
      'GIÁ',
    ];

    SupabaseManager supabaseManager = SupabaseManager();
    return FutureBuilder(
      future: supabaseManager.readData('PHIEUXUATKHO'),
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
          temp['ngayxuatkho'],
          temp['madaily'],
          temp['mamathang'],
          temp['soluong'],
          temp['gia']
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

  Widget phieuxuat() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        alignment: Alignment.center,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                height: 60,
                width: 600,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.blueGrey),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      width: 200,
                      child: Text('MÃ PHIẾU XUẤT',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextFormField(
                        initialValue: _maphieu,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Chưa nhập MÃ PHIẾU";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _maphieu = value;
                        },
                        cursorColor: Colors.blueGrey[800],
                        style: TextStyle(color: Colors.blueGrey[800]),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                height: 60,
                width: 600,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.blueGrey),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      width: 200,
                      child: Text('NGÀY XUẤT KHO',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextFormField(
                        initialValue: _ngay,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Chưa nhập NGÀY XUẤT";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _ngay = value;
                        },
                        cursorColor: Colors.blueGrey[800],
                        style: TextStyle(color: Colors.blueGrey[800]),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                height: 60,
                width: 600,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.blueGrey),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      width: 200,
                      child: Text('MÃ ĐẠI LÝ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Chưa nhập MÃ ĐẠI LÝ";
                          } else {
                            return null;
                          }
                        },
                        initialValue: _madaily,
                        onChanged: (value) {
                          _madaily = value;
                        },
                        cursorColor: Colors.blueGrey[800],
                        style: TextStyle(color: Colors.blueGrey[800]),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                height: 60,
                width: 600,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.blueGrey),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      width: 200,
                      child: Text('MÃ MẶT HÀNG',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextFormField(
                        initialValue: _mamathang,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Chưa nhập MÃ MẶT HÀNG";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _mamathang = value;
                        },
                        cursorColor: Colors.blueGrey[800],
                        style: TextStyle(color: Colors.blueGrey[800]),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                height: 60,
                width: 600,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.blueGrey),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      width: 200,
                      child: Text('SỐ LƯỢNG',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextFormField(
                        initialValue: _soluong,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Chưa nhập SỐ LƯỢNG";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _soluong = value;
                        },
                        cursorColor: Colors.blueGrey[800],
                        style: TextStyle(color: Colors.blueGrey[800]),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                height: 60,
                width: 600,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.blueGrey),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      width: 200,
                      child: Text(
                        'GIÁ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextFormField(
                        initialValue: _gia,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Chưa nhập Giá";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _gia = value;
                        },
                        cursorColor: Colors.blueGrey[800],
                        style: TextStyle(color: Colors.blueGrey[800]),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )),
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
