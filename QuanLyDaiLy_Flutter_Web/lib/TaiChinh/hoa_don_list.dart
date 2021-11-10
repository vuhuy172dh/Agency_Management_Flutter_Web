import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/TaiChinh/them_hoa_don.dart';
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
  TextEditingController newMaHoaDon = TextEditingController();
  TextEditingController newMaDL = TextEditingController();
  TextEditingController newNgayThu = TextEditingController();
  TextEditingController newSoTienThu = TextEditingController();
  final ValueNotifier<DateTime?> _ngaythuSub = ValueNotifier(null);

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
                          content: ThemHoaDon(
                            formKey: formKey,
                            isCheck: false,
                            newMaPhieu: newMaHoaDon,
                            newMaDL: newMaDL,
                            newSoTienThu: newSoTienThu,
                            newNgayThu: newNgayThu,
                            ngaythuSub: _ngaythuSub,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  var addData =
                                      await supabaseManager.addDataHoaDon(
                                          int.parse(newMaHoaDon.text),
                                          newNgayThu.text,
                                          int.parse(newMaDL.text),
                                          int.parse(newSoTienThu.text));
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
                                  setState(() {
                                    newMaDL.clear();
                                    newMaHoaDon.clear();
                                    newNgayThu.clear();
                                    newSoTienThu.clear();
                                    _ngaythuSub.value = null;
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
                                  newMaDL.clear();
                                  newMaHoaDon.clear();
                                  newNgayThu.clear();
                                  newSoTienThu.clear();
                                  _ngaythuSub.value = null;
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
                                onPressed: () async {
                                  while (selectedData.isNotEmpty) {
                                    var delData =
                                        await supabaseManager.deleteDataHoaDon(
                                            selectedData.removeLast());
                                    if (delData != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        delData,
                                        style: TextStyle(color: Colors.red),
                                      )));
                                      break;
                                    }
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
                      newMaHoaDon.text = selectedRow[0][0].toString();
                      newMaDL.text = selectedRow[0][1].toString();
                      newNgayThu.text = selectedRow[0][7].toString();
                      newSoTienThu.text = selectedRow[0][6].toString();
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
                            content: ThemHoaDon(
                              formKey: formKey,
                              isCheck: true,
                              newMaPhieu: newMaHoaDon,
                              newMaDL: newMaDL,
                              newSoTienThu: newSoTienThu,
                              newNgayThu: newNgayThu,
                              ngaythuSub: _ngaythuSub,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    var updateData =
                                        await supabaseManager.updateHoaDonData(
                                            int.parse(newMaHoaDon.text),
                                            newNgayThu.text,
                                            int.parse(newMaDL.text),
                                            int.parse(newSoTienThu.text));
                                    if (updateData != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        updateData,
                                        style: TextStyle(color: Colors.red),
                                      )));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        'Sửa thành công',
                                      )));
                                    }
                                    setState(() {
                                      newMaDL.clear();
                                      newMaHoaDon.clear();
                                      newNgayThu.clear();
                                      newSoTienThu.clear();
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
                                      newMaDL.clear();
                                      newMaHoaDon.clear();
                                      newNgayThu.clear();
                                      newSoTienThu.clear();
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
      'MÃ PHIẾU THU TIỀN',
      'MÃ ĐẠI LÝ',
      'TÊN ĐẠI LÝ',
      'QUẬN',
      'SỐ ĐIỆN THOẠI',
      'EMAIL',
      'SỐ TIỀN THU',
      'NGÀY THU'
    ];

    return FutureBuilder(
      future: supabaseManager.readDataChiTietPhieuThu(),
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
          temp['_maphieuthu'],
          temp['_madaily'],
          temp['_tendaily'],
          temp['_quan'],
          temp['_sodienthoai'],
          temp['_email'],
          temp['_sotienthu'],
          temp['_ngaythu']
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
