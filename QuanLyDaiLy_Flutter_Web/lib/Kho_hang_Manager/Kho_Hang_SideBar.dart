import 'package:do_an/Kho_hang_Manager/Hang_hoa_list.dart';
import 'package:do_an/Kho_hang_Manager/phieu_nhap_list.dart';
import 'package:do_an/Kho_hang_Manager/phieu_xuat_list.dart';
import 'package:do_an/Kho_hang_Manager/sap_het_hang.dart';
import 'package:do_an/Kho_hang_Manager/ton_kho_list.dart';
import 'package:flutter/material.dart';

class KhoHangTabView extends StatefulWidget {
  const KhoHangTabView({Key? key}) : super(key: key);

  @override
  _KhoHangTabViewState createState() => _KhoHangTabViewState();
}

List<bool> selected_1 = [true, false, false, false, false];
// List<bool> selected_2 = [false, false];
int index = 0;

Widget SwitchPage(int index) {
  if (index == 0) {
    return HangHoaList();
  } else if (index == 1) {
    return TonKhoList();
  } else if (index == 2) {
    return SapHetHang();
  } else if (index == 3) {
    return PhieuNhapList();
  } else {
    return PhieuXuatList();
  }
}

class _KhoHangTabViewState extends State<KhoHangTabView> {
  TextEditingController? _Search;
  List<String> HangHoa = [
    'Tất cả mặt hàng',
    'Tồn kho',
    'Sắp hết hàng',
  ];

  List<String> Phieu = ['Phiếu nhập kho', 'Phiếu xuất kho'];

  @override
  void initState() {
    super.initState();
    _Search = TextEditingController();
  }

  void select_1(int n) {
    for (int i = 0; i < 5; i++) {
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
                            index = Phieu.indexOf(e) + 3;
                            select_1(Phieu.indexOf(e) + 3);
                          });
                        },
                        selected: selected_1[Phieu.indexOf(e) + 3]);
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

class NavBarItem extends StatefulWidget {
  final String title;
  final Function onTap;
  final bool selected;
  NavBarItem({
    required this.title,
    required this.onTap,
    required this.selected,
  });
  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> with TickerProviderStateMixin {
  late AnimationController _controller2;
  late Animation<Color?> _color;

  bool hovered = false;

  @override
  void initState() {
    super.initState();
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 275),
    );

    _color =
        ColorTween(end: Colors.red, begin: Colors.white).animate(_controller2);

    // _controller1.addListener(() {
    //   setState(() {});
    // });
    _controller2.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.selected) {
      Future.delayed(Duration(milliseconds: 10), () {});
      _controller2.reverse();
    } else {
      _controller2.forward();
      Future.delayed(Duration(milliseconds: 10), () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (value) {
          setState(() {
            hovered = false;
          });
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 35),
          width: 202,
          color:
              hovered && !widget.selected ? Colors.white12 : Colors.transparent,
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 167,
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: _color.value, fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
