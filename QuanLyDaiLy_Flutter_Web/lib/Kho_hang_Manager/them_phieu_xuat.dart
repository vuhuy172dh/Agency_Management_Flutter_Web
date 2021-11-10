import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/Widget/build_datatime_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class ThemPhieuXuatKho extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final bool isCheck;
  final TextEditingController newMaPhieuXuat;
  final TextEditingController newThanhTien;
  final TextEditingController newNgayXuat;
  final TextEditingController newMaDaiLy;
  final TextEditingController newSoTienNo;
  final ValueNotifier<DateTime?> ngayxuatSub;
  const ThemPhieuXuatKho(
      {Key? key,
      required this.formkey,
      required this.isCheck,
      required this.newMaPhieuXuat,
      required this.newThanhTien,
      required this.newNgayXuat,
      required this.newMaDaiLy,
      required this.newSoTienNo,
      required this.ngayxuatSub})
      : super(key: key);

  @override
  _ThemPhieuXuatKhoState createState() => _ThemPhieuXuatKhoState();
}

class _ThemPhieuXuatKhoState extends State<ThemPhieuXuatKho> {
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        alignment: Alignment.center,
        child: Form(
          key: widget.formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      child: Text('MÃ PHIẾU XUẤT',
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
                          color: widget.isCheck ? Colors.white54 : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextFormField(
                        enabled: widget.isCheck ? false : true,
                        initialValue: widget.newMaPhieuXuat.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Chưa nhập MÃ PHIẾU";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          widget.newMaPhieuXuat.text = value;
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
                      child: Text('NGÀY XUẤT KHO',
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
                      child: ValueListenableBuilder<DateTime?>(
                          valueListenable: widget.ngayxuatSub,
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
                                  widget.ngayxuatSub.value = date;
                                  widget.newNgayXuat.text =
                                      '${date!.month}-${date.day}-${date.year}';
                                },
                                child: buildDateTimePicker(
                                  dateVal != null
                                      ? '${dateVal.day}-${dateVal.month}-${dateVal.year}'
                                      : '',
                                  widget.newNgayXuat,
                                  'Bạn chưa nhập Ngày Xuất Kho',
                                  Colors.blueGrey,
                                ));
                          }),
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
                      child: Text('MÃ ĐẠI LÝ',
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: BuildMaDLFormField())),
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
                      child: Text('THÀNH TIỀN',
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
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextFormField(
                        enabled: false,
                        initialValue:
                            widget.isCheck ? widget.newThanhTien.text : '0',
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
                      child: Text('SỐ TIỀN NỢ',
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
                      child: TextFormField(
                        initialValue: widget.newSoTienNo.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Chưa nhập SỐ TIỀN NỢ";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          widget.newSoTienNo.text = value;
                        },
                        cursorColor: Colors.blueGrey[800],
                        style: TextStyle(color: Colors.blueGrey[800]),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
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
            style: TextStyle(color: Colors.blueGrey[800]),
            cursorColor: Colors.blueGrey[800],
            controller: widget.newMaDaiLy,
            validator: (value) {
              if (value!.isEmpty) {
                return "Bạn chưa nhập MÃ ĐẠI LÝ";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: widget.newMaDaiLy.text,
              border: InputBorder.none,
              suffixIcon: PopupMenuButton<String>(
                color: Colors.blueGrey[100],
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blueGrey,
                ),
                onSelected: (value) {
                  widget.newMaDaiLy.text = value;
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
