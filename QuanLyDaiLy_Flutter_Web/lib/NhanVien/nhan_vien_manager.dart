import 'package:do_an/NhanVien/them_nhan_vien.dart';
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
  TextEditingController _manhanvien = TextEditingController();
  TextEditingController _tennhanvien = TextEditingController();
  TextEditingController _gioitinh = TextEditingController();
  TextEditingController _chucvu = TextEditingController();
  TextEditingController _sodienthoai = TextEditingController();
  TextEditingController _email = TextEditingController();

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
                          content: ThemNhanVien(
                              formKey: formKey,
                              isCheck: false,
                              newmaNV: _manhanvien,
                              newtenNB: _tennhanvien,
                              newGioiTinh: _gioitinh,
                              newChucVu: _chucvu,
                              newSodienthoai: _sodienthoai,
                              newEmail: _email),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  var addData =
                                      await supabaseManager.addDataNhanVien(
                                          int.parse(_manhanvien.text),
                                          _tennhanvien.text,
                                          _gioitinh.text,
                                          int.parse(_sodienthoai.text),
                                          _email.text,
                                          _chucvu.text);
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
                                      'Thêm Thành Công',
                                    )));
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
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextButton(
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
                                onPressed: () async {
                                  while (selectedData.isNotEmpty) {
                                    await supabaseManager.deleteDataNhanVien(
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
                              'SỬA THÔNG TIN NHÂN VIÊN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800]),
                            ),
                            content: ThemNhanVien(
                                formKey: formKey,
                                isCheck: true,
                                newmaNV: _manhanvien,
                                newtenNB: _tennhanvien,
                                newGioiTinh: _gioitinh,
                                newChucVu: _chucvu,
                                newSodienthoai: _sodienthoai,
                                newEmail: _email),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    await supabaseManager.updateNhanVienData(
                                        int.parse(_manhanvien.text),
                                        _tennhanvien.text,
                                        _gioitinh.text,
                                        int.parse(_sodienthoai.text),
                                        _email.text,
                                        _chucvu.text);
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
          temp['email'],
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
