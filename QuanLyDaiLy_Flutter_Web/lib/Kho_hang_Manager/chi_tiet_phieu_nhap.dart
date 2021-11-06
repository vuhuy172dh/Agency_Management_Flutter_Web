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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: Colors.blueGrey[200]),
      child: Container(
          height: 500,
          child: ScrollableWidget(
              child: buildDataTableChitietPhieu(widget.maphieunhap))),
    );
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
          temp['_soluong'],
          temp['_gianhap']
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
}
