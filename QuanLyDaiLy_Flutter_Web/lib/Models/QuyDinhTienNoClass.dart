import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class QuyDinhTienNo {
  final int? loaidaily;
  final int? tiennotoida;

  QuyDinhTienNo({this.loaidaily, this.tiennotoida});

  factory QuyDinhTienNo.fromJson(Map<String,dynamic> json) {
    return QuyDinhTienNo(
      loaidaily: json['loaiDL'],
      tiennotoida: json['maxtienno']
    );
  }

  Future<List<QuyDinhTienNo>> readQuyDinhTienNo() async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYDINHTIENNO')
        .select()
        .execute();
    final data = response.data as List;
    return data.map((e) => QuyDinhTienNo.fromJson(e)).toList();
  }

  Future<String?> addQuyDinhTienNo(int loaidaily, int tiennotoida) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYDINHTIENNO')
        .insert({
          'loaiDL': loaidaily,
          'maxtienno': tiennotoida
        }).execute();
    if(response.error != null) {
      return response.error!.message;
    }
  }

  Future<String?> deleteQuyDinhTienNo(int loaidaily) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYDINHTIENNO')
        .delete()
        .eq('loaiDL', loaidaily)
        .execute();
    var data;
    if(response.data != null){
      data = response.data as List<dynamic>;
    }
    if(response.error != null || data.isEmpty){
      return "has error";
    }
  }

  Future<String?> updateQuyDinhTienNo(int loaidaily, int tiennotoida) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYDINHTIENNO')
        .update({
          'maxtienno': tiennotoida
        }).eq('loaiDL', loaidaily).execute();
    if(response.error != null) {
      return response.error!.message;
    }
  }
}
