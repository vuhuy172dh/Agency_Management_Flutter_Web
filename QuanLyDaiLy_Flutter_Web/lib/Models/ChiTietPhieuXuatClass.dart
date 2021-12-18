import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class CTPX {
  final int? mamathang;
  final String? tenmathang;
  final String? donvi;
  final int? soluongxuat;
  final int? giaxuat;

  CTPX(
      {this.mamathang,
      this.tenmathang,
      this.donvi,
      this.soluongxuat,
      this.giaxuat});

  factory CTPX.fromJson(Map<String, dynamic> json) {
    return CTPX(
      mamathang: json['_mamathang'],
      tenmathang: json['_tenmathang'],
      donvi: json['_donvi'],
      soluongxuat: json['_soluongxuat'],
      giaxuat: json['_giaxuat'],
    );
  }

  Future<List<CTPX>> readChiTietPhieuXuat(int maphieuxuat) async {
    final response = await Injector.appInstance.get<SupabaseClient>().rpc(
        'chitietphieuxuathang_table',
        params: {'_maphieuxuat': maphieuxuat}).execute();
    final data = response.data as List;
    return data.map((e) => CTPX.fromJson(e)).toList();
  }

  Future<String?> addChiTietPhieuXuat(
      int maphieuxuat, int mamathang, int soluong) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('CHITIETPHIEUXUATHANG')
        .insert([
      {'maphieuxuat': maphieuxuat, 'mamathang': mamathang, 'soluong': soluong}
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  Future<String?> deleteChiTietPhieuXuat(int maphieuxuat, int mamathang) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('CHITIETPHIEUXUATHANG')
        .delete()
        .eq('maphieuxuat', maphieuxuat)
        .eq('mamathang', mamathang)
        .execute();
  }
}
