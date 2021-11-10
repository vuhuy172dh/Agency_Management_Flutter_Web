import 'package:supabase/supabase.dart';

const supabaseUrl = 'https://tkabbsxsoektqmhvlrln.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzNjA0MTUyNCwiZXhwIjoxOTUxNjE3NTI0fQ.I0vC0LT6CHleFUjuNJTzBht11jH-W_lAvXhphj4vp4g';

class SupabaseManager {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  //
  addData(int madl, String tendl, int loaidl, int sodt, String ngaytiepnhan,
      String email, String quan) async {
    var response = await client.from('DAILY').insert([
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
    var response = await client.from('MATHANG').insert([
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
    var response = await client.from('CHITIETPHIEUNHAP').insert([
      {'mamathang': maMH, 'soluong': soluong, 'maphieunhap': maphieunhap}
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  addDataPhieuNhap(int idphieu, String ngay) async {
    var response = await client.from('PHIEUNHAPHANG').insert([
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
    var response = await client.from('CHITIETPHIEUXUATHANG').insert([
      {'maphieuxuat': maphieuxuat, 'mamathang': maMH, 'soluong': soluong}
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  addDataPhieuXuat(int maphieuxuat, int maDL, int sotienno, String ngay) async {
    var response = await client.from('PHIEUXUATHANG').insert([
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
    var response = await client.from('PHIEUTHUTIEN').insert([
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

  addDataNhanVien(
      int maNV, String hoten, String gioitinh, int phone, String diachi) async {
    var response = await client.from('NHANVIEN').insert([
      {
        'manhanvien': maNV,
        'hoten': hoten,
        'gioitinh': gioitinh,
        'phone': phone,
        'diachi': diachi
      }
    ]).execute();
    print(response);
  }

  //
  readData(String dataname) async {
    var response = await client.from(dataname).select().execute();
    print(response.data);
    print(response);
    return response;
  }

  //
  readDataLoaiDL() async {
    var response =
        await client.from('QUYDINHTIENNO').select('loaiDL').execute();
    print(response.data);
    return response;
  }

  //
  readDataMaDL() async {
    var response = await client.from('DAILY').select('madaily').execute();
    print(response.data);
    return response;
  }

  //
  readDataMaMH() async {
    var response = await client.from('MATHANG').select('mamathang').execute();
    print(response.data);
    return response;
  }

  //
  readDataQuan() async {
    var response = await client.from('QUYCHETOCHUC').select('quan').execute();
    print(response.data);
    return response;
  }

  //
  readDataChiTietPhieuNhap(int _maphieunhap) async {
    var response = await client.rpc('chitietphieunhaphang_table',
        params: {'_maphieunhap': _maphieunhap}).execute();
    print(response.data);
    return response;
  }

  //
  readDataChiTietPhieuXuat(int _maphieuxuat) async {
    var response = await client.rpc('chitietphieuxuathang_table',
        params: {'_maphieuxuat': _maphieuxuat}).execute();
    print(response.data);
    return response;
  }

  //
  readDataChiTietPhieuThu() async {
    var response = await client.rpc('chitietphieuthutien_table').execute();
    print(response.data);
    return response;
  }

  //
  readDataBaoCaoThang(int thang, int nam) async {
    var response = await client.rpc('baocaothang_table',
        params: {'thang': thang, 'nam': nam}).execute();
    print(response.data);
    return response;
  }

  //
  readDataBaoCaoCongNo(int thang, int nam) async {
    var response = await client.rpc('baocaocongno_table',
        params: {'thang': thang, 'nam': nam}).execute();
    print(response.data);
    return response;
  }

  //
  readDataQuyCheToChuc() async {
    var response = await client.from('QUYCHETOCHUC').select().execute();
    print(response.data);
    return response;
  }

  //
  readDataQuyDinhTienNo() async {
    var response = await client.from('QUYDINHTIENNO').select().execute();
    print(response.data);
    return response;
  }

  //
  updateDaiLyData(int madl, String tendl, int loaidl, int sodt,
      String ngaytiepnhan, String email, String quan) async {
    var response = await client
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
    var response = await client
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
    var response = await client
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
    var response = await client
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
    var response = await client
        .from('PHIEUTHUTIEN')
        .update({'ngaythutien': ngay, 'madaily': maDL, 'sotienthu': sotien})
        .eq('maphieuthu', maHD)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  updateNhanVienData(
      int maNV, String hoten, String gioitinh, int phone, String diachi) async {
    var response = await client
        .from('NHANVIEN')
        .update({
          'hoten': hoten,
          'gioitinh': gioitinh,
          'phone': phone,
          'diachi': diachi
        })
        .eq('manhanvien', maNV)
        .execute();
    print(response);
  }

  //
  deleteDataDaiLy(int id) async {
    var response =
        await client.from('DAILY').delete().eq('madaily', id).execute();
    print(response);
  }

  //
  deleteDataHangHoa(int id) async {
    var response =
        await client.from('MATHANG').delete().eq('mamathang', id).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  deleteDataCTPN(int id) async {
    var response =
        await client.from('CHITIETPHIEUNHAP').delete().eq('stt', id).execute();
  }

  //
  deleteDataPhieuNhap(int id) async {
    var response = await client
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
    var response = await client
        .from('CHITIETPHIEUXUATHANG')
        .delete()
        .eq('stt', id)
        .execute();
  }

  //
  deleteDataPhieuXuat(int id) async {
    var response = await client
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
    var response = await client
        .from('PHIEUTHUTIEN')
        .delete()
        .eq('maphieuthu', id)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  deleteDataNhanVien(int id) async {
    var response =
        await client.from('NHANVIEN').delete().eq('manhanvien', id).execute();
    print(response);
  }
}
