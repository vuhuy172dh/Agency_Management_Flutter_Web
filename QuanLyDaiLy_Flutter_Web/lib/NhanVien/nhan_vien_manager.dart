import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
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
  String search = "";
  String newMaNV = "";
  String newHoten = "";
  String newGioiTinh = "";
  String newPhone = "";
  String newDiaChi = "";
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
                        "DANH SÁCH CÁC NHÂN VIÊN",
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
                // Tạo nút thêm (thêm NHÂN VIÊN)
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'THÊM NHÂN VIÊN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          content: themnhanvien(),
                          actions: [
                            TextButton(
                              onPressed: () {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  supabaseManager.addDataNhanVien(
                                      int.parse(newMaNV),
                                      newHoten,
                                      newGioiTinh,
                                      int.parse(newPhone),
                                      newDiaChi);
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

                // Tạo nút xóa (xóa NHÂN VIÊN)
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
                                    supabaseManager.deleteDataDaiLy(
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
                      newMaNV = selectedRow[0][0].toString();
                      newHoten = selectedRow[0][1].toString();
                      newGioiTinh = selectedRow[0][2].toString();
                      newPhone = selectedRow[0][3].toString();
                      newDiaChi = selectedRow[0][4].toString();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'SỬA THÔNG TIN NHÂN VIÊN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800]),
                            ),
                            content: themnhanvien(check_sua: false),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    supabaseManager.updateNhanVienData(
                                        int.parse(newMaNV),
                                        newHoten,
                                        newGioiTinh,
                                        int.parse(newPhone),
                                        newDiaChi);
                                    setState(() {
                                      search = "";
                                      newMaNV = "";
                                      newHoten = "";
                                      newGioiTinh = "";
                                      newPhone = "";
                                      newDiaChi = "";
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
                                      newMaNV = "";
                                      newHoten = "";
                                      newGioiTinh = "";
                                      newPhone = "";
                                      newDiaChi = "";
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
      'MÃ NHÂN VIÊN',
      'HỌ VÀ TÊN',
      'GIỚI TÍNH',
      'CHỨC VỤ',
      'SỐ ĐIỆN THOẠI',
      'EMAIL',
    ];

    return FutureBuilder(
      future: supabaseManager.readData('NHANVIEN'),
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
          temp['manhanvien'],
          temp['hoten'],
          temp['gioitinh'],
          temp['chucvu'],
          temp['sodienthoai'],
          temp['emal'],
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

  // tạo THÊM NHÂN VIÊN
  Widget themnhanvien({bool check_sua = true}) {
    return Container(
      alignment: Alignment.center,
      child: Form(
        key: formKey,
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
                          color: check_sua
                              ? Colors.blueGrey
                              : Colors.blueGrey[300],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        enabled: check_sua,
                        initialValue: newMaNV,
                        style: TextStyle(color: Colors.white),
                        autofocus: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(border: InputBorder.none),
                        onChanged: (value) {
                          newMaNV = value;
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
                        autofocus: check_sua ? false : true,
                        initialValue: newHoten,
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
                          newHoten = value;
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
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        initialValue: newGioiTinh,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(border: InputBorder.none),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bạn chưa nhập GIỚI TÍNH";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          newGioiTinh = value;
                        },
                      ),
                    ),
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
                        initialValue: newPhone,
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
                          newPhone = value;
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Tạo thàng thêm ĐỊA CHỈ
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'ĐỊA CHỈ',
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
                        initialValue: newDiaChi,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(border: InputBorder.none),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bạn chưa nhập ĐỊA CHỈ";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          newDiaChi = value;
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
