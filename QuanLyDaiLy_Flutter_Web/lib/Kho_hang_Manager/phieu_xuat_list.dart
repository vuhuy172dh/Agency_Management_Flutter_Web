import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class PhieuXuatList extends StatefulWidget {
  const PhieuXuatList({Key? key}) : super(key: key);

  @override
  _PhieuXuatListState createState() => _PhieuXuatListState();
}

List<int> selectedData = [];

class _PhieuXuatListState extends State<PhieuXuatList> {
  bool index = false;
  final datasets = <String, dynamic>{};
  @override
  Widget build(BuildContext context) {
    SupabaseManager supabaseManager = SupabaseManager();
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
                    index = !index;
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
                      index == false ? 'Thêm' : 'Back',
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
                        color: Colors.blueGrey[800],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'Xóa',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('hello');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 20),
                    height: 50,
                    width: 75,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[800],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      'Sửa',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: switchpage(index))
        ],
      ),
    );
  }

  Widget switchpage(bool index) {
    if (index == true) {
      return phieuxuat();
    } else {
      return ListPhieuXuat();
    }
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
      'SỐ THỨ TỰ',
      'MÃ PHIẾU XUẤT',
      'NGÀY XUẤT',
      'MÃ ĐẠI LÝ',
      'MÃ MẶT HÀNG',
      'SỐ LƯỢNG',
      'GIÁ',
    ];

    SupabaseManager supabaseManager = SupabaseManager();
    return FutureBuilder(
      future: supabaseManager.readData('Phieu_xuat_kho'),
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
          temp['So_TT'] as int,
          temp['id_MP'],
          temp['Ngay_xuat'] as String? ?? '',
          temp['id_DL'] as int,
          temp['id_MH'] as int,
          temp['So_luong'] as int,
          temp['Gia'] as int
        ];

        return DataRow(
          cells: getCells(cells),
          selected: selectedData.contains(cells[1]),
          onSelectChanged: (isSelected) => setState(() {
            final isAdding = isSelected != null && isSelected;
            isAdding
                ? selectedData.add(cells[1])
                : selectedData.remove(cells[1]);
          }),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) {
        return DataCell(Text('$data'));
      }).toList();

  Widget phieuxuat() {
    String? maphieu;
    String? ngay;
    String? madaily;
    String? mamathang;
    String? soluong;
    String? gia;

    SupabaseManager supabaseManager = SupabaseManager();
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "PHIẾU XUẤT KHO",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800]),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 7,
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
                    child: Text('Mã phiếu xuất',
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
                    child: TextField(
                      onChanged: (value) {
                        maphieu = value;
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
                    child: Text('Ngày xuất kho',
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
                    child: TextField(
                      onChanged: (value) {
                        ngay = value;
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
                    child: Text('Mã đại lý',
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
                    child: TextField(
                      onChanged: (value) {
                        madaily = value;
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
                    child: Text('Mã mặt hàng',
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
                    child: TextField(
                      onChanged: (value) {
                        mamathang = value;
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
                    child: Text('Số lượng',
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
                    child: TextField(
                      onChanged: (value) {
                        soluong = value;
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
                      'Giá',
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
                    child: TextField(
                      onChanged: (value) {
                        gia = value;
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
                width: 600,
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    supabaseManager.addDataPhieuXuat(
                      int.parse(maphieu!),
                      int.parse(madaily!),
                      int.parse(mamathang!),
                      ngay!,
                      int.parse(soluong!),
                      int.parse(gia!),
                    );
                    setState(() {
                      index = !index;
                    });
                  },
                  style:
                      ElevatedButton.styleFrom(primary: Colors.blueGrey[800]),
                  child: Text("OK"),
                ))
          ],
        ),
      ),
    );
  }
}
