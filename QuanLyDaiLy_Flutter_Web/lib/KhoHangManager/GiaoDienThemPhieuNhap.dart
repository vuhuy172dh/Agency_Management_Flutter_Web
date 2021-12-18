import 'package:do_an/Widget/build_datatime_picker.dart';
import 'package:flutter/material.dart';

class GiaoDienThemPhieuNhapKho extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final bool isCheck;
  final TextEditingController newMaPhieuNhap;
  final TextEditingController newThanhTien;
  final TextEditingController newNgayNhap;
  final ValueNotifier<DateTime?> ngaynhapSub;
  const GiaoDienThemPhieuNhapKho(
      {Key? key,
      required this.formkey,
      required this.isCheck,
      required this.newMaPhieuNhap,
      required this.newThanhTien,
      required this.newNgayNhap,
      required this.ngaynhapSub})
      : super(key: key);

  @override
  _GiaoDienThemPhieuNhapKhoState createState() => _GiaoDienThemPhieuNhapKhoState();
}

class _GiaoDienThemPhieuNhapKhoState extends State<GiaoDienThemPhieuNhapKho> {
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
                      child: Text('MÃ PHIẾU NHẬP',
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
                        initialValue: widget.newMaPhieuNhap.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Chưa nhập MÃ PHIẾU";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          widget.newMaPhieuNhap.text = value;
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
                      child: Text('THÀNH TIỀN',
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
                      child: Text('NGÀY NHẬP KHO',
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
                      child: ValueListenableBuilder<DateTime?>(
                          valueListenable: widget.ngaynhapSub,
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
                                  widget.ngaynhapSub.value = date;
                                  widget.newNgayNhap.text =
                                      '${date!.month}-${date.day}-${date.year}';
                                },
                                child: buildDateTimePicker(
                                  dateVal != null
                                      ? '${dateVal.day}-${dateVal.month}-${dateVal.year}'
                                      : '',
                                  widget.newNgayNhap,
                                  'Bạn chưa nhập Ngày Nhập Kho',
                                  Colors.blueGrey,
                                ));
                          }),
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
}
