import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/card_information.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class QuyDinh extends StatefulWidget {
  const QuyDinh({Key? key}) : super(key: key);

  @override
  _QuyDinhState createState() => _QuyDinhState();
}

class _QuyDinhState extends State<QuyDinh> {
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  List<String> selectedData = [];
  List<dynamic> selectedRow = [];
  List<int> selectedLoaiData = [];
  List<dynamic> selectedLoaiRow = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Quy chế tổ chức
          Container(
            margin: EdgeInsets.only(left: 5, right: 2.5, top: 5, bottom: 5),
            width: MediaQuery.of(context).size.width / 2 - 7.5,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                // Phần hiện danh sách
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey.shade400,
                            spreadRadius: 2,
                            blurRadius: 2)
                      ]),
                  child: Column(
                    children: [
                      // Tiêu để QUY CHẾ TỔ CHỨC
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'QUY CHẾ TỔ CHỨC',
                              style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () {},
                                child: Text('thêm')),
                            const SizedBox(
                              width: 3,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () {},
                                child: Text('sửa')),
                            const SizedBox(
                              width: 3,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () {},
                                child: Text('xóa')),
                          ],
                        ),
                      ),
                      // danh sách
                      Container(
                        height: MediaQuery.of(context).size.height - 170,
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(5),
                        child: ScrollableWidget(child: buildDataTable()),
                      ),
                    ],
                  ),
                ),
                // Thông tin
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 10, left: 5),
                          child: soluongquan()),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'QUY CHẾ TỔ CHỨC',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25),
                              ),
                            ),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 15),
                                    children: [
                                  TextSpan(
                                      text: 'Quy chế tổ chức',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  TextSpan(text: ' quy định số lượng '),
                                  TextSpan(
                                      text: 'quận',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  TextSpan(text: ' và số lượng '),
                                  TextSpan(
                                      text: 'đại lý tối đa',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  TextSpan(text: ' của từng quận cụ thể.')
                                ]))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // Quy định tiền nợ
          Container(
            margin: EdgeInsets.only(left: 2.5, right: 5, top: 5, bottom: 5),
            width: MediaQuery.of(context).size.width / 2 - 7.5,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                // Phần hiện danh sách
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey.shade400,
                            spreadRadius: 2,
                            blurRadius: 1)
                      ]),
                  child: Column(
                    children: [
                      // Tiêu để QUY Định tiền nợ
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'QUY ĐỊNH TIỀN NỢ',
                              style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () {},
                                child: Text('thêm')),
                            const SizedBox(
                              width: 3,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () {},
                                child: Text('sửa')),
                            const SizedBox(
                              width: 3,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () {},
                                child: Text('xóa')),
                          ],
                        ),
                      ),
                      // danh sách
                      Container(
                        height: MediaQuery.of(context).size.height - 170,
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        padding: EdgeInsets.all(5),
                        child: ScrollableWidget(child: buildDataLoaiTable()),
                      ),
                    ],
                  ),
                ),
                // Thông tin
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 10, left: 5),
                          child: soluongloaidl()),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'QUY ĐỊNH TIỀN NỢ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25),
                              ),
                            ),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 15),
                                    children: [
                                  TextSpan(
                                      text: 'Quy định tiền nợ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  TextSpan(text: ' quy định số lượng '),
                                  TextSpan(
                                      text: 'loại đại lý',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  TextSpan(text: ' và số '),
                                  TextSpan(
                                      text: 'nợ tối đa',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  TextSpan(
                                      text: ' của từng loại đại lý cụ thể.')
                                ]))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDataTable() {
    final columns = ['QUẬN', 'SỐ LƯỢNG ĐẠI LÝ TỐI ĐA'];

    return FutureBuilder(
      future: supabaseManager.readDataQuyCheToChuc(),
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

  Widget buildDataLoaiTable() {
    final columns = ['LOẠI ĐẠI LÝ', 'SỐ TIỀN NỢ TỐI ĐA'];

    return FutureBuilder(
      future: supabaseManager.readDataQuyDinhTienNo(),
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
              rows: getLoaiRows((datasets['Supabase Query'] as List<dynamic>)),
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
        final cells = [temp['quan'], temp['soluongDL']];

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

  List<DataRow> getLoaiRows(List<dynamic> users) => users.map((dynamic user) {
        final temp = (user as Map<String, dynamic>);
        final cells = [temp['loaiDL'], temp['maxtienno']];

        return DataRow(
          cells: getCells(cells),
          selected: selectedLoaiData.contains(cells[0]),
          onSelectChanged: (isSelected) => setState(() {
            final isAdding = isSelected != null && isSelected;
            isAdding
                ? selectedLoaiData.add(cells[0])
                : selectedLoaiData.remove(cells[0]);

            isAdding
                ? selectedLoaiRow.add(cells)
                : selectedLoaiRow
                    .removeWhere((element) => element[0] == cells[0]);
          }),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) {
        return DataCell(Text('$data'));
      }).toList();

  Widget soluongquan() {
    int slquan;
    return FutureBuilder(
      future: supabaseManager.readDataSoluongQuan(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final doc = snapshot.data as PostgrestResponse?;
        if (doc == null) {
          return const SizedBox();
        }

        final datasets = <String, dynamic>{};
        datasets['Supabase Query'] = doc.data as int;
        slquan = datasets['Supabase Query'];
        return Builder(
          builder: (context) {
            return cardInfor(
                'Tổng số quận có đại lý',
                slquan,
                Colors.red.withOpacity(0.8),
                Colors.white,
                Icons.location_city_outlined);
          },
        );
      },
    );
  }

  Widget soluongloaidl() {
    int slloaidl;
    return FutureBuilder(
      future: supabaseManager.readDataSoluongLoaiDL(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final doc = snapshot.data as PostgrestResponse?;
        if (doc == null) {
          return const SizedBox();
        }

        final datasets = <String, dynamic>{};
        datasets['Supabase Query'] = doc.data as int;
        slloaidl = datasets['Supabase Query'];
        return Builder(
          builder: (context) {
            return cardInfor(
                'Tổng số loại đại lý',
                slloaidl,
                Colors.brown.withOpacity(0.8),
                Colors.white,
                Icons.account_tree_outlined);
          },
        );
      },
    );
  }
}
