import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class SupabaseManager {

  //
  addDataAccount(String tendangnhap, String name, String chucvu) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('acount_user')
        .insert([
      {'tendangnhap': tendangnhap, 'chusohuu': name, 'status': chucvu}
    ]).execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  readDataAcount() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('acount_user')
        .select()
        .execute();
    return response;
  }

  //
  readDataLoaiDL() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYDINHTIENNO')
        .select('loaiDL')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataMaDL() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('DAILY')
        .select('madaily')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataQuan() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('QUYCHETOCHUC')
        .select('quan')
        .execute();
    print(response.data);
    return response;
  }

  readDataMaMH() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('MATHANG')
        .select('mamathang')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataBaoCaoThang(int thang, int nam) async {
    var response = await Injector.appInstance.get<SupabaseClient>().rpc(
        'baocaothang_table',
        params: {'thang': thang, 'nam': nam}).execute();
    print(response.data);
    return response;
  }

  //
  readDataBaoCaoCongNo(int thang, int nam) async {
    var response = await Injector.appInstance.get<SupabaseClient>().rpc(
        'baocaocongno_table',
        params: {'thang': thang, 'nam': nam}).execute();
    print(response.data);
    return response;
  }

  //
  readDataThongKeTien(int nam) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('tienxuattheothang', params: {'nam': nam}).execute();
    return response;
  }

  //
  readDataDanhSachTienNoDaiLy() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('danhsachtiennodaily')
        .execute();
    return response;
  }

  //
  readDataSoluongDL() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('soluongdaily')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataSoluongLoaiDL() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('getloaidaily')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataProfile() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('profiles')
        .select('name, chucvu')
        .execute();
    print(response.data);
    return response;
  }

  //
  readDataSoluongQuan() async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .rpc('getsoluongquan')
        .execute();
    print(response.data);
    return response;
  }

  //
  updateAcountData(String tendangnhap, String ten, String chucvu) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('acount_user')
        .update({'status': chucvu, 'chusohuu': ten})
        .eq('tendangnhap', tendangnhap)
        .execute();
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  updatePassword(String newpass) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .auth
        .update(UserAttributes(password: newpass));
    if (response.error != null) {
      return response.error!.message;
    }
  }

  //
  deleteDataAcountUser(String tdn) async {
    var response = await Injector.appInstance
        .get<SupabaseClient>()
        .from('acount_user')
        .delete()
        .eq('tendangnhap', tdn)
        .execute();
  }
}
