import 'package:do_an/Kho_hang_Manager/Hang_hoa_list.dart';
import 'package:do_an/Kho_hang_Manager/phieu_nhap_list.dart';
import 'package:do_an/Kho_hang_Manager/phieu_xuat_list.dart';
import 'package:do_an/Kho_hang_Manager/sap_het_hang.dart';
import 'package:do_an/Kho_hang_Manager/ton_kho_list.dart';
import 'package:do_an/Widget/navigate_bar.dart';
import 'package:flutter/material.dart';

class KhoHangTabView extends StatefulWidget {
  const KhoHangTabView({Key? key}) : super(key: key);

  @override
  _KhoHangTabViewState createState() => _KhoHangTabViewState();
}

List<bool> selected_1 = [true, false, false];
int index = 0;

Widget SwitchPage(int index) {
  if (index == 0) {
    return HangHoaList();
  } else if (index == 1) {
    return PhieuNhapList();
  } else {
    return PhieuXuatList();
  }
}

class _KhoHangTabViewState extends State<KhoHangTabView> {
  TextEditingController? _Search;
  List<String> HangHoa = [
    'Tất cả mặt hàng',
  ];

  List<String> Phieu = ['Phiếu nhập kho', 'Phiếu xuất kho'];

  @override
  void initState() {
    super.initState();
    _Search = TextEditingController();
  }

  void select_1(int n) {
    for (int i = 0; i < 3; i++) {
      if (i == n) {
        selected_1[i] = true;
      } else {
        selected_1[i] = false;
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
            width: 202.0,
            decoration: BoxDecoration(
              color: Colors.blueGrey[800],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.only(left: 6),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.black)],
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: TextField(
                      autofocus: true,
                      cursorColor: Colors.blueGrey,
                      controller: _Search,
                      autocorrect: true,
                      style: TextStyle(color: Colors.blueGrey[800]),
                      decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.blueGrey[500]),
                          border: InputBorder.none,
                          suffix: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.blueGrey[800],
                              size: 18,
                            ),
                            onPressed: () {
                              print('search');
                            },
                          )),
                    )),
                const Divider(
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                  color: Colors.white,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15),
                  child: Text('HÀNG HÓA',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                ),
                Column(
                  children: HangHoa.map((e) {
                    return NavBarItem(
                        title: e,
                        onTap: () {
                          setState(() {
                            index = HangHoa.indexOf(e);
                            select_1(HangHoa.indexOf(e));
                          });
                        },
                        selected: selected_1[HangHoa.indexOf(e)]);
                  }).toList(),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.white,
                  indent: 15,
                  endIndent: 15,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15),
                  child: Text('PHIẾU',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                ),
                Column(
                  children: Phieu.map((e) {
                    return NavBarItem(
                        title: e,
                        onTap: () {
                          setState(() {
                            index = Phieu.indexOf(e) + 1;
                            select_1(Phieu.indexOf(e) + 1);
                          });
                        },
                        selected: selected_1[Phieu.indexOf(e) + 1]);
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
