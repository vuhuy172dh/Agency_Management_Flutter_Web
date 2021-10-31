import 'package:supabase/supabase.dart';

const supabaseUrl = 'https://xubqmgnmblkwhceypmta.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzNDQ3OTcxNSwiZXhwIjoxOTUwMDU1NzE1fQ.55Ebrhr2xUdIfiD-UADMe80j8gQdlIyJNgZclBdLzE0';

class SupabaseManager {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  addData(int iddaiLy, String name, int phone, String loca, int type,
      String date) async {
    var response = await client.from('DaiLyList').insert([
      {
        'id_DaiLy': iddaiLy,
        'name': name,
        'Phone': phone,
        'Location': loca,
        'Type': type,
        'Date': date
      }
    ]).execute();
    print(response);
  }

  addDataHH(int id, String name, int gia, String dv) async {
    var response = await client.from('Hang_hoa').insert([
      {
        'ma_MH': id,
        'Name_HH': name,
        'Don_vi': dv,
        'Gia': gia,
      }
    ]).execute();
    print(response);
  }

  addDataPhieuNhap(
      int idphieu, int idMH, String ngay, int numb, int price) async {
    var response = await client.from('Phieu_nhap_kho').insert([
      {
        'id_Phieu': idphieu,
        'id_MH': idMH,
        'Ngay_nhap': ngay,
        'So_luong': numb,
        'Gia': price,
      }
    ]).execute();
    print(response);
  }

  addDataPhieuXuat(
      int idphieu, int idDL, int idMH, String ngay, int numb, int price) async {
    var response = await client.from('Phieu_xuat_kho').insert([
      {
        'id_MP': idphieu,
        'Ngay_xuat': ngay,
        'id_DL': idDL,
        'id_MH': idMH,
        'So_luong': numb,
        'Gia': price,
      }
    ]).execute();
    print(response);
  }

  readData(String dataname) async {
    var response =
        await client.from(dataname).select().range(-1, 100).execute();
    print(response.data);
    print(response);
    return response;
  }

  updateDaiLyData(int iddaiLy, String name, int phone, String loca, int type,
      String date) async {
    var response = await client
        .from('DaiLyList')
        .update({
          'id_DaiLy': iddaiLy,
          'name': name,
          'Phone': phone,
          'Location': loca,
          'Type': type,
          'Date': date
        })
        .eq('id_DaiLy', iddaiLy)
        .execute();
    print(response);
  }

  updateHHData(int id, String name, int gia, String dv) async {
    var response = await client
        .from('Hang_hoa')
        .update({
          'ma_MH': id,
          'Name_HH': name,
          'Don_vi': dv,
          'Gia': gia,
        })
        .eq('ma_MH', id)
        .execute();
    print(response);
  }

  updatePhieuNhapData(
      int idphieu, int idMH, String ngay, int numb, int price) async {
    var response = await client
        .from('Phieu_nhap_kho')
        .update({
          'id_Phieu': idphieu,
          'id_MH': idMH,
          'Ngay_nhap': ngay,
          'So_luong': numb,
          'Gia': price,
        })
        .eq('id_Phieu', idphieu)
        .execute();
    print(response);
  }

  updatePhieuXuatData(
      int idphieu, int idDL, int idMH, String ngay, int numb, int price) async {
    var response = await client
        .from('Phieu_xuat_kho')
        .update({
          'id_MP': idphieu,
          'Ngay_xuat': ngay,
          'id_DL': idDL,
          'id_MH': idMH,
          'So_luong': numb,
          'Gia': price,
        })
        .eq('id_MP', idphieu)
        .execute();
    print(response);
  }

  deleteDataDaiLy(int id) async {
    var response =
        await client.from('DaiLyList').delete().eq('id_DaiLy', id).execute();
    print(response);
  }

  deleteDataHangHoa(int id) async {
    var response =
        await client.from('Hang_hoa').delete().eq('id_MH', id).execute();
    print(response);
  }

  deleteDataPhieuNhap(int id) async {
    var response = await client
        .from('Phieu_nhap_kho')
        .delete()
        .eq('id_Phieu', id)
        .execute();
    print(response);
  }

  deleteDataPhieuXuat(int id) async {
    var response =
        await client.from('Phieu_xuat_kho').delete().eq('id_MP', id).execute();
    print(response);
  }
}
