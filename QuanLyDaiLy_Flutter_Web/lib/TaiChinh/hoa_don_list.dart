import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
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
  String search = "";
  String newMaHD = "";
  String newNgayThu = "";
  String newMADL = "";
  String newSoTienThu = "";

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
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "DANH SÁCH CÁC HÓA ĐƠN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      // khung tìm kiếm theo mã đại lý
                      Container(
                          width: 250,
                          height: 30,
                          padding: EdgeInsets.only(
                              left: 20, right: 10, bottom: 5, top: 5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white70),
                          child: Form(
                            key: formKeySearch,
                            child: TextFormField(
                              validator: (value) {
                                try {
                                  int.parse(value!);
                                } catch (e) {
                                  return 'Nhập mã không hợp lệ';
                                }
                              },
                              onChanged: (value) {
                                search = value;
                                if (value.isEmpty) {
                                  setState(() {
                                    selectedData.clear();
                                  });
                                }
                              },
                              autofocus: true,
                              style: TextStyle(color: Colors.blueGrey[800]),
                              cursorColor: Colors.blueGrey[800],
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Tìm kiếm',
                                  hintStyle: TextStyle(color: Colors.black54),
                                  suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.blueGrey[800],
                                    ),
                                    onPressed: () {
                                      final isValid = formKeySearch
                                          .currentState!
                                          .validate();
                                      if (isValid) {
                                        setState(() {
                                          selectedData.add(int.parse(search));
                                        });
                                      }
                                    },
                                  )),
                            ),
                          ))
                    ],
                  ),
                ),
                Expanded(child: Container()),
                // Tạo nút thêm (thêm HÓA ĐƠN)
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.symmetric(vertical: 100),
                          title: Text(
                            'THÊM HÓA ĐƠN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          content: themhoadon(),
                          actions: [
                            TextButton(
                              onPressed: () {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  supabaseManager.addDataHoaDon(
                                      int.parse(newMaHD),
                                      newNgayThu,
                                      int.parse(newMADL),
                                      int.parse(newSoTienThu));
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
                      'THÊM',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),

                // Tạo nút xóa (xóa đại lý)
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
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Bạn chắc chắn muốn xóa?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  while (selectedData.isNotEmpty) {
                                    supabaseManager.deleteDataHoaDon(
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

                // Tạo nút sửa (sửa đại lý)
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
                      newMaHD = selectedRow[0][0].toString();
                      newNgayThu = selectedRow[0][1].toString();
                      newMADL = selectedRow[0][2].toString();
                      newSoTienThu = selectedRow[0][3].toString();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding: EdgeInsets.symmetric(vertical: 100),
                            title: Text(
                              'SỬA ĐẠI LÝ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800]),
                            ),
                            content: themhoadon(check_sua: false),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    supabaseManager.updateHoaDonData(
                                        int.parse(newMaHD),
                                        newNgayThu,
                                        int.parse(newMADL),
                                        int.parse(newSoTienThu));
                                    setState(() {
                                      search = "";
                                      newMaHD = "";
                                      newNgayThu = "";
                                      newMADL = "";
                                      newSoTienThu = "";
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
                                      search = "";
                                      newMaHD = "";
                                      newNgayThu = "";
                                      newMADL = "";
                                      newSoTienThu = "";
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
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.blueGrey[300],
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
      'MÃ HÓA ĐƠN',
      'NGÀY THU TIỀN',
      'MÃ ĐẠI LÝ',
      'SỐ TIỀN THU',
    ];

    return FutureBuilder(
      future: supabaseManager.readData('HOADONTHUTIEN'),
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
                  color: Colors.blueGrey[800],
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ))
      .toList();

  List<DataRow> getRows(List<dynamic> users) => users.map((dynamic user) {
        final temp = (user as Map<String, dynamic>);
        final cells = [
          temp['mahoadon'],
          temp['ngaythu'],
          temp['madaily'],
          temp['sotienthu'],
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

  // Phiếu thêm hóa đơn
  Widget themhoadon({bool check_sua = true}) {
    return Container(
      alignment: Alignment.center,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tạo hàng để điền thông tin MÃ HÓA ĐƠN
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'MÃ HÓA ĐƠN',
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: check_sua
                              ? Colors.blueGrey
                              : Colors.blueGrey[300],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        enabled: check_sua,
                        initialValue: newMaHD,
                        style: TextStyle(color: Colors.white),
                        autofocus: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(border: InputBorder.none),
                        onChanged: (value) {
                          newMaHD = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bạn chưa nhập MÃ HÓA ĐƠN";
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
            // Tạo hàng để điền thông tin NGÀY THU TIỀN
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'NGÀY THU TIỀN',
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
                        autofocus: check_sua ? false : true,
                        initialValue: newNgayThu,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(border: InputBorder.none),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bạn chưa nhập NGÀY THU TIỀN";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          newNgayThu = value;
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Tạo hàng thêm MÃ ĐẠI LÝ
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'MÃ ĐẠI LÝ',
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
                        initialValue: newMADL,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(border: InputBorder.none),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bạn chưa nhập MÃ ĐẠI LÝ";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          newMADL = value;
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Tạo hàng thêm SỐ TIỀN THU
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'SỐ TIỀN THU',
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
                        initialValue: newSoTienThu,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(border: InputBorder.none),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bạn chưa nhập SỐ TIỀN THU";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          newSoTienThu = value;
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
}
