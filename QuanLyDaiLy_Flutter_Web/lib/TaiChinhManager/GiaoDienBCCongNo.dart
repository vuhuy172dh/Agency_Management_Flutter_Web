import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/TaiChinhManager/bar_chart_component2.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class BaoCaoCongNo extends StatefulWidget {
  const BaoCaoCongNo({Key? key}) : super(key: key);

  @override
  _BaoCaoCongNoState createState() => _BaoCaoCongNoState();
}

class _BaoCaoCongNoState extends State<BaoCaoCongNo> {
  final formKey = GlobalKey<FormState>();
  final yearKey = GlobalKey<FormFieldState>();
  final monthKey = GlobalKey<FormFieldState>();
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  List<int> selectedData = [];
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController yearValue = TextEditingController();
  final monthList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  bool checkHome = true;

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
                    width: 430,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "BÁO CÁO CÔNG NỢ ĐẠI LÝ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // KHUNG TÌM KIẾM THEO THÁNG
                          Container(
                            width: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: TextFormField(
                                      key: monthKey,
                                      cursorColor: Colors.blueGrey[800],
                                      validator: (value) {
                                        if (int.tryParse(value!) == null) {
                                          return 'nhập tháng';
                                        } else {
                                          if (int.parse(value) < 1 ||
                                              int.parse(value) > 12) {
                                            return '1 to 12';
                                          }
                                        }
                                        return null;
                                      },
                                      controller: _monthController,
                                      decoration: InputDecoration(
                                          hintText: 'month',
                                          hintStyle: TextStyle(
                                              color: Colors.blueGrey[300]),
                                          border: InputBorder.none,
                                          suffixIcon: PopupMenuButton<String>(
                                            color: Colors.blueGrey[100],
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.blueGrey,
                                            ),
                                            onSelected: (value) {
                                              _monthController.text = value;
                                            },
                                            itemBuilder:
                                                (BuildContext context) {
                                              return monthList
                                                  .map<PopupMenuItem<String>>(
                                                      (e) {
                                                return PopupMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .blueGrey[800]),
                                                  ),
                                                );
                                              }).toList();
                                            },
                                          )),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: TextFormField(
                                      key: yearKey,
                                      cursorColor: Colors.blueGrey[800],
                                      style: TextStyle(
                                          color: Colors.blueGrey[800]),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'year',
                                          hintStyle: TextStyle(
                                              color: Colors.blueGrey[300])),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'nhập năm';
                                        }
                                        if (int.tryParse(value) == null) {
                                          return 'sai dạng';
                                        } else {
                                          if (int.parse(value) < 2001 ||
                                              int.parse(value) > 2030) {
                                            return '2001 đến 2030';
                                          }
                                        }
                                        return null;
                                      },
                                      controller: yearValue,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blueGrey[800]),
                                    onPressed: () {
                                      final isValid =
                                          yearKey.currentState!.validate();
                                      final isValid1 =
                                          monthKey.currentState!.validate();
                                      if (isValid && isValid1) {
                                        setState(() {
                                          checkHome = false;
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Search',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                const SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blueGrey[800]),
                                    onPressed: () {
                                      setState(() {
                                        checkHome = true;
                                        _monthController.clear();
                                        yearValue.clear();
                                      });
                                    },
                                    child: Text(
                                      'Home',
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
                          )
                        ])),
              ],
            ),
          ),
          Expanded(
            child: checkHome == true
                ? BarChartComponent2()
                : Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[200],
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: ScrollableWidget(
                        child: buildDataTable(int.parse(_monthController.text),
                            int.parse(yearValue.text))),
                  ),
          )
        ],
      ),
    );
  }

  Widget buildDataTable(int thang, int nam) {
    final columns = ['MÃ ĐẠI LÝ', 'TÊN ĐẠI LÝ', 'NỢ ĐẦU', 'NỢ CUỐI'];

    return FutureBuilder(
      future: supabaseManager.readDataBaoCaoCongNo(thang, nam),
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
          temp['_madaily'],
          temp['_tendaily'],
          temp['_nodau'],
          temp['_nocuoi']
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
