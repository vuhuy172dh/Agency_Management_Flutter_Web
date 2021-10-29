import 'package:do_an/DaiLyManager/DaiLytable.dart';
import 'package:do_an/Kho_hang_Manager/Kho_Hang_SideBar.dart';
import 'package:do_an/NhanVien/nhan_vien_manager.dart';
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
        Tab(text: 'Đại Lý'),
        Tab(text: 'Kho Hàng'),
        Tab(text: 'Tài Chính'),
        Tab(text: 'Quy Định'),
        Tab(
          text: 'Nhân Viên',
        ),
      ],
      children: [
        TableDaiLy(),
        KhoHangTabView(),
        Container(),
        Container(),
        NhanVienScreen()
      ],
    );
  }
}
