import 'package:do_an/NhanVien/them_nhan_vien.dart';
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
  TextEditingController _searchTen = TextEditingController();
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
                          "DANH SÁCH CÁC NHÂN VIÊN",
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
                                  searchTen: _searchTen,
                                  searchLoai: _searchChucvu,
                                  hindText1: 'Nhập mã nhân viên',
                                  hindText2: 'Nhập tên nhân viên',
                                  hindText3: "Nhập chức vụ")),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey[800]),
                              onPressed: () {},
                              child: Text('Search'))
                        ],
                      ),
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
                            ElevatedButton(
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
                                    _showTopFlash(
                                        Colors.white,
                                        TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        'Thêm nhân viên không thành công');
                                  } else {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'Thêm nhân viên thành công');
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
                            title: Text('Bạn chắc chắn muốn xóa?'),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  var data;
                                  while (selectedData.isNotEmpty) {
                                    data = await supabaseManager
                                        .deleteDataNhanVien(
                                            selectedData.removeLast());
                                    if (data != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'Xóa nhân viên không thành công');
                                      break;
                                    }
                                  }
                                  if (data == null) {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'Xóa nhân viên thành công');
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
                              content: Text('Bạn chỉ được chọn MỘT đối tượng'),
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
                              ElevatedButton(
                                onPressed: () async {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    var data = await supabaseManager
                                        .updateNhanVienData(
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
                                          'Sửa không thành công');
                                    } else {
                                      _showTopFlash(
                                          Colors.green,
                                          TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          'Sửa thành công');
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
