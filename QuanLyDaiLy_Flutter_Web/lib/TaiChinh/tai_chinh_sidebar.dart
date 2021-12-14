import 'package:do_an/TaiChinh/bao_cao_cong_no.dart';
import 'package:do_an/TaiChinh/bao_cao_thang.dart';
import 'package:do_an/TaiChinh/hoa_don_list.dart';
import 'package:do_an/Widget/navigate_bar.dart';
import 'package:flutter/material.dart';

class TaiChinhSideBar extends StatefulWidget {
  const TaiChinhSideBar({Key? key}) : super(key: key);

  @override
  _TaiChinhSideBarState createState() => _TaiChinhSideBarState();
}

List<bool> selected = [true, false, false];
int index = 0;

Widget SwitchPage(int _index) {
  if (_index == 0) {
    return HoaDonList();
  } else if (_index == 1) {
    return BaoCaoThang();
  } else {
    return BaoCaoCongNo();
  }
}

class _TaiChinhSideBarState extends State<TaiChinhSideBar> {
  List<String> TaiChinh = [
    'Danh sách phiếu thu tiền',
    'Báo cáo doanh số',
    'Báo cáo công nợ',
  ];

  void select(int n) {
    for (int i = 0; i < 3; i++) {
      if (i == n) {
        selected[i] = true;
      } else {
        selected[i] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            height: MediaQuery.of(context).size.height,
            width: 212.0,
            decoration: BoxDecoration(
              color: Colors.blueGrey[800],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Divider(
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                  color: Colors.white,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15),
                  child: Text('TÀI CHÍNH',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                ),
                const Divider(
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: TaiChinh.map((e) {
                    return NavBarItem(
                      title: e,
                      onTap: () {
                        setState(() {
                          index = TaiChinh.indexOf(e);
                          select(index);
                        });
                      },
                      selected: selected[TaiChinh.indexOf(e)],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(child: SwitchPage(index))
        ],
      ),
    );
  }
}
