import 'package:do_an/DaiLyManager/them_dai_ly.dart';
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
  TextEditingController searchMa = TextEditingController();
  TextEditingController searchQuan = TextEditingController();
  TextEditingController searchLoai = TextEditingController();
  TextEditingController newMaDL = TextEditingController();
  TextEditingController newName = TextEditingController();
  TextEditingController newPhone = TextEditingController();
  TextEditingController newLoca = TextEditingController();
  TextEditingController newType = TextEditingController();
  TextEditingController newDate = TextEditingController();
  TextEditingController newEmail = TextEditingController();
  TextEditingController newTienno = TextEditingController();
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
                        "DANH SÁCH CÁC ĐẠI LÝ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // khung tìm kiếm theo mã đại lý
                      Row(
                        children: [
                          TimKiem(
                            formKey: formKeySearch,
                            searchMa: searchMa,
                            searchTen: searchQuan,
                            searchLoai: searchLoai,
                            hindText1: 'Nhập mã đại lý',
                            hindText2: 'Nhập quận',
                            hindText3: 'Nhập loại đại lý',
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
                                searchMa.clear();
                                searchLoai.clear();
                                searchQuan.clear();
                                setState(() {});
                              },
                              child: Text('Home')),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(child: Container()),
                // Tạo nút thêm (thêm đại lý)
                GestureDetector(
                  key: Key('ThemDL'),
                  onTap: () {
                    newDate.text =
                        '${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}';
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          key: Key('themdl'),
                          scrollable: true,
                          title: Text(
                            'THÊM ĐẠI LÝ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]),
                          ),
                          content: ThemDaiLy(
                            formkey: formKey,
                            Checksua: true,
                            maDL: newMaDL,
                            tenDL: newName,
                            loaiDL: newType,
                            quan: newLoca,
                            email: newEmail,
                            sodtDL: newPhone,
                            tienno: newTienno,
                            ngaytiepnhan: newDate,
                            dateSub: dateSub,
                          ),
                          actions: [
                            TextButton(
                              key: Key('ThemSubmit'),
                              onPressed: () async {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  var addData = await supabaseManager.addData(
                                      int.parse(newMaDL.text),
                                      newName.text,
                                      int.parse(newType.text),
                                      int.parse(newPhone.text),
                                      newDate.text,
                                      newEmail.text,
                                      newLoca.text);
                                  if (addData != null) {
                                    _showTopFlash(
                                        Colors.white,
                                        TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        'Không thể thêm đại lý');
                                  } else {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'Thêm đại lý thành công!!!');
                                  }
                                  setState(() {
                                    newMaDL.clear();
                                    newName.clear();
                                    newLoca.clear();
                                    newLoca.clear();
                                    newPhone.clear();
                                    newType.clear();
                                    newEmail.clear();
                                    newDate.clear();
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
                                  newMaDL.text = '';
                                  newName.text = '';
                                  newType.text = '';
                                  newPhone.text = '';
                                  newLoca.text = '';
                                  newEmail.text = '';
                                  newDate.text = '';
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
                      'THÊM',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),

                // Tạo nút xóa (xóa đại lý)
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
                                key: Key('xoaDLBut'),
                                onPressed: () async {
                                  var data;
                                  while (selectedData.isNotEmpty) {
                                    data =
                                        await supabaseManager.deleteDataDaiLy(
                                            selectedData.removeLast());
                                    if (data != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'Xóa đại lý không thành công');
                                      break;
                                    }
                                  }
                                  if (data == null) {
                                    _showTopFlash(
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        'Xóa đại lý thành công!!!');
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
                      newMaDL.text = selectedRow[0][0].toString();
                      newName.text = selectedRow[0][1].toString();
                      newType.text = selectedRow[0][2].toString();
                      newPhone.text = selectedRow[0][3].toString();
                      newEmail.text = selectedRow[0][4].toString();
                      newLoca.text = selectedRow[0][5].toString();
                      newDate.text = selectedRow[0][6].toString();
                      newTienno.text = selectedRow[0][7].toString();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text(
                              'SỬA ĐẠI LÝ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800]),
                            ),
                            content: ThemDaiLy(
                              Checksua: false,
                              formkey: formKey,
                              maDL: newMaDL,
                              tenDL: newName,
                              loaiDL: newType,
                              email: newEmail,
                              sodtDL: newPhone,
                              ngaytiepnhan: newDate,
                              quan: newLoca,
                              tienno: newTienno,
                              dateSub: dateSub,
                            ),
                            actions: [
                              TextButton(
                                key: Key('suaSubmit'),
                                onPressed: () async {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    var updateData =
                                        await supabaseManager.updateDaiLyData(
                                            int.parse(newMaDL.text),
                                            newName.text,
                                            int.parse(newType.text),
                                            int.parse(newPhone.text),
                                            newDate.text,
                                            newEmail.text,
                                            newLoca.text);
                                    if (updateData != null) {
                                      _showTopFlash(
                                          Colors.white,
                                          TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                          'Sửa đại lý không thành công');
                                    } else {
                                      _showTopFlash(
                                          Colors.green,
                                          TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          'Sửa đại lý thành công!!!');
                                    }
                                    setState(() {
                                      newMaDL.clear();
                                      newName.clear();
                                      newType.clear();
                                      newLoca.clear();
                                      newEmail.clear();
                                      newPhone.clear();
                                      newDate.clear();
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
                                      newMaDL.clear();
                                      newName.clear();
                                      newType.clear();
                                      newLoca.clear();
                                      newEmail.clear();
                                      newPhone.clear();
                                      newDate.clear();
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
                            'TỔNG QUÁT',
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
      'MÃ ĐẠI LÝ',
      'TÊN ĐẠI LÝ',
      'LOẠI ĐẠI LÝ',
      'SỐ ĐIỆN THOẠI',
      'EMAIL',
      'QUẬN',
      'NGÀY TIẾP NHẬN',
      'TIỀN NỢ'
    ];
    return FutureBuilder(
      future: supabaseManager.readDataDaiLy(
          searchMa.text, searchQuan.text, searchLoai.text),
      // future: supabaseManager.readData('DAILY'),
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
              dividerThickness: 2,
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
          temp['madaily'],
          temp['tendaily'],
          temp['loaidaily'],
          temp['sodienthoai'],
          temp['email'],
          temp['quan'],
          temp['ngaytiepnhan'],
          temp['tienno']
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
                'Tổng số đại lý',
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
}
