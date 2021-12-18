import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class PhieuXuatKho {
  final int? maphieuxuat;
  final String? ngayxuat;
  final int? madaily;
  final int? thanhtien;
  final int? sotienno;

  PhieuXuatKho(
      {this.maphieuxuat,
      this.ngayxuat,
      this.madaily,
      this.thanhtien,
      this.sotienno});

  factory PhieuXuatKho.fromJson(Map<String, dynamic> json) {
    return PhieuXuatKho(
        maphieuxuat: json['maphieuxuat'],
        ngayxuat: json['ngayxuat'],
        madaily: json['madaily'],
        thanhtien: json['thanhtien'],
        sotienno: json['sotienno']);
  }

  Future<List<PhieuXuatKho>> readPhieuXuatKho(String ma) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('timkiemphieuxuat', params: {'maphieu': ma}).execute();
    final data = response.data as List;
    print(data);
    return data.map((e) => PhieuXuatKho.fromJson(e)).toList();
  }

  Future<String?> addPhieuXuatKho(
      int maphieuxuat, String ngayxuat, int madaily, int sotienno) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUXUATHANG')
        .insert([
      {
        'maphieuxuat': maphieuxuat,
        'ngayxuat': ngayxuat,
        'madaily': madaily,
        'sotienno': sotienno
      }
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  Future<String?> updatePhieuXuatKho(
      int maphieuxuat, String ngayxuat, int madaily, int sotienno) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUXUATHANG')
        .update(
            {'ngayxuat': ngayxuat, 'madaily': madaily, 'sotienno': sotienno})
        .eq('maphieuxuat', maphieuxuat)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  Future<String?> deletePhieuXuatKho(int maphieuxuat) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('PHIEUXUATHANG')
        .delete()
        .eq('maphieuxuat', maphieuxuat)
        .execute();
    var data;
    if (response.data != null) {
      data = response.data as List<dynamic>;
    }
    if (response.error != null || data.isEmpty) {
      return 'Có lỗi';
    }
  }
}
