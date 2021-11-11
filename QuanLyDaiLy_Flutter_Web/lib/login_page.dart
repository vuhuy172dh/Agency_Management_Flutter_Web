import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/home_page.dart';
import 'package:do_an/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SupabaseManager user = SupabaseManager();
  TextEditingController? _email;
  TextEditingController? _password;
  bool? _passwordVisible;
  @override
  void initState() {
    super.initState();

    _email = TextEditingController();
    _password = TextEditingController();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[300],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'QUẢN LÝ ĐẠI LÝ',
                  style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontStyle: FontStyle.normal,
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                child: Text(
                  'NHÓM 8',
                  style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.black)),
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: 'Enter email', border: InputBorder.none),
                  controller: _email,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.black)),
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: 'Enter password',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible!
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible!;
                          });
                        },
                      )),
                  controller: _password,
                  obscureText: !_passwordVisible!,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(primary: Colors.blueGrey[800]),
                child: Text('Log In'),
              ),
              const SizedBox(
                height: 3,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Text(
                  'Don\'t have an account? Signup!',
                  style: TextStyle(color: Colors.blueGrey[800]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _login() async {
    final signInResult = await Injector.appInstance
        .get<SupabaseClient>()
        .auth
        .signIn(email: _email!.text, password: _password!.text);
    if (signInResult != null && signInResult.user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (signInResult.error!.message != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(signInResult.error!.message)));
    }
  }
}
