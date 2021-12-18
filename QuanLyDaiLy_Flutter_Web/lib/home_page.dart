import 'package:do_an/DaiLyManager/GiaoDienDSDaiLy.dart';
import 'package:do_an/KhoHangManager/Kho_Hang_SideBar.dart';
import 'package:do_an/NhanVien/GiaoDienDSNhanVien.dart';
import 'package:do_an/NhanVien/GiaoDienTaoTaiKhoan.dart';
import 'package:do_an/QuyDinh_CaiDat.dart/GiaoDienQuyDinh.dart';
import 'package:do_an/TaiChinhManager/tai_chinh_sidebar.dart';
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
            key: Key('DAILY'),
          ),
        ),
        Tab(
          // key: Key('KH'),
          child: Text(
            'KHO HÀNG',
            style: TextStyle(fontFamily: 'Calistoga', fontSize: 15),
            key: Key('KHOHANG'),
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
        Tab(
          child: Text(
            'TẠO TÀI KHOẢN',
            style: TextStyle(fontFamily: 'Calistoga', fontSize: 15),
          ),
        )
      ],
      children: [
        TableDaiLy(),
        KhoHangTabView(),
        TaiChinhSideBar(),
        QuyDinh(),
        NhanVienScreen(),
        TaoTaiKhoan()
      ],
    );
  }
}
