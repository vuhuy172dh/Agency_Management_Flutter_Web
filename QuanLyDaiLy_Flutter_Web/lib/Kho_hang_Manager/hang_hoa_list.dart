import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class HangHoaList extends StatefulWidget {
  const HangHoaList({Key? key}) : super(key: key);

  @override
  _HangHoaListState createState() => _HangHoaListState();
}

class _HangHoaListState extends State<HangHoaList> {
  bool index = false;
  int? sortColumnIndex;
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  List<int> selectedData = [];
  List<String> addedData = [];

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
                      index == true ? 'Back' : 'Thêm',
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
                                  while (selectedData.isNotEmpty) {
                                    supabaseManager.deleteDataHangHoa(
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
                    margin: EdgeInsets.only(left: 20),
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
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    print('hello');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[800],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 15,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
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

  Widget ListHangHoa() {
    return Container(
      margin: EdgeInsets.all(5),
      alignment: Alignment.topCenter,
      //width: double.maxFinite,
      //height: 500,
      decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: ScrollableWidget(child: buildDataTable()),
    );
  }

  Widget buildDataTable() {
    final columns = [
      'MÃ MẶT HÓA',
      'TÊN MẶT HÀNG',
      'ĐƠN VỊ',
      'GIÁ',
    ];

    return FutureBuilder(
      future: supabaseManager.readData('Hang_hoa'),
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
          temp['id_MH'],
          temp['Name_HH'] as String? ?? '',
          temp['Don_vi'] as String? ?? '',
          temp['Gia'] as int
        ];

        return DataRow(
          cells: getCells(cells),
          selected: selectedData.contains(cells[0]),
          onSelectChanged: (isSelected) => setState(() {
            final isAdding = isSelected != null && isSelected;
            isAdding
                ? selectedData.add(cells[0])
                : selectedData.remove(cells[0]);
          }),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) {
        return DataCell(Text('$data'));
      }).toList();

  Widget switchpage(bool index) {
    if (index == true) {
      return ThemMHPage();
    } else {
      return ListHangHoa();
    }
  }

  Widget ThemMHPage() {
    String _newMaMH = '';
    String _newName = '';
    String _newDonVi = '';
    String _newGia = '';
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
              "THÊM MẶT HÀNG",
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
                    child: Text('Mã Mặt Hàng',
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
                        _newMaMH = value;
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
                    child: Text('Tên Mặt Hàng',
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
                        _newName = value;
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
                    child: Text('Đơn Vị',
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
                        _newDonVi = value;
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
                    child: Text('Giá',
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
                        _newGia = value;
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
                    supabaseManager.addDataHH(int.parse(_newMaMH), _newName,
                        int.parse(_newGia), _newDonVi);
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
