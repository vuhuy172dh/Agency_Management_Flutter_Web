import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class QuyCheToChuc {
  final String? quan;
  final int? soluongdaily;

  QuyCheToChuc({this.quan, this.soluongdaily});

  factory QuyCheToChuc.fromJson(Map<String,dynamic> json) {
    return QuyCheToChuc(
      quan: json['quan'],
      soluongdaily: json['soluongDL']
    );
  }

  Future<List<QuyCheToChuc>> readQuyCheToChuc() async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYCHETOCHUC')
        .select()
        .execute();
    final data = response.data as List;
    return data.map((e) => QuyCheToChuc.fromJson(e)).toList();
  }

  Future<String?> addQuyCheToChuc(String quan, int soluongdaily) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYCHETOCHUC')
        .insert({
          'quan': quan,
          'soluongDL': soluongdaily
        }).execute();
    if(response.error != null) {
      return response.error!.message;
    }
  }

  Future<String?> deleteQuyCheToChuc(String quan) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYCHETOCHUC')
        .delete()
        .eq('quan', quan)
        .execute();
    var data;
    if(response.data != null) {
      data = response.data as List<dynamic>;
    }
    if(response.error != null || data.isEmpty) {
      return "has error";
    }
  }

  Future<String?> updateQuyCheToChuc(String quan, int soluongdaily) async {
    final response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYCHETOCHUC')
        .update({
          'soluongDL': soluongdaily
        }).eq('quan', quan).execute();
    if(response.error != null) {
      return response.error!.message;
    }
  }
}
