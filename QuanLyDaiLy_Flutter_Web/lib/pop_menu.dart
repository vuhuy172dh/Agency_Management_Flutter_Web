import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/new_pass.dart';
import 'package:do_an/profile_container.dart';
import 'package:do_an/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class PopupOptionMenu extends StatelessWidget {
  const PopupOptionMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formFieldKey = GlobalKey<FormFieldState>();
    TextEditingController new_password = TextEditingController();
    SupabaseManager supabaseManager = SupabaseManager();
    return PopupMenuButton(
        icon: Icon(Icons.arrow_drop_down_circle),
        onSelected: (value) async {
          if (value == MenuOption.signout) {
            await Injector.appInstance.get<SupabaseClient>().auth.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SplashScreen()));
          } else if (value == MenuOption.profile) {
            await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Profile'),
                    content: ProfilePage(),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  );
                });
          } else {
            await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('New Password'),
                    content:
                        NewPass(formKey: formFieldKey, new_pass: new_password),
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                            final isValid =
                                formFieldKey.currentState!.validate();
                            if (isValid) {
                              var data = await supabaseManager
                                  .updatePassword(new_password.text);
                              if (data != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(data)));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Đổi thành công')));
                                new_password.clear();
                                Navigator.pop(context);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey),
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            new_password.clear();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey),
                          child: Text(
                            'Cance',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  );
                });
          }
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<MenuOption>>[
            PopupMenuItem(
              child: Text('profile'),
              value: MenuOption.profile,
            ),
            PopupMenuItem(
              child: Text('new password'),
              value: MenuOption.new_password,
            ),
            PopupMenuItem(
              child: Text('sign out'),
              value: MenuOption.signout,
            ),
          ];
        });
  }
}

enum MenuOption { profile, signout, new_password }
