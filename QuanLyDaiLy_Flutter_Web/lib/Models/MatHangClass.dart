import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class MatHang {
  final int? mamathang;
  final String? tenmathang;
  final String? donvi;
  final int? gianhap;
  final int? giaxuat;
  final int? soluong;
  final String? ngaysanxuat;
  final String? hansudung;

  MatHang(
      {this.mamathang,
      this.tenmathang,
      this.donvi,
      this.gianhap,
      this.giaxuat,
      this.soluong,
      this.ngaysanxuat,
      this.hansudung});

  factory MatHang.fromJson(Map<String, dynamic> json) {
    return MatHang(
        mamathang: json['mamathang'],
        tenmathang: json['tenmathang'],
        donvi: json['donvi'],
        gianhap: json['gianhap'],
        giaxuat: json['giaxuat'],
        soluong: json['soluong'],
        ngaysanxuat: json['ngaysanxuat'],
        hansudung: json['hansudung']);
  }

  Future<List<MatHang>> readMatHang(String ma, String dv, String sl) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('timkiemhang', params: {'mamh': ma, 'dv': dv, 'sl': sl}).execute();
    final dataList = response.data as List;
    return dataList.map((e) => MatHang.fromJson(e)).toList();
  }

  Future<String?> addMatHang(int mamathang, String tenmathang, String donvi,
      int gianhap, int giaxuat, String ngaysanxuat, String hansudung) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('MATHANG')
        .insert({
      'mamathang': mamathang,
      'tenmathang': tenmathang,
      'donvi': donvi,
      'gianhap': gianhap,
      'giaxuat': giaxuat,
      'hansudung': hansudung.isEmpty ? null : hansudung,
      'ngaysanxuat': ngaysanxuat.isEmpty ? null : ngaysanxuat
    }).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  Future<String?> deleteMatHang(int mamathang) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('MATHANG')
        .delete()
        .eq('mamathang', mamathang)
        .execute();
    var data;
    if (response.data != null) {
      data = response.data as List<dynamic>;
    }
    if (response.error != null || data.isEmpty) {
      return "has Error";
    }
  }

  Future<String?> updateMatHang(int mamathang, String tenmathang, String donvi,
      int gianhap, int giaxuat, String ngaysanxuat, String hansudung) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('MATHANG')
        .update({
          'tenmathang': tenmathang,
          'donvi': donvi,
          'gianhap': gianhap,
          'giaxuat': giaxuat,
          'ngaysanxuat': ngaysanxuat,
          'hansudung': hansudung
        })
        .eq('mamathang', mamathang)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }
}
