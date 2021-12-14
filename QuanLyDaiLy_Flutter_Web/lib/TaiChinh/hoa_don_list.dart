import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/TaiChinh/them_hoa_don.dart';
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
                          "DANH SÁCH PHIẾU THU TIỀN",
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
                                  hindText1: "Nhập mã phiếu",
                                  hindText2: "Nhập mã đại lý",
                                  hindText3: "Nhập tên đại lý")),
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
                // Tạo nút thêm (thêm HÓA ĐƠN)
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.symmetric(vertical: 100),
                          title: Text(
                            'THÊM PHIẾU THU TIỀN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          content: ThemHoaDon(
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
                                      await supabaseManager.addDataHoaDon(
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
                                        'Thêm hóa đơn không thành công');
                                  } else {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'Thêm hóa đơn thành công!!!');
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
                      'THÊM',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),

                // Tạo nút xóa (xóa hóa đơn)
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
                                  var delData;
                                  while (selectedData.isNotEmpty) {
                                    delData =
                                        await supabaseManager.deleteDataHoaDon(
                                            selectedData.removeLast());
                                    if (delData != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'Xóa hóa đơn không thành công');
                                      break;
                                    }
                                  }
                                  if (delData == null) {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'Xóa hóa đơn thành công!!!');
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
                              'SỬA PHIẾU THU TIỀN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800]),
                            ),
                            content: ThemHoaDon(
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
                                        await supabaseManager.updateHoaDonData(
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
                                          'Sửa hóa đơn không thành công');
                                    } else {
                                      _showTopFlash(
                                          Colors.green,
                                          TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          'Sửa hóa đơn thành công!!!');
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
      future: supabaseManager.readDataChiTietPhieuThu(
          _searchMa.text, _searchMaDl.text, _searchTenDL.text),
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
