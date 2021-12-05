import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class SupabaseManager {
  //
  addData(int madl, String tendl, int loaidl, int sodt, String ngaytiepnhan,
      String email, String quan) async {
    var response =
        await Injector.appInstance.get<SupabaseClient>().from('DAILY').insert([
      {
        'madaily': madl,
        'tendaily': tendl,
        'loaidaily': loaidl,
        'sodienthoai': sodt,
        'ngaytiepnhan': ngaytiepnhan,
        'email': email,
        'quan': quan
      }
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  addDataMH(int maMH, String tenMH, String dv, int gianhap, int giaxuat,
      String nsx, String hsd) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('MATHANG')
        .insert([
      {
        'mamathang': maMH,
        'tenmathang': tenMH,
        'donvi': dv,
        'gianhap': gianhap,
        'giaxuat': giaxuat,
        'hansudung': hsd.isEmpty ? null : hsd,
        'ngaysanxuat': nsx.isEmpty ? null : nsx,
      }
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  // thêm data vô chi tiết phiếu nhập
  addDataCTPN(int maphieunhap, int maMH, int soluong) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('CHITIETPHIEUNHAP')
        .insert([
      {'mamathang': maMH, 'soluong': soluong, 'maphieunhap': maphieunhap}
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  addDataPhieuNhap(int idphieu, String ngay) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUNHAPHANG')
        .insert([
      {
        'maphieunhap': idphieu,
        'ngaynhap': ngay,
      }
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
    print(response);
  }

  //
  addDataCTPX(int maphieuxuat, int maMH, int soluong) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('CHITIETPHIEUXUATHANG')
        .insert([
      {'maphieuxuat': maphieuxuat, 'mamathang': maMH, 'soluong': soluong}
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  addDataPhieuXuat(int maphieuxuat, int maDL, int sotienno, String ngay) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUXUATHANG')
        .insert([
      {
        'maphieuxuat': maphieuxuat,
        'ngayxuat': ngay,
        'madaily': maDL,
        'sotienno': sotienno
      }
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  addDataHoaDon(int maHD, String ngay, int maDL, int sotien) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUTHUTIEN')
        .insert([
      {
        'maphieuthu': maHD,
        'ngaythutien': ngay,
        'madaily': maDL,
        'sotienthu': sotien
      }
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  addDataNhanVien(int maNV, String hoten, String gioitinh, int phone,
      String email, String chucvu) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('NHANVIEN')
        .insert([
      {
        'manhanvien': maNV,
        'hoten': hoten,
        'gioitinh': gioitinh,
        'sodienthoai': phone,
        'chucvu': chucvu,
        'email': email
      }
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  addDataAccount(String tendangnhap, String name, String chucvu) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('acount_user')
        .insert([
      {'tendangnhap': tendangnhap, 'chusohuu': name, 'status': chucvu}
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  readDataAcount() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('acount_user')
        .select()
        .execute();
    return response;
  }

  //
  addDataQCTC(String quan, int sl) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYCHETOCHUC')
        .insert([
      {'quan': quan, 'soluongDL': sl}
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  addDataQDTN(int loai, int tien) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYDINHTIENNO')
        .insert([
      {'loaiDL': loai, 'maxtienno': tien}
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  readData(String dataname) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from(dataname)
        .select()
        .execute();
    print(response.data);
    print(response);
    return response;
  }

  //
  readDataNhanVien(String ma, String gt, String cv) async {
    var response = await Injector.appInstance.get<SupabaseClient>().rpc(
        'nhanvien_table',
        params: {'ma': ma, 'gt': gt, 'cv': cv}).execute();
    print(response.data);
    return response;
  }

  //
  readDataLoaiDL() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYDINHTIENNO')
        .select('loaiDL')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataMaDL() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('DAILY')
        .select('madaily')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataMaMH() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('MATHANG')
        .select('mamathang')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataQuan() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYCHETOCHUC')
        .select('quan')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataChiTietPhieuNhap(int _maphieunhap) async {
    var response = await Injector.appInstance.get<SupabaseClient>().rpc(
        'chitietphieunhaphang_table',
        params: {'_maphieunhap': _maphieunhap}).execute();
    print(response.data);
    return response;
  }

  //
  readDataChiTietPhieuXuat(int _maphieuxuat) async {
    var response = await Injector.appInstance.get<SupabaseClient>().rpc(
        'chitietphieuxuathang_table',
        params: {'_maphieuxuat': _maphieuxuat}).execute();
    print(response.data);
    return response;
  }

  //
  readDataChiTietPhieuThu(
      String maphieuthu, String madaily, String tendaily) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('chitietphieuthutien_table', params: {
      'maphieu': maphieuthu,
      'madl': madaily,
      'tendl': tendaily
    }).execute();
    print(response.data);
    return response;
  }

  //
  readDataDaiLy(String ma, String quan, String loai) async {
    var response = await Injector.appInstance.get<SupabaseClient>().rpc(
        'timkiemdaily',
        params: {'ma': ma, 'loc': quan, 'loai': loai}).execute();
    print(response.data);
    return response;
  }

  //
  readDataMatHang(String ma, String dv, String sl) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('timkiemhang', params: {'mamh': ma, 'dv': dv, 'sl': sl}).execute();
    print(response.data);
    return response;
  }

  //
  readDataBaoCaoThang(int thang, int nam) async {
    var response = await Injector.appInstance.get<SupabaseClient>().rpc(
        'baocaothang_table',
        params: {'thang': thang, 'nam': nam}).execute();
    print(response.data);
    return response;
  }

  //
  readDataBaoCaoCongNo(int thang, int nam) async {
    var response = await Injector.appInstance.get<SupabaseClient>().rpc(
        'baocaocongno_table',
        params: {'thang': thang, 'nam': nam}).execute();
    print(response.data);
    return response;
  }

  //
  readDataQuyCheToChuc() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYCHETOCHUC')
        .select()
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataQuyDinhTienNo() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYDINHTIENNO')
        .select()
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataThongKeTien(int nam) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('tienxuattheothang', params: {'nam': nam}).execute();
    return response;
  }

  //
  readDataDanhSachTienNoDaiLy() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('danhsachtiennodaily')
        .execute();
    return response;
  }

  //
  createPolicyDaiLy(String tentaikhoan) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('policyfordaily', params: {'tendn': tentaikhoan}).execute();
    if (response.error != null) {
      print(response.error!.message);
    }
  }

  //
  readDataSoluongDL() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('soluongdaily')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataSoluongLoaiDL() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('getloaidaily')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataProfile() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('profiles')
        .select('name, chucvu')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataSoluongQuan() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('getsoluongquan')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataTimKiemPhieuNhap(String ma) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('timkiemphieunhap', params: {'maphieu': ma}).execute();
    print(response.data);
    return response;
  }

  //
  readDataTimKiemPhieuXuat(String ma) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('timkiemphieuxuat', params: {'maphieu': ma}).execute();
    print(response.data);
    return response;
  }

  //
  updateDaiLyData(int madl, String tendl, int loaidl, int sodt,
      String ngaytiepnhan, String email, String quan) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('DAILY')
        .update({
          'tendaily': tendl,
          'sodienthoai': sodt,
          'quan': quan,
          'loaidaily': loaidl,
          'ngaytiepnhan': ngaytiepnhan
        })
        .eq('madaily', madl)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
    print(response);
  }

  //
  updateMHData(int maMH, String tenMH, String dv, int gianhap, int giaxuat,
      String nsx, String hsd) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('MATHANG')
        .update({
          'tenmathang': tenMH,
          'donvi': dv,
          'gianhap': gianhap,
          'giaxuat': giaxuat,
          'ngaysanxuat': nsx,
          'hansudung': hsd
        })
        .eq('mamathang', maMH)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  updatePhieuNhapData(int idphieu, String ngay) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUNHAPHANG')
        .update({
          'ngaynhap': ngay,
        })
        .eq('maphieunhap', idphieu)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  updatePhieuXuatData(
      int maphieuxuat, int madaily, String ngay, int tienno) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUXUATHANG')
        .update({'ngayxuat': ngay, 'madaily': madaily, 'sotienno': tienno})
        .eq('maphieuxuat', maphieuxuat)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  updateHoaDonData(int maHD, String ngay, int maDL, int sotien) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUTHUTIEN')
        .update({'ngaythutien': ngay, 'madaily': maDL, 'sotienthu': sotien})
        .eq('maphieuthu', maHD)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  updateNhanVienData(int maNV, String hoten, String gioitinh, int phone,
      String email, String chucvu) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('NHANVIEN')
        .update({
          'hoten': hoten,
          'gioitinh': gioitinh,
          'sodienthoai': phone,
          'chucvu': chucvu,
          'email': email
        })
        .eq('manhanvien', maNV)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  updateAcountData(String tendangnhap, String ten, String chucvu) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('acount_user')
        .update({'status': chucvu, 'chusohuu': ten})
        .eq('tendangnhap', tendangnhap)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  updatePassword(String newpass) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .auth
        .update(UserAttributes(password: newpass));
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  updateQCTC(String quan, int soluong) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYCHETOCHUC')
        .update({'soluongDL': soluong})
        .eq('quan', quan)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  updateQDTN(int loai, int tienno) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYDINHTIENNO')
        .update({'maxtienno': tienno})
        .eq('loaiDL', loai)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  deleteQCTC(String quan) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYCHETOCHUC')
        .delete()
        .eq('quan', quan)
        .execute();
    var data;
    if (response.data != null) {
      data = response.data as List<dynamic>;
    }
    if (response.error != null || data.isEmpty) {
      return 'Có lỗi';
    }
  }

  //
  deleteQDTN(int loai) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYDINHTIENNO')
        .delete()
        .eq('loaiDL', loai)
        .execute();
    var data;
    if (response.data != null) {
      data = response.data as List<dynamic>;
    }
    if (response.error != null || data.isEmpty) {
      return "có lỗi";
    }
  }

  //
  deleteDataDaiLy(int id) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('DAILY')
        .delete()
        .eq('madaily', id)
        .execute();
    var data;
    if (response.data != null) {
      data = response.data as List<dynamic>;
    }
    if (response.error != null || data.isEmpty) {
      return 'Có lỗi';
    }
  }

  //
  deleteDataHangHoa(int id) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('MATHANG')
        .delete()
        .eq('mamathang', id)
        .execute();
    var data;
    if (response.data != null) {
      data = response.data as List<dynamic>;
    }
    if (response.error != null || data.isEmpty) {
      return 'Có lỗi';
    }
  }

  //
  deleteDataCTPN(int idPN, int idMH) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('CHITIETPHIEUNHAP')
        .delete()
        .eq('maphieunhap', idPN)
        .eq('mamathang', idMH)
        .execute();
  }

  //
  deleteDataPhieuNhap(int id) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUNHAPHANG')
        .delete()
        .eq('maphieunhap', id)
        .execute();
    var data;
    if (response.data != null) {
      data = response.data as List<dynamic>;
    }
    if (response.error != null || data.isEmpty) {
      return 'Có lỗi';
    }
  }

  //
  deleteDataCTPX(int idPX, int idMH) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('CHITIETPHIEUXUATHANG')
        .delete()
        .eq('maphieuxuat', idPX)
        .eq('mamathang', idMH)
        .execute();
  }

  //
  deleteDataPhieuXuat(int id) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUXUATHANG')
        .delete()
        .eq('maphieuxuat', id)
        .execute();
    var data;
    if (response.data != null) {
      data = response.data as List<dynamic>;
    }
    if (response.error != null || data.isEmpty) {
      return 'Có lỗi';
    }
  }

  //
  deleteDataHoaDon(int id) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUTHUTIEN')
        .delete()
        .eq('maphieuthu', id)
        .execute();
    var data;
    if (response.data != null) {
      data = response.data as List<dynamic>;
    }
    if (response.error != null || data.isEmpty) {
      return "Có lỗi";
    }
  }

  //
  deleteDataNhanVien(int id) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('NHANVIEN')
        .delete()
        .eq('manhanvien', id)
        .execute();
    var data;
    if (response.data != null) {
      data = response.data as List<dynamic>;
    }
    if (response.error != null || data.isEmpty) {
      return "có lỗi";
    }
  }

  //
  deleteDataAcountUser(String tdn) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('acount_user')
        .delete()
        .eq('tendangnhap', tdn)
        .execute();
  }
}
