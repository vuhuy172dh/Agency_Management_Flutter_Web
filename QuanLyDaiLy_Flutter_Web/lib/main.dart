import 'package:do_an/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

void main() {
  const supabaseUrl = "https://tkabbsxsoektqmhvlrln.supabase.co";
  const supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzNjA0MTUyNCwiZXhwIjoxOTUxNjE3NTI0fQ.I0vC0LT6CHleFUjuNJTzBht11jH-W_lAvXhphj4vp4g';

  final client = SupabaseClient(supabaseUrl, supabaseKey);
  Injector.appInstance.registerSingleton<SupabaseClient>(() => client);
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blueGrey,
      theme: ThemeData(
          brightness: Brightness.light, primaryColor: Colors.blueGrey),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
