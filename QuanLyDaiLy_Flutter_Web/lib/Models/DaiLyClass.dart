import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class DaiLy {
  final int? madaily;
  final String? tendaily;
  final int? loaidaily;
  final int? sodienthoai;
  final String? email;
  final String? quan;
  final String? ngaytiepnhan;
  final int? tienno;

  DaiLy(
      {this.madaily,
      this.tendaily,
      this.loaidaily,
      this.sodienthoai,
      this.email,
      this.quan,
      this.ngaytiepnhan,
      this.tienno});

  factory DaiLy.fromJson(Map<String, dynamic> json) {
    return DaiLy(
      madaily: json['madaily'],
      tendaily: json['tendaily'],
      loaidaily: json['loaidaily'],
      sodienthoai: json['sodienthoai'],
      email: json['email'],
      quan: json['quan'],
      ngaytiepnhan: json['ngaytiepnhan'],
      tienno: json['tienno'],
    );
  }

  Future<List<DaiLy>> readDaiLy(String ma, String quan, String loai) async {
    final response = await Injector.appInstance.get<SupabaseClient>().rpc(
        'timkiemdaily',
        params: {'ma': ma, 'loc': quan, 'loai': loai}).execute();
    final dataList = response.data as List;
    return dataList.map((e) => DaiLy.fromJson(e)).toList();
  }

  Future<String?> addDaiLy(int madaily, String tendaily, int loaidaily,
      int sodienthoai, String ngaytiepnhan, String email, String quan) async {
    final response =
        await Injector.appInstance.get<SupabaseClient>().from('DAILY').insert({
      'madaily': madaily,
      'tendaily': tendaily,
      'loaidaily': loaidaily,
      'sodienthoai': sodienthoai,
      'email': email,
      'quan': quan,
      'ngaytiepnhan': ngaytiepnhan
    }).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  Future<String?> deleteDaiLy(int ma) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('DAILY')
        .delete()
        .eq('madaily', ma)
        .execute();
    var data;
    if (response.data != null) {
      data = response.data as List<dynamic>;
    }
    if (response.error != null || data.isEmpty) {
      return "has Error";
    }
  }

  Future<String?> updateDaiLy(int madaily, String tendaily, int loaidaily,
      int sodienthoai, String ngaytiepnhan, String email, String quan) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('DAILY')
        .update({
          'tendaily': tendaily,
          'loaidaily': loaidaily,
          'sodienthoai': sodienthoai,
          'ngaytiepnhan': ngaytiepnhan,
          'email': email,
          'quan': quan
        })
        .eq('madaily', madaily)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }
}
