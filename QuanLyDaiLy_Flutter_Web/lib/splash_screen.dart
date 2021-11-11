import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/home_page.dart';
import 'package:do_an/login_page.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await Future.delayed(Duration(seconds: 5));
      final supabaseClient = Injector.appInstance.get<SupabaseClient>();
      final user = supabaseClient.auth.user();
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
