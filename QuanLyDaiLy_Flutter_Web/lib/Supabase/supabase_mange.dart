import 'package:supabase/supabase.dart';

const supabaseUrl = 'https://tkabbsxsoektqmhvlrln.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzNjA0MTUyNCwiZXhwIjoxOTUxNjE3NTI0fQ.I0vC0LT6CHleFUjuNJTzBht11jH-W_lAvXhphj4vp4g';

class SupabaseManager {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  addData(int iddaiLy, String name, int phone, String loca, int type,
      String date) async {
    var response = await client.from('DAILY').insert([
      {
        'madaily': iddaiLy,
        'tendaily': name,
        'phone': phone,
        'diachi': loca,
        'loaidaily': type,
        'ngaydangky': date
      }
    ]).execute();
    print(response);
  }

  addDataHH(int id, String name, int gia, String dv, int sluong) async {
    var response = await client.from('HANGHOA').insert([
      {
        'mamathang': id,
        'tenmathang': name,
        'donvi': dv,
        'gia': gia,
        'soluong': sluong
      }
    ]).execute();
    print(response);
  }

  addDataPhieuNhap(
      int idphieu, int idMH, String ngay, int numb, int price) async {
    var response = await client.from('PHIEUNHAPKHO').insert([
      {
        'maphieunhap': idphieu,
        'mamathang': idMH,
        'ngaynhap': ngay,
        'soluong': numb,
        'gia': price,
      }
    ]).execute();
    print(response);
  }

  addDataPhieuXuat(
      int idphieu, int idDL, int idMH, String ngay, int numb, int price) async {
    var response = await client.from('PHIEUXUATKHO').insert([
      {
        'maphieuxuat': idphieu,
        'ngayxuatkho': ngay,
        'madaily': idDL,
        'mamathang': idMH,
        'soluong': numb,
        'gia': price,
      }
    ]).execute();
    print(response);
  }

  addDataHoaDon(int maHD, String ngay, int maDL, int sotien) async {
    var response = await client.from('HOADONTHUTIEN').insert([
      {'mahoadon': maHD, 'ngaythu': ngay, 'madaily': maDL, 'sotienthu': sotien}
    ]).execute();
    print(response);
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

  readData(String dataname) async {
    var response = await client.from(dataname).select().execute();
    print(response.data);
    print(response);
    return response;
  }

  readDataChiTietPhieuNhap(int _maphieunhap) async {
    var response = await client.rpc('chitietphieunhaphang_table',
        params: {'_maphieunhap': _maphieunhap}).execute();
    print(response.data);
    return response;
  }

  readDataPhieuNhap() async {
    var response = await client.from('PHIEUNHAPHANG').select().execute();
    print(response.data);
    return response;
  }

  updateDaiLyData(int iddaiLy, String name, int phone, String loca, int type,
      String date) async {
    var response = await client
        .from('DAILY')
        .update({
          'madaily': iddaiLy,
          'tendaily': name,
          'phone': phone,
          'diachi': loca,
          'loaidaily': type,
          'ngaydangky': date
        })
        .eq('madaily', iddaiLy)
        .execute();
    print(response);
  }

  updateHHData(int id, String name, int gia, String dv) async {
    var response = await client
        .from('HANGHOA')
        .update({
          'mamathang': id,
          'tenmathang': name,
          'donvi': dv,
          'gia': gia,
        })
        .eq('mamathang', id)
        .execute();
    print(response);
  }

  updatePhieuNhapData(
      int idphieu, int idMH, String ngay, int numb, int price) async {
    var response = await client
        .from('PHIEUNHAPKHO')
        .update({
          'maphieunhap': idphieu,
          'mamathang': idMH,
          'ngaynhap': ngay,
          'soluong': numb,
          'gia': price,
        })
        .eq('maphieunhap', idphieu)
        .execute();
    print(response);
  }

  updatePhieuXuatData(
      int idphieu, int idDL, int idMH, String ngay, int numb, int price) async {
    var response = await client
        .from('PHIEUXUATKHO')
        .update({
          'maphieuxuat': idphieu,
          'ngayxuatkho': ngay,
          'madaily': idDL,
          'mamathang': idMH,
          'soluong': numb,
          'gia': price,
        })
        .eq('maphieuxuat', idphieu)
        .execute();
    print(response);
  }

  updateHoaDonData(int maHD, String ngay, int maDL, int sotien) async {
    var response = await client
        .from('HOADONTHUTIEN')
        .update({'ngaythu': ngay, 'madaily': maDL, 'sotienthu': sotien})
        .eq('mahoadon', maHD)
        .execute();
    print(response);
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

  deleteDataDaiLy(int id) async {
    var response =
        await client.from('DAILY').delete().eq('madaily', id).execute();
    print(response);
  }

  deleteDataHangHoa(int id) async {
    var response =
        await client.from('HANGHOA').delete().eq('mamathang', id).execute();
    print(response);
  }

  deleteDataPhieuNhap(int id) async {
    var response = await client
        .from('PHIEUNHAPKHO')
        .delete()
        .eq('maphieunhap', id)
        .execute();
    print(response);
  }

  deleteDataPhieuXuat(int id) async {
    var response = await client
        .from('PHIEUXUATKHO')
        .delete()
        .eq('maphieuxuat', id)
        .execute();
    print(response);
  }

  deleteDataHoaDon(int id) async {
    var response = await client
        .from('HOADONTHUTIEN')
        .delete()
        .eq('mahoadon', id)
        .execute();
    print(response);
  }

  deleteDataNhanVien(int id) async {
    var response =
        await client.from('NHANVIEN').delete().eq('manhanvien', id).execute();
    print(response);
  }
}
