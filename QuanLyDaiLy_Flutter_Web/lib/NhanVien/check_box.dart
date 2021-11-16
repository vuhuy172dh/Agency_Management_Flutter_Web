import 'package:flutter/material.dart';

class PhanQuyen extends StatefulWidget {
  final TextEditingController cv;
  const PhanQuyen({Key? key, required this.cv}) : super(key: key);

  @override
  _PhanQuyenState createState() => _PhanQuyenState();
}

class _PhanQuyenState extends State<PhanQuyen> {
  final checkBoxList = [
    CheckBoxModal(title: 'QUẢN LÝ ĐẠI LÝ'),
    CheckBoxModal(title: 'QUẢN LÝ KHO HÀNG'),
    CheckBoxModal(title: 'QUẢN LÝ TÀI CHÍNH'),
    CheckBoxModal(title: 'QUẢN LÝ NHÂN VIÊN')
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: checkBoxList
              .map((item) => ListTile(
                    onTap: () => onItemClicked(item),
                    leading: Checkbox(
                      value: item.value,
                      onChanged: (value) => onItemClicked(item),
                    ),
                    title: Text(
                      item.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ))
              .toList()),
    );
  }

  onItemClicked(CheckBoxModal ckbItem) {
    setState(() {
      ckbItem.value = !ckbItem.value;
      widget.cv.text = ckbItem.title;
    });
  }
}

class CheckBoxModal {
  String title;
  bool value;

  CheckBoxModal({required this.title, this.value = false});
}
