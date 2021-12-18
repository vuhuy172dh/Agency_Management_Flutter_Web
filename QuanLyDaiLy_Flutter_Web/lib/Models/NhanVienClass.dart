import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class NhanVien {
  final int? manhanvien;
  final String? hoten;
  final String? gioitinh;
  final String? chucvu;
  final int? sodienthoai;
  final String? email;

  NhanVien({
    this.manhanvien, 
    this.hoten, 
    this.gioitinh, 
    this.chucvu, 
    this.email, 
    this.sodienthoai});

  factory NhanVien.fromJson(Map<String,dynamic> json) {
    return NhanVien(
      manhanvien: json['manhanvien'],
      hoten: json['hoten'],
      gioitinh: json['gioitinh'],
      chucvu: json['chucvu'],
      sodienthoai: json['sodienthoai'],
      email: json['email']
    );
  }

  Future<List<NhanVien>> readNhanVien(String manhanvien, String gioitinh, String chucvu) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
       .rpc('nhanvien_table', params: {'ma': manhanvien, 'gt': gioitinh, 'cv': chucvu}).execute();
    final data = response.data as List;
    return data.map((e) => NhanVien.fromJson(e)).toList();
  }

  Future<String?> addNhanVien(
      int manhanvien, String hoten, String gioitinh, int sodienthoai, String email, String chucvu
      ) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('NHANVIEN')
        .insert({
          'manhanvien': manhanvien,
          'hoten': hoten,
          'gioitinh': gioitinh,
          'sodienthoai': sodienthoai,
          'chucvu': chucvu,
          'email': email
        }).execute();
    if(response.error != null){
      return response.error!.message;
    }
  }

  Future<String?> deleteNhanVien(int manhanvien) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('NHANVIEN')
        .delete()
        .eq('manhanvien', manhanvien)
        .execute();
    var data;
    if(response.data != null){
      data = response.data as List<dynamic>;
    }
    if(response.error != null || data.isEmpty) {
      return "has error";
    }
  }

  Future<String?> updateNhanVien(int manhanvien, String hoten, String gioitinh,
      int sodienthoai, String email, String chucvu) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('NHANVIEN')
        .update({
          'hoten': hoten,
          'gioitinh': gioitinh,
          'sodienthoai': sodienthoai,
          'chucvu': chucvu,
          'email': email
        }).eq('manhanvien', manhanvien).execute();
    if(response.error != null){
      return response.error!.message;
    }
  }
}
