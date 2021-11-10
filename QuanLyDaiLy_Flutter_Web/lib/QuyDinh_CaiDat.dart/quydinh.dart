import 'package:do_an/Supabase/supabase_mange.dart';
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
                color: Colors.blueGrey[300],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                // Tiêu để QUY CHẾ TỔ CHỨC
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.blueGrey[400]),
                  child: Text(
                    'QUY CHẾ TỔ CHỨC',
                    style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[400],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Colors.blueGrey.withOpacity(0.8), width: 2.5)),
                  child: ScrollableWidget(child: buildDataTable()),
                ),
                const SizedBox(
                  height: 5,
                ),
                // Thông tin
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                            'QUY ĐỊNH SỐ LƯỢNG ĐẠI LÝ TỐI ĐA CHO MỖI QUẬN TRONG KHU VỰC THÀNH PHỐ HỒ CHÍ MINH'),
                      ),
                      Container(
                        child: Text(
                            'DANH SÁCH Ở TRÊN HIỆN THI SỐ LƯỢNG QUẬN CÓ ĐẠI LÝ CỦA CÔNG TY VÀ SỐ LƯỢNG ĐẠI LÝ TỐI ĐA CHO MỖI QUẬN'),
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
                color: Colors.blueGrey[300],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                // Tiêu để QUY CHẾ TỔ CHỨC
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.blueGrey[400]),
                  child: Text(
                    'QUY ĐỊNH TIỀN NỢ',
                    style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[400],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Colors.blueGrey.withOpacity(0.8), width: 2.5)),
                  child: ScrollableWidget(child: buildDataLoaiTable()),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      child:
                          Text('QUY ĐỊNH TIỀN NỢ TỐI ĐA CHO CÁC LOẠI ĐẠI LÝ'),
                    ),
                    Container(
                      child: Text(
                          'DANH SÁCH Ở TRÊN HIỆN THỊ CHO CÁC LOẠI ĐẠI LÝ HIỆN CÓ CỦA CÔNG TY VÀ TIỀN NỢ TỐI ĐA TƯƠNG ỨNG VỚI LOẠI ĐẠI LÝ'),
                    )
                  ],
                )),
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
}
