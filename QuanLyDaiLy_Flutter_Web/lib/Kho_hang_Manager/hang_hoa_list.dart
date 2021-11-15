import 'package:do_an/Kho_hang_Manager/them_mat_hang.dart';
import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/tim_kiem.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class HangHoaList extends StatefulWidget {
  const HangHoaList({Key? key}) : super(key: key);

  @override
  _HangHoaListState createState() => _HangHoaListState();
}

class _HangHoaListState extends State<HangHoaList> {
  final formKey = GlobalKey<FormState>();
  final formSearchKey = GlobalKey<FormState>();
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  List<int> selectedData = [];
  List<dynamic> selectedRow = [];
  TextEditingController _newMaMH = TextEditingController();
  TextEditingController _newName = TextEditingController();
  TextEditingController _newDonVi = TextEditingController();
  TextEditingController _newGiaNhap = TextEditingController();
  TextEditingController _newGiaXuat = TextEditingController();
  TextEditingController _newSoLuong = TextEditingController();
  TextEditingController _newNgaySX = TextEditingController();
  TextEditingController _newHanSD = TextEditingController();
  final ValueNotifier<DateTime?> nsxSub = ValueNotifier(null);
  final ValueNotifier<DateTime?> hsdSub = ValueNotifier(null);
  TextEditingController _searchMa = TextEditingController();
  TextEditingController _searchTen = TextEditingController();
  TextEditingController _searchSoluong = TextEditingController();

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
                      width: 300,
                      child: Text(
                        'DANH SÁCH MẶT HÀNG',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: [
                        TimKiem(
                            formKey: formSearchKey,
                            searchMa: _searchMa,
                            searchTen: _searchTen,
                            searchLoai: _searchSoluong,
                            hindText1: 'Nhập mã mặt hàng',
                            hindText2: 'Nhập tên mặt hàng',
                            hindText3: 'Nhập số lượng'),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey[800]),
                          onPressed: () {
                            setState(() {});
                          },
                          child: Text('Search'),
                        ),
                      ]),
                    )
                  ],
                ),
                Expanded(child: Container()),
                // tạo nút THÊM
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text(
                            'THÊM MẶT HÀNG',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          content: ThemMatHang(
                            isCheck: false,
                            formKey: formKey,
                            newMaMH: _newMaMH,
                            newTenMH: _newName,
                            newDonVi: _newDonVi,
                            newGiaNhap: _newGiaNhap,
                            newGiaXuat: _newGiaXuat,
                            newNgaySanXuat: _newNgaySX,
                            newHanSuDung: _newHanSD,
                            newSoluong: _newSoLuong,
                            nsxSub: nsxSub,
                            hsdSub: hsdSub,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  var addData = await supabaseManager.addDataMH(
                                      int.parse(_newMaMH.text),
                                      _newName.text,
                                      _newDonVi.text,
                                      int.parse(_newGiaNhap.text),
                                      int.parse(_newGiaXuat.text),
                                      _newNgaySX.text,
                                      _newHanSD.text);
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
                                      'Bạn Nhập Thành Công Mặt Hàng Mới',
                                    )));
                                  }
                                  _newName.clear();
                                  _newMaMH.clear();
                                  _newDonVi.clear();
                                  _newGiaNhap.clear();
                                  _newGiaXuat.clear();
                                  _newNgaySX.clear();
                                  _newHanSD.clear();
                                  _newSoLuong.clear();
                                  nsxSub.value = null;
                                  hsdSub.value = null;
                                  setState(() {
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
                                  _newName.clear();
                                  _newMaMH.clear();
                                  _newDonVi.clear();
                                  _newGiaNhap.clear();
                                  _newGiaXuat.clear();
                                  _newNgaySX.clear();
                                  _newHanSD.clear();
                                  _newSoLuong.clear();
                                  nsxSub.value = null;
                                  hsdSub.value = null;
                                  setState(() {
                                    Navigator.pop(context);
                                  });
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
                // Tạo nút xóa
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
                                    var deletedata =
                                        await supabaseManager.deleteDataHangHoa(
                                            selectedData.removeLast());
                                    if (deletedata != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        deletedata,
                                        style: TextStyle(color: Colors.red),
                                      )));
                                    }
                                    break;
                                  }
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
                // tạo nút sửa
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
                      _newMaMH.text = selectedRow[0][0].toString();
                      _newName.text = selectedRow[0][1].toString();
                      _newDonVi.text = selectedRow[0][2].toString();
                      _newGiaNhap.text = selectedRow[0][3].toString();
                      _newGiaXuat.text = selectedRow[0][4].toString();
                      _newSoLuong.text = selectedRow[0][5].toString();
                      _newNgaySX.text = selectedRow[0][6].toString();
                      _newHanSD.text = selectedRow[0][7].toString();

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text(
                              'SỬA MẶT HÀNG',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800]),
                            ),
                            content: ThemMatHang(
                              isCheck: true,
                              formKey: formKey,
                              newMaMH: _newMaMH,
                              newTenMH: _newName,
                              newDonVi: _newDonVi,
                              newGiaNhap: _newGiaNhap,
                              newGiaXuat: _newGiaXuat,
                              newNgaySanXuat: _newNgaySX,
                              newHanSuDung: _newHanSD,
                              newSoluong: _newSoLuong,
                              nsxSub: nsxSub,
                              hsdSub: hsdSub,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    var updateData =
                                        await supabaseManager.updateMHData(
                                            int.parse(_newMaMH.text),
                                            _newName.text,
                                            _newDonVi.text,
                                            int.parse(_newGiaNhap.text),
                                            int.parse(_newGiaXuat.text),
                                            _newNgaySX.text,
                                            _newHanSD.text);
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
                                        'Bạn Sửa Mặt Hàng Thành Công',
                                      )));
                                    }
                                  }
                                  setState(() {
                                    _newName.clear();
                                    _newMaMH.clear();
                                    _newDonVi.clear();
                                    _newGiaNhap.clear();
                                    _newGiaXuat.clear();
                                    _newNgaySX.clear();
                                    _newHanSD.clear();
                                    _newSoLuong.clear();
                                    nsxSub.value = null;
                                    hsdSub.value = null;
                                    selectedRow.clear();
                                    selectedData.clear();
                                    Navigator.pop(context);
                                  });
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
                                      _newMaMH.text = '';
                                      _newName.text = '';
                                      _newDonVi.text = '';
                                      _newGiaNhap.text = '';
                                      _newGiaXuat.text = '';
                                      _newSoLuong.text = '';
                                      _newNgaySX.text = '';
                                      _newHanSD.text = '';
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
          Expanded(
              child: Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                color: Colors.blueGrey[200],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: ScrollableWidget(child: buildDataTable()),
          ))
        ],
      ),
    );
  }

  Widget buildDataTable() {
    final columns = [
      'MÃ MẶT HÀNG',
      'TÊN MẶT HÀNG',
      'ĐƠN VỊ',
      'GIÁ NHẬP',
      'GIÁ XUẤT',
      'SỐ LƯỢNG',
      'NGÀY SẢN XUẤT',
      'HẠN SỬ DỤNG'
    ];

    return FutureBuilder(
      future: supabaseManager.readDataMatHang(
          _searchMa.text, _searchTen.text, _searchSoluong.text),
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
          temp['mamathang'],
          temp['tenmathang'],
          temp['donvi'],
          temp['gianhap'],
          temp['giaxuat'],
          temp['soluong'],
          temp['ngaysanxuat'],
          temp['hansudung']
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
