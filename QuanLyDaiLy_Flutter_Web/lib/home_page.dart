import 'package:do_an/DaiLyManager/DaiLytable.dart';
import 'package:do_an/Kho_hang_Manager/Kho_Hang_SideBar.dart';
import 'package:do_an/NhanVien/nhan_vien_manager.dart';
import 'package:do_an/NhanVien/tao_tai_khoan.dart';
import 'package:do_an/QuyDinh_CaiDat.dart/quydinh.dart';
import 'package:do_an/TaiChinh/hoa_don_list.dart';
import 'package:do_an/TaiChinh/tai_chinh_sidebar.dart';
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
