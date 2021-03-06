import 'package:do_an/DaiLyManager/GiaoDienThemDL.dart';
import 'package:do_an/Models/DaiLyClass.dart';
import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/card_information.dart';
import 'package:do_an/Widget/tim_kiem.dart';
import 'package:do_an/Widget/widget.scrollable.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class TableDaiLy extends StatefulWidget {
  const TableDaiLy({Key? key}) : super(key: key);

  @override
  _TableDaiLyState createState() => _TableDaiLyState();
}

class _TableDaiLyState extends State<TableDaiLy> {
  final formKeySearch = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  List<int> selectedData = [];
  List<dynamic> selectedRow = [];
  bool sort = false;
  TextEditingController _searchMa = TextEditingController();
  TextEditingController _searchQuan = TextEditingController();
  TextEditingController _searchLoai = TextEditingController();
  TextEditingController _newMaDL = TextEditingController();
  TextEditingController _newName = TextEditingController();
  TextEditingController _newPhone = TextEditingController();
  TextEditingController _newLoca = TextEditingController();
  TextEditingController _newType = TextEditingController();
  TextEditingController _newDate = TextEditingController();
  TextEditingController _newEmail = TextEditingController();
  TextEditingController _newTienno = TextEditingController();
  final ValueNotifier<DateTime?> dateSub = ValueNotifier(null);

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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DANH S??CH C??C ?????I L??",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // khung t??m ki???m theo m?? ?????i l??
                      Row(
                        children: [
                          TimKiem(
                            formKey: formKeySearch,
                            searchMa: _searchMa,
                            searchTen: _searchQuan,
                            searchLoai: _searchLoai,
                            hindText1: 'Nh???p m?? ?????i l??',
                            hindText2: 'Nh???p qu???n',
                            hindText3: 'Nh???p lo???i ?????i l??',
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey[800]),
                              onPressed: () {
                                // sort = !sort;
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
                                _searchLoai.clear();
                                _searchQuan.clear();
                                setState(() {});
                              },
                              child: Text('Home')),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(child: Container()),
                // T???o n??t th??m (th??m ?????i l??)
                GestureDetector(
                  key: Key('ThemDL'),
                  onTap: () {
                    _newDate.text =
                        '${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}';
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          key: Key('themdl'),
                          scrollable: true,
                          title: Text(
                            'TH??M ?????I L??',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          content: GiaoDienThemDaiLy(
                            formkey: formKey,
                            checksua: true,
                            maDL: _newMaDL,
                            tenDL: _newName,
                            loaiDL: _newType,
                            quan: _newLoca,
                            email: _newEmail,
                            sodtDL: _newPhone,
                            tienno: _newTienno,
                            ngaytiepnhan: _newDate,
                            dateSub: dateSub,
                          ),
                          actions: [
                            TextButton(
                              key: Key('ThemSubmit'),
                              onPressed: () async {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  var addData = await DaiLy().addDaiLy(
                                      int.parse(_newMaDL.text),
                                      _newName.text,
                                      int.parse(_newType.text),
                                      int.parse(_newPhone.text),
                                      _newDate.text,
                                      _newEmail.text,
                                      _newLoca.text);
                                  if (addData != null) {
                                    _showTopFlash(
                                        Colors.white,
                                        TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        'Kh??ng th??? th??m ?????i l??');
                                  } else {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'Th??m ?????i l?? th??nh c??ng!!!');
                                  }
                                  setState(() {
                                    _newMaDL.clear();
                                    _newName.clear();
                                    _newLoca.clear();
                                    _newLoca.clear();
                                    _newPhone.clear();
                                    _newType.clear();
                                    _newEmail.clear();
                                    _newDate.clear();
                                    dateSub.value = null;
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
                                key: Key('ThemCancel'),
                                onPressed: () {
                                  _newMaDL.text = '';
                                  _newName.text = '';
                                  _newType.text = '';
                                  _newPhone.text = '';
                                  _newLoca.text = '';
                                  _newEmail.text = '';
                                  _newDate.text = '';
                                  dateSub.value = null;
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
                      'TH??M',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),

                // T???o n??t x??a (x??a ?????i l??)
                GestureDetector(
                  key: Key('xoaDL'),
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
                                  Text('B???n v???n ch??a ch???n ?????i t?????ng ????? x??a'),
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
                            title: Text('B???n ch???c ch???n mu???n x??a?'),
                            actions: [
                              TextButton(
                                key: Key('xoaDLBut'),
                                onPressed: () async {
                                  var data;
                                  while (selectedData.isNotEmpty) {
                                    data = await DaiLy()
                                        .deleteDaiLy(selectedData.removeLast());
                                    if (data != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'X??a ?????i l?? kh??ng th??nh c??ng');
                                      break;
                                    }
                                  }
                                  if (data == null) {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'X??a ?????i l?? th??nh c??ng!!!');
                                  }
                                  setState(() {
                                    selectedRow.clear();
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
                    height: 50,
                    width: 75,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: selectedData.isEmpty
                            ? Colors.blueGrey[400]
                            : Colors.blueGrey[800],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'X??A',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: selectedData.isEmpty
                              ? Colors.white54
                              : Colors.white),
                    ),
                  ),
                ),

                // T???o n??t s???a (s???a ?????i l??)
                GestureDetector(
                  key: Key('suaDL'),
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
                              content: Text('B???n ch??a ch???n ?????i t?????ng ????? s???a'),
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
                              content: Text('B???n ch??? ???????c ch???n M???T ?????i t?????ng'),
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
                      _newMaDL.text = selectedRow[0][0].toString();
                      _newName.text = selectedRow[0][1].toString();
                      _newType.text = selectedRow[0][2].toString();
                      _newPhone.text = selectedRow[0][3].toString();
                      _newEmail.text = selectedRow[0][4].toString();
                      _newLoca.text = selectedRow[0][5].toString();
                      _newDate.text = selectedRow[0][6].toString();
                      _newTienno.text = selectedRow[0][7].toString();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text(
                              'S???A ?????I L??',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800]),
                            ),
                            content: GiaoDienThemDaiLy(
                              checksua: false,
                              formkey: formKey,
                              maDL: _newMaDL,
                              tenDL: _newName,
                              loaiDL: _newType,
                              email: _newEmail,
                              sodtDL: _newPhone,
                              ngaytiepnhan: _newDate,
                              quan: _newLoca,
                              tienno: _newTienno,
                              dateSub: dateSub,
                            ),
                            actions: [
                              TextButton(
                                key: Key('suaSubmit'),
                                onPressed: () async {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    var updateData = await DaiLy().updateDaiLy(
                                        int.parse(_newMaDL.text),
                                        _newName.text,
                                        int.parse(_newType.text),
                                        int.parse(_newPhone.text),
                                        _newDate.text,
                                        _newEmail.text,
                                        _newLoca.text);
                                    if (updateData != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'S???a ?????i l?? kh??ng th??nh c??ng');
                                    } else {
                                      _showTopFlash(
                                          Colors.green,
                                          TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          'S???a ?????i l?? th??nh c??ng!!!');
                                    }
                                    setState(() {
                                      _newMaDL.clear();
                                      _newName.clear();
                                      _newType.clear();
                                      _newLoca.clear();
                                      _newEmail.clear();
                                      _newPhone.clear();
                                      _newDate.clear();
                                      dateSub.value = null;
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
                                      _newName.clear();
                                      _newType.clear();
                                      _newLoca.clear();
                                      _newEmail.clear();
                                      _newPhone.clear();
                                      _newDate.clear();
                                      dateSub.value = null;
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
                      'S???A',
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
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 3 / 4,
                          margin: EdgeInsets.only(left: 2, top: 2, bottom: 2),
                          padding: EdgeInsets.all(10),
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    color: Colors.blueGrey.shade400)
                              ]),
                          child: ScrollableWidget(child: buildDataTable())),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'T???NG QU??T',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.blueGrey[600]),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          soluongdaily(),
                          const SizedBox(
                            height: 10,
                          ),
                          soluongloaidl(),
                          const SizedBox(
                            height: 10,
                          ),
                          soluongquan(),
                        ],
                      )),
                      const SizedBox(
                        width: 5,
                      )
                    ],
                  )))
        ],
      ),
    );
  }

  Widget buildDataTable() {
    final columns = [
      'M?? ?????I L??',
      'T??N ?????I L??',
      'LO???I ?????I L??',
      'S??? ??I???N THO???I',
      'EMAIL',
      'QU???N',
      'NG??Y TI???P NH???N',
      'TI???N N???'
    ];
    return FutureBuilder(
      future:
          DaiLy().readDaiLy(_searchMa.text, _searchQuan.text, _searchLoai.text),
      builder: (context, AsyncSnapshot<List<DaiLy>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return Builder(
          builder: (context) {
            return DataTable(
              dividerThickness: 2,
              columns: getColumns(columns),
              rows: getRows(snapshot.data as List<DaiLy>),
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

  List<DataRow> getRows(List<DaiLy> users) => users.map((DaiLy user) {
        // final temp = (user as Map<String, dynamic>);
        final cells = [
          user.madaily,
          user.tendaily,
          user.loaidaily,
          user.sodienthoai,
          user.email,
          user.quan,
          user.ngaytiepnhan,
          user.tienno
        ];
        return DataRow(
          cells: getCells(cells),
          selected: selectedData.contains(cells[0]),
          onSelectChanged: (isSelected) => setState(() {
            final isAdding = isSelected != null && isSelected;
            isAdding
                ? selectedData.add(cells[0] as int)
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

  Widget soluongdaily() {
    int sldl;
    return FutureBuilder(
      future: supabaseManager.readDataSoluongDL(),
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
        sldl = datasets['Supabase Query'];
        return Builder(
          builder: (context) {
            return cardInfor(
                'T???ng s??? ?????i l??',
                sldl,
                Colors.lightGreen.withOpacity(0.8),
                Colors.white,
                Icons.location_on_outlined);
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
                'T???ng s??? lo???i ?????i l??',
                slloaidl,
                Colors.brown.withOpacity(0.8),
                Colors.white,
                Icons.account_tree_outlined);
          },
        );
      },
    );
  }

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
                'T???ng s??? qu???n c?? ?????i l??',
                slquan,
                Colors.red.withOpacity(0.8),
                Colors.white,
                Icons.location_city_outlined);
          },
        );
      },
    );
  }
}
