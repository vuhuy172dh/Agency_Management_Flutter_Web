import 'package:do_an/DaiLyManager/DaiLytable.dart';
import 'package:do_an/Kho_hang_Manager/Kho_Hang_SideBar.dart';
import 'package:do_an/NhanVien/nhan_vien_manager.dart';
import 'package:do_an/TaiChinh/hoa_don_list.dart';
import 'package:do_an/header_tabBar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return TabBarWidget(
      tabs: [
        Tab(
          child: Text(
            'ĐẠI LÝ',
            style: TextStyle(fontFamily: 'Calistoga', fontSize: 15),
          ),
        ),
        Tab(
          child: Text(
            'KHO HÀNG',
            style: TextStyle(fontFamily: 'Calistoga', fontSize: 15),
          ),
        ),
        Tab(
          child: Text(
            'TÀI CHÍNH',
            style: TextStyle(fontFamily: 'Calistoga', fontSize: 15),
          ),
        ),
        Tab(
          child: Text(
            'QUY ĐỊNH',
            style: TextStyle(fontFamily: 'Calistoga', fontSize: 15),
          ),
        ),
        Tab(
          child: Text(
            'NHÂN VIÊN',
            style: TextStyle(fontFamily: 'Calistoga', fontSize: 15),
          ),
        ),
      ],
      children: [
        TableDaiLy(),
        KhoHangTabView(),
        HoaDonList(),
        Container(),
        NhanVienScreen()
      ],
    );
  }
}
