import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class CTPN {
  final int? mamathang;
  final String? tenmathang;
  final String? donvi;
  final int? soluongnhap;
  final int? gianhap;

  CTPN(
      {this.mamathang,
      this.tenmathang,
      this.donvi,
      this.soluongnhap,
      this.gianhap});

  factory CTPN.fromJson(Map<String, dynamic> json) {
    return CTPN(
        mamathang: json['_mamathang'],
        tenmathang: json['_tenmathang'],
        donvi: json['_donvi'],
        soluongnhap: json['_soluongnhap'],
        gianhap: json['_gianhap']);
  }

  Future<List<CTPN>> readChiTietPhieuNhap(int maphieunhap) async {
    final response = await Injector.appInstance.get<SupabaseClient>().rpc(
        'chitietphieunhaphang_table',
        params: {'_maphieunhap': maphieunhap}).execute();
    final data = response.data as List;
    return data.map((e) => CTPN.fromJson(e)).toList();
  }

  Future<String?> addChiTietPhieuNhap(
      int maphieunhap, int mamathang, int soluong) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('CHITIETPHIEUNHAP')
        .insert({
      'mamathang': mamathang,
      'soluong': soluong,
      'maphieunhap': maphieunhap
    }).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  Future<String?> deleteChiTietPhieuNhap(int maphieunhap, int mamathang) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('CHITIETPHIEUNHAP')
        .delete()
        .eq('maphieunhap', maphieunhap)
        .eq('mamathang', mamathang)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }
}
