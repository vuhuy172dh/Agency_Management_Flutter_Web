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
        'hansudung': hsd,
        'ngaysanxuat': nsx,
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
  readDataChiTietPhieuThu() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('chitietphieuthutien_table')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataDaiLy(String ma, String ten, String loai) async {
    var response = await Injector.appInstance.get<SupabaseClient>().rpc(
        'timkiemdaily',
        params: {'ma': ma, 'ten': ten, 'loai': loai}).execute();
    print(response.data);
    return response;
  }

  //
  readDataMatHang(String ma, String ten, String sl) async {
    var response = await Injector.appInstance.get<SupabaseClient>().rpc(
        'timkiemhang',
        params: {'mamh': ma, 'tenmh': ten, 'sl': sl}).execute();
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
  readDataSoluongQuan() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('getsoluongquan')
        .execute();
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
    print(response);
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
    print(response);
  }

  //
  deleteDataDaiLy(int id) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('DAILY')
        .delete()
        .eq('madaily', id)
        .execute();
    print(response);
  }

  //
  deleteDataHangHoa(int id) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('MATHANG')
        .delete()
        .eq('mamathang', id)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  deleteDataCTPN(int id) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('CHITIETPHIEUNHAP')
        .delete()
        .eq('stt', id)
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
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  deleteDataCTPX(int id) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('CHITIETPHIEUXUATHANG')
        .delete()
        .eq('stt', id)
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
    if (response.error != null) {
      return response.error!.message;
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
    if (response.error != null) {
      return response.error!.message;
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
    print(response);
  }
}
