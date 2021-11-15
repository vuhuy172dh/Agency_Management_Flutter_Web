import 'package:do_an/Kho_hang_Manager/themMH_into_ChiTietPhieuNhap.dart';
import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class ChiTietPhieuNhap extends StatefulWidget {
  final maphieunhap;
  const ChiTietPhieuNhap({Key? key, required this.maphieunhap})
      : super(key: key);

  @override
  _ChiTietPhieuNhapState createState() => _ChiTietPhieuNhapState();
}

class _ChiTietPhieuNhapState extends State<ChiTietPhieuNhap> {
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  List<int> selectedData = [];
  final formKey = GlobalKey<FormState>();
  final TextEditingController maMH = TextEditingController();
  final TextEditingController soluong = TextEditingController();
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
                          'MÃ PHIẾU NHẬP',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.maphieunhap.toString(),
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
                            'THÊM MẶT HÀNG',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          content: ThemMHCTPN(
                            formKey: formKey,
                            maMH: maMH,
                            soluong: soluong,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                var isValid = formKey.currentState!.validate();
                                if (isValid) {
                                  var addData =
                                      await supabaseManager.addDataCTPN(
                                          widget.maphieunhap,
                                          int.parse(maMH.text),
                                          int.parse(soluong.text));
                                  maMH.clear();
                                  soluong.clear();
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
                                    await supabaseManager.deleteDataCTPN(
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
                    child: buildDataTableChitietPhieu(widget.maphieunhap))),
          ],
        ));
  }

  Widget buildDataTableChitietPhieu(int _maphieunhap) {
    final columns = [
      'MÃ MẶT HÀNG',
      'TÊN MẶT HÀNG',
      'ĐƠN VỊ',
      'SỐ LƯỢNG',
      'GIÁ NHẬP'
    ];

    return FutureBuilder(
      future: supabaseManager.readDataChiTietPhieuNhap(_maphieunhap),
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
              rows: getRowsChiTietPhieu(
                  (datasets['Supabase Query'] as List<dynamic>)),
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

  List<DataRow> getRowsChiTietPhieu(List<dynamic> users) =>
      users.map((dynamic user) {
        final temp = (user as Map<String, dynamic>);
        final cells = [
          temp['_mamathang'],
          temp['_tenmathang'],
          temp['_donvi'],
          temp['_soluongnhap'],
          temp['_gianhap']
        ];
        final cell_temp = [temp['_stt']];

        return DataRow(
          cells: getCells(cells),
          selected: selectedData.contains(cell_temp[0]),
          onSelectChanged: (isSelected) => setState(() {
            final isAdding = isSelected != null && isSelected;
            isAdding
                ? selectedData.add(cell_temp[0])
                : selectedData.remove(cell_temp[0]);
          }),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) {
        return DataCell(Text('$data'));
      }).toList();
}