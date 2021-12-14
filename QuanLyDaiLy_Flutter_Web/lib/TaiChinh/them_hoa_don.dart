import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/build_datatime_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class ThemHoaDon extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool isCheck;
  final TextEditingController newMaPhieu;
  final TextEditingController newMaDL;
  final TextEditingController newSoTienThu;
  final TextEditingController newNgayThu;
  final ValueNotifier<DateTime?> ngaythuSub;
  const ThemHoaDon(
      {Key? key,
      required this.formKey,
      required this.isCheck,
      required this.newMaPhieu,
      required this.newMaDL,
      required this.newSoTienThu,
      required this.newNgayThu,
      required this.ngaythuSub})
      : super(key: key);

  @override
  _ThemHoaDonState createState() => _ThemHoaDonState();
}

class _ThemHoaDonState extends State<ThemHoaDon> {
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tạo hàng để điền thông tin MÃ HÓA ĐƠN
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'MÃ PHIẾU THU',
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: widget.isCheck
                              ? Colors.blueGrey[300]
                              : Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        enabled: widget.isCheck ? false : true,
                        initialValue: widget.newMaPhieu.text,
                        style: TextStyle(color: Colors.white),
                        autofocus: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none),
                        onChanged: (value) {
                          widget.newMaPhieu.text = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bạn chưa nhập MÃ HÓA ĐƠN";
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
            // Tạo hàng để điền thông tin NGÀY THU TIỀN
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'NGÀY THU TIỀN',
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
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ValueListenableBuilder<DateTime?>(
                        valueListenable: widget.ngaythuSub,
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
                                widget.ngaythuSub.value = date;
                                widget.newNgayThu.text =
                                    '${date!.month}-${date.day}-${date.year}';
                              },
                              child: buildDateTimePicker(
                                  widget.newNgayThu.text,
                                  widget.newNgayThu,
                                  'Bạn chưa nhập NGÀY THU TIỀN',
                                  Colors.white,
                                  error_color: Colors.white));
                        }),
                  ))
                ],
              ),
            ),
            // Tạo hàng thêm MÃ ĐẠI LÝ
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
                            color: Colors.blueGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: BuildMaDLFormField()),
                  )
                ],
              ),
            ),
            // Tạo hàng thêm SỐ TIỀN THU
            Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'SỐ TIỀN THU',
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
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        initialValue: widget.newSoTienThu.text,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bạn chưa nhập SỐ TIỀN THU";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          widget.newSoTienThu.text = value;
                        },
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

  Widget BuildMaDLFormField() {
    return FutureBuilder(
      future: supabaseManager.readDataMaDL(),
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
        List<String> maDLData = [];
        for (var i in data) {
          final temp = (i as Map<String, dynamic>);
          maDLData.add(temp['madaily'].toString());
        }
        return Builder(builder: (context) {
          return TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: widget.newMaDL,
            validator: (value) {
              if (value!.isEmpty) {
                return "Bạn chưa nhập MÃ ĐẠI LÝ";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.white),
              hintText: widget.newMaDL.text,
              border: InputBorder.none,
              suffixIcon: PopupMenuButton<String>(
                color: Colors.blueGrey[200],
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                onSelected: (value) {
                  widget.newMaDL.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return maDLData.map<PopupMenuItem<String>>((e) {
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
