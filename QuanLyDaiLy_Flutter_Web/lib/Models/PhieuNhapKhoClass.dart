import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class PhieuNhapKho {
  final int? maphieunhap;
  final int? thanhtien;
  final String? ngaynhap;

  PhieuNhapKho({this.maphieunhap, this.thanhtien, this.ngaynhap});

  factory PhieuNhapKho.fromJson(Map<String, dynamic> json) {
    return PhieuNhapKho(
        maphieunhap: json['maphieunhap'],
        thanhtien: json['thanhtien'],
        ngaynhap: json['ngaynhap']);
  }

  Future<List<PhieuNhapKho>> readPhieuNhapKho(String ma) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('timkiemphieunhap', params: {'maphieu': ma}).execute();
    final data = response.data as List;
    return data.map((e) => PhieuNhapKho.fromJson(e)).toList();
  }

  Future<String?> addPhieuNhap(int maphieunhap, String ngaynhap) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUNHAPHANG')
        .insert([
      {
        'maphieunhap': maphieunhap,
        'ngaynhap': ngaynhap,
      }
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  Future<String?> deletePhieuNhap(int maphieunhap) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUNHAPHANG')
        .delete()
        .eq('maphieunhap', maphieunhap)
        .execute();
    var data;
    if (response.data != null) {
      data = response.data as List<dynamic>;
    }
    if (response.error != null || data.isEmpty) {
      return 'Có lỗi';
    }
  }

  Future<String?> updatePhieuNhap(int maphieunhap, String ngaynhap) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUNHAPHANG')
        .update({
          'ngaynhap': ngaynhap,
        })
        .eq('maphieunhap', maphieunhap)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }
}
