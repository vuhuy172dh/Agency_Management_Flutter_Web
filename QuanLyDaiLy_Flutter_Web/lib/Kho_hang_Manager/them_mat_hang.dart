import 'package:do_an/Widget/build_datatime_picker.dart';
import 'package:flutter/material.dart';

class ThemMatHang extends StatefulWidget {
  final formKey;
  final bool isCheck;
  final TextEditingController newMaMH;
  final TextEditingController newTenMH;
  final TextEditingController newDonVi;
  final TextEditingController newGiaNhap;
  final TextEditingController newGiaXuat;
  final TextEditingController newSoluong;
  final TextEditingController newNgaySanXuat;
  final TextEditingController newHanSuDung;
  final ValueNotifier<DateTime?> nsxSub;
  final ValueNotifier<DateTime?> hsdSub;
  const ThemMatHang(
      {Key? key,
      required this.isCheck,
      required this.formKey,
      required this.newMaMH,
      required this.newTenMH,
      required this.newDonVi,
      required this.newGiaNhap,
      required this.newGiaXuat,
      required this.newSoluong,
      required this.newNgaySanXuat,
      required this.newHanSuDung,
      required this.nsxSub,
      required this.hsdSub})
      : super(key: key);

  @override
  _ThemMatHangState createState() => _ThemMatHangState();
}

class _ThemMatHangState extends State<ThemMatHang> {
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
          key: widget.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thông tin hàng
              Container(
                child: Text(
                  'THÔNG TIN MẶT HÀNG',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(
                // thickness: 1,
                color: Colors.black87,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // tạo hàng thêm MÃ MẶT HÀNG
                      Container(
                        margin: EdgeInsets.all(5),
                        height: 60,
                        width: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.blueGrey),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 3),
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              width: 150,
                              child: Text('MÃ MẶT HÀNG',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.symmetric(vertical: 2),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: TextFormField(
                                key: Key('mamathang'),
                                autofocus: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Chưa nhập MÃ MẶT HÀNG";
                                  } else {
                                    return null;
                                  }
                                },
                                initialValue: widget.newMaMH.text,
                                onChanged: (value) {
                                  widget.newMaMH.text = value;
                                },
                                cursorColor: Colors.blueGrey[800],
                                style: TextStyle(color: Colors.blueGrey[800]),
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            )),
                          ],
                        ),
                      ),
                      // Tạo hàng thêm TÊN MẶT HÀNG
                      Container(
                        margin: EdgeInsets.all(5),
                        height: 60,
                        width: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.blueGrey),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 3),
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              width: 150,
                              child: Text('TÊN MẶT HÀNG',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.symmetric(vertical: 2),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: TextFormField(
                                key: Key('tenmathang'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Chưa nhập TÊN MẶT HÀNG";
                                  } else {
                                    return null;
                                  }
                                },
                                initialValue: widget.newTenMH.text,
                                onChanged: (value) {
                                  widget.newTenMH.text = value;
                                },
                                cursorColor: Colors.blueGrey[800],
                                style: TextStyle(color: Colors.blueGrey[800]),
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Tạo hàng nhập ĐƠN VỊ
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 60,
                    width: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.blueGrey),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 3),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          width: 150,
                          child: Text('ĐƠN VỊ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
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
                          child: TextFormField(
                            key: Key('donvi'),
                            initialValue: widget.newDonVi.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Chưa nhập ĐƠN VỊ";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              widget.newDonVi.text = value;
                            },
                            cursorColor: Colors.blueGrey[800],
                            style: TextStyle(color: Colors.blueGrey[800]),
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // Thông tin giá
              Container(
                child: Text('THÔNG TIN GIÁ MẶT HÀNG',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold)),
              ),
              const Divider(
                // thickness: 1,
                color: Colors.black87,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tạo hàng nhập GIÁ NHẬP
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 60,
                          width: 400,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Colors.blueGrey),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                width: 150,
                                child: Text('GIÁ NHẬP',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
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
                                child: TextFormField(
                                  key: Key('gianhap'),
                                  initialValue: widget.newGiaNhap.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Chưa nhập Giá Nhập";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    widget.newGiaNhap.text = value;
                                  },
                                  cursorColor: Colors.blueGrey[800],
                                  style: TextStyle(color: Colors.blueGrey[800]),
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              )),
                            ],
                          ),
                        ),
                        // Tạo hàng thêm GIÁ XUẤT
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 60,
                          width: 400,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Colors.blueGrey),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                width: 150,
                                child: Text('GIÁ XUẤT',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
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
                                child: TextFormField(
                                  key: Key('giaxuat'),
                                  initialValue: widget.newGiaXuat.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Chưa nhập Giá Xuất";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    widget.newGiaXuat.text = value;
                                  },
                                  cursorColor: Colors.blueGrey[800],
                                  style: TextStyle(color: Colors.blueGrey[800]),
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Tạo hàng số lượng (hàng này luôn luôn hiện thị, không dùng để nhập, vì nó tự cập nhật)
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 60,
                    width: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.blueGrey),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 3),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          width: 150,
                          child: Text('SỐ LƯỢNG',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.symmetric(vertical: 2),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: TextFormField(
                            enabled: false,
                            initialValue: widget.isCheck == true
                                ? widget.newSoluong.text
                                : '0',
                            cursorColor: Colors.blueGrey[800],
                            style: TextStyle(color: Colors.blueGrey[800]),
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // Thông tin bảo quản
              Container(
                child: Text('THÔNG TIN THỜI HẠN SỬ DỤNG',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold)),
              ),
              const Divider(
                // thickness: 1,
                color: Colors.black87,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // tạo hàng thêm ngày sản xuất
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 400,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Colors.blueGrey),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 3),
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  width: 150,
                                  child: Text('NGÀY SẢN XUẤT',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
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
                                  child: ValueListenableBuilder<DateTime?>(
                                      valueListenable: widget.nsxSub,
                                      builder: (context, dateVal, child) {
                                        return InkWell(
                                            onTap: () async {
                                              DateTime? date =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2050),
                                                      currentDate:
                                                          DateTime.now(),
                                                      initialEntryMode:
                                                          DatePickerEntryMode
                                                              .calendar,
                                                      initialDatePickerMode:
                                                          DatePickerMode.day,
                                                      builder:
                                                          (context, child) {
                                                        return Theme(
                                                          data: Theme.of(context).copyWith(
                                                              colorScheme: const ColorScheme
                                                                      .light(
                                                                  primary: Colors
                                                                      .blueGrey,
                                                                  onSurface: Colors
                                                                      .blueGrey)),
                                                          child: child!,
                                                        );
                                                      });
                                              widget.nsxSub.value = date;
                                              widget.newNgaySanXuat.text =
                                                  '${date!.month}-${date.day}-${date.year}';
                                            },
                                            child: buildDateTimePicker(
                                                widget.newNgaySanXuat.text,
                                                widget.newNgaySanXuat,
                                                'Bạn chưa nhập Ngày Sản Xuất',
                                                Colors.blueGrey,
                                                isCheck: false));
                                      }),
                                )),
                              ],
                            ),
                          ),
                          // tạo hàng thêm hạn sử dụng
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 60,
                            width: 400,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Colors.blueGrey),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 3),
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  width: 150,
                                  child: Text('HẠN SỬ DỤNG',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
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
                                  child: ValueListenableBuilder<DateTime?>(
                                      valueListenable: widget.hsdSub,
                                      builder: (context, dateVal, child) {
                                        return InkWell(
                                            onTap: () async {
                                              DateTime? date =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2050),
                                                      currentDate:
                                                          DateTime.now(),
                                                      initialEntryMode:
                                                          DatePickerEntryMode
                                                              .calendar,
                                                      initialDatePickerMode:
                                                          DatePickerMode.day,
                                                      builder:
                                                          (context, child) {
                                                        return Theme(
                                                          data: Theme.of(context).copyWith(
                                                              colorScheme: const ColorScheme
                                                                      .light(
                                                                  primary: Colors
                                                                      .blueGrey,
                                                                  onSurface: Colors
                                                                      .blueGrey)),
                                                          child: child!,
                                                        );
                                                      });
                                              widget.hsdSub.value = date;
                                              widget.newHanSuDung.text =
                                                  '${date!.month}-${date.day}-${date.year}';
                                            },
                                            child: buildDateTimePicker(
                                                widget.newHanSuDung.text,
                                                widget.newHanSuDung,
                                                'Bạn chưa nhập Hạn Sử Dụng',
                                                Colors.blueGrey,
                                                isCheck: false));
                                      }),
                                )),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
