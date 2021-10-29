import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SupabaseManager user = SupabaseManager();
  TextEditingController? _email;
  TextEditingController? _password;
  TextEditingController? _confirmPassword;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('SIGN UP')),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Enter email', border: InputBorder.none),
                      controller: _email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
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
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Enter password', border: InputBorder.none),
                      controller: _password,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid password';
                        }
                        return null;
                      },
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
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Confirm password',
                          border: InputBorder.none),
                      controller: _confirmPassword,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid password';
                        }

                        if (value != _password!.text) {
                          return 'Confirm password does not match';
                        }

                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    child: Text('Signup'),
                    onPressed: _signup,
                    style:
                        ElevatedButton.styleFrom(primary: Colors.blueGrey[800]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _signup() async {
    if (_formKey.currentState!.validate()) {
      await SupabaseManager().client.auth.signUp(_email!.text, _password!.text);
    }
  }
}
