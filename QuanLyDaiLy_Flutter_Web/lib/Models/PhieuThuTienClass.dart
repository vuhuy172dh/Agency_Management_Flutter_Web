import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class PhieuThuTien {
  final int? maphieuthu;
  final int? madaily;
  final String? tendaily;
  final String? quan;
  final int? sodienthoai;
  final String? email;
  final int? sotienthu;
  final String? ngaythu;

  PhieuThuTien(
      {this.maphieuthu,
      this.madaily,
      this.tendaily,
      this.quan,
      this.sodienthoai,
      this.email,
      this.sotienthu,
      this.ngaythu});
  factory PhieuThuTien.fromJson(Map<String, dynamic> json) {
    return PhieuThuTien(
        maphieuthu: json['_maphieuthu'],
        madaily: json['_madaily'],
        tendaily: json['_tendaily'],
        quan: json['_quan'],
        sodienthoai: json['_sodienthoai'],
        email: json['_email'],
        sotienthu: json['_sotienthu'],
        ngaythu: json['_ngaythu']);
  }

  Future<List<PhieuThuTien>> readPhieuThuTien(
      String maphieuthu, String madaily, String tendaily) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('chitietphieuthutien_table', params: {
          'maphieu': maphieuthu,
          'madl': madaily,
          'tendl': tendaily
        }).execute();
    final data = response.data as List;
    return data.map((e) => PhieuThuTien.fromJson(e)).toList();
  }

  Future<String?> addPhieuThuTien(int maphieuthu, String ngaythu, int madaily, int sotienthu) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUTHUTIEN')
        .insert({
          'maphieuthu': maphieuthu,
          'ngaythutien': ngaythu,
          'madaily': madaily,
          'sotienthu': sotienthu
        }).execute();
    if(response.error != null) {
      return response.error!.message;
    }
  }

  Future<String?> deletePhieuThuTien(int maphieuthu) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUTHUTIEN')
        .delete()
        .eq('maphieuthu', maphieuthu)
        .execute();
    var data;
    if(response.data != null) {
      data = response.data as List<dynamic>;
    }
    if(response.error != null || data.isEmpty) {
      return "has error";
    }
  }

  Future<String?> updatePhieuThuTien(int maphieuthu, String ngaythu, int madaily, int sotienthu) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUTHUTIEN')
        .update({
          'ngaythutien': ngaythu,
          'madaily': madaily,
          'sotienthu': sotienthu
        }).eq('maphieuthu', maphieuthu).execute();
    if(response.error != null) {
      return response.error!.message;
    }
  }
}
