import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/build_datatime_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class GiaoDienThemDaiLy extends StatefulWidget {
  final formkey;
  final bool checksua;
  final TextEditingController maDL;
  final TextEditingController tenDL;
  final TextEditingController loaiDL;
  final TextEditingController sodtDL;
  final TextEditingController email;
  final TextEditingController quan;
  final TextEditingController ngaytiepnhan;
  final TextEditingController tienno;
  final ValueNotifier<DateTime?> dateSub;
  const GiaoDienThemDaiLy(
      {Key? key,
      required this.formkey,
      required this.checksua,
      required this.maDL,
      required this.tenDL,
      required this.loaiDL,
      required this.sodtDL,
      required this.email,
      required this.quan,
      required this.ngaytiepnhan,
      required this.tienno,
      required this.dateSub})
      : super(key: key);

  @override
  _GiaoDienThemDaiLyState createState() => _GiaoDienThemDaiLyState();
}

class _GiaoDienThemDaiLyState extends State<GiaoDienThemDaiLy> {
  final datasets = <String, dynamic>{};
  SupabaseManager supabaseManager = SupabaseManager();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Form(
        key: widget.formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'THÔNG TIN ĐẠI LÝ',
                style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(
              thickness: 2,
            ),
            // thông tin liên quan đại lý
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // chỗ thêm mã đại lý
                    Container(
                      margin: EdgeInsets.all(5),
                      height: 80,
                      width: 400,
                      child: Row(
                        children: [
                          Container(
                            width: 130,
                            child: Text(
                              'MÃ ĐẠI LÝ',
                              style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: widget.checksua
                                      ? Colors.blueGrey
                                      : Colors.blueGrey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                key: Key('madaily'),
                                enabled: widget.checksua,
                                initialValue: widget.maDL.text,
                                style: TextStyle(color: Colors.white),
                                autofocus: true,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  widget.maDL.text = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Bạn chưa nhập MÃ ĐẠI LÝ";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Tạo hàng để điền thông tin TÊN ĐẠI LÝ
                    Container(
                      margin: EdgeInsets.all(5),
                      height: 80,
                      width: 400,
                      child: Row(
                        children: [
                          Container(
                            width: 130,
                            child: Text(
                              'TÊN ĐẠI LÝ',
                              style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                key: Key('tendaily'),
                                autofocus: widget.checksua ? false : true,
                                initialValue: widget.tenDL.text,
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Bạn chưa nhập TÊN ĐẠI LÝ";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  widget.tenDL.text = value;
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // Tạo thàng thêm LOẠI
                Container(
                  margin: EdgeInsets.all(5),
                  height: 80,
                  width: 400,
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          'LOẠI',
                          style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: BuildLoaiDLFormField()))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'THÔNG TIN LIÊN HỆ',
                style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Row(
              children: [
                Column(
                  children: [
                    // Tạo hàng thêm SỐ ĐIỆN THOẠI
                    Container(
                      margin: EdgeInsets.all(5),
                      height: 80,
                      width: 400,
                      child: Row(
                        children: [
                          Container(
                            width: 130,
                            child: Text(
                              'SỐ ĐIỆN THOẠI',
                              style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                key: Key('sodienthoai'),
                                initialValue: widget.sodtDL.text,
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Bạn chưa nhập SỐ ĐIỆN THOẠI";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  widget.sodtDL.text = value;
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // tạo hàng thêm EMAIL
                    Container(
                      margin: EdgeInsets.all(5),
                      height: 80,
                      width: 400,
                      child: Row(
                        children: [
                          Container(
                            width: 130,
                            child: Text(
                              'EMAIL',
                              style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                key: Key('email'),
                                initialValue: widget.email.text,
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Bạn chưa nhập EMAIL";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  widget.email.text = value;
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // Tạo hàng thêm QUẬN
                Container(
                  margin: EdgeInsets.all(5),
                  height: 80,
                  width: 400,
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          'QUẬN',
                          style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: BuildQuanFormField()),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'NGÀY TIẾP NHẬN',
                style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(
              thickness: 2,
            ),
            // Tạo hàng thêm ngày tiếp nhận
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'NGÀY TIẾP NHẬN',
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      key: Key('ngay'),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ValueListenableBuilder<DateTime?>(
                          valueListenable: widget.dateSub,
                          builder: (context, dateVal, child) {
                            return InkWell(
                                onTap: () async {
                                  DateTime? date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2050),
                                      currentDate: DateTime.now(),
                                      initialEntryMode:
                                          DatePickerEntryMode.calendar,
                                      initialDatePickerMode: DatePickerMode.day,
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                              colorScheme:
                                                  const ColorScheme.light(
                                                      primary: Colors.blueGrey,
                                                      onSurface:
                                                          Colors.blueGrey)),
                                          child: child!,
                                        );
                                      });
                                  widget.dateSub.value = date;
                                  widget.ngaytiepnhan.text =
                                      '${date!.month}-${date.day}-${date.year}';
                                },
                                child: buildDateTimePicker(
                                    widget.ngaytiepnhan.text,
                                    widget.ngaytiepnhan,
                                    'Bạn chưa nhập NGÀY TIẾP NHẬN',
                                    Colors.white,
                                    error_color: Colors.white));
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'SỐ TIỀN NỢ',
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        enabled: false,
                        initialValue:
                            widget.checksua == true ? '0' : widget.tienno.text,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildLoaiDLFormField() {
    return FutureBuilder(
      future: supabaseManager.readDataLoaiDL(),
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

        List<dynamic> data = datasets['Supabase Query'] as List<dynamic>;
        List<String> loaidldata = [];
        for (var i in data) {
          final temp = (i as Map<String, dynamic>);
          loaidldata.add(temp['loaiDL'].toString());
        }
        return Builder(builder: (context) {
          return TextFormField(
            key: Key('loaidaily'),
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: widget.loaiDL,
            validator: (value) {
              if (value!.isEmpty) {
                return "Bạn chưa nhập LOẠI ĐẠI LÝ";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.white),
              hintText: widget.loaiDL.text,
              border: InputBorder.none,
              suffixIcon: PopupMenuButton<String>(
                color: Colors.blueGrey[100],
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                onSelected: (value) {
                  widget.loaiDL.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return loaidldata.map<PopupMenuItem<String>>((e) {
                    return PopupMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(color: Colors.blueGrey[800]),
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          );
        });
      },
    );
  }

  Widget BuildQuanFormField() {
    return FutureBuilder(
      future: supabaseManager.readDataQuan(),
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

        List<dynamic> data = datasets['Supabase Query'] as List<dynamic>;
        List<String> loaidldata = [];
        for (var i in data) {
          final temp = (i as Map<String, dynamic>);
          loaidldata.add(temp['quan'].toString());
        }
        return Builder(builder: (context) {
          return TextFormField(
            key: Key('quan'),
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: widget.quan,
            validator: (value) {
              if (value!.isEmpty) {
                return "Bạn chưa nhập QUẬN";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.white),
              hintText: widget.quan.text,
              border: InputBorder.none,
              suffixIcon: PopupMenuButton<String>(
                color: Colors.blueGrey[100],
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                onSelected: (value) {
                  widget.quan.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return loaidldata.map<PopupMenuItem<String>>((e) {
                    return PopupMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(color: Colors.blueGrey[800]),
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          );
        });
      },
    );
  }
}
