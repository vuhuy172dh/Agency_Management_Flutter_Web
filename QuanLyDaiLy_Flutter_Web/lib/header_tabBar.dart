import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/splash_screen.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> children;
  const TabBarWidget({Key? key, required this.tabs, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'QUẢN LÝ ĐẠI LÝ',
            style: TextStyle(
              fontFamily: 'BungeeInline',
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          centerTitle: true,
          actions: [
            CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'girl_xinh.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            ElevatedButton(
              onPressed: () async {
                await SupabaseManager().client.auth.signOut();

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SplashScreen()));
              },
              child: Text('Sign Out'),
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey[800]),
            )
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: tabs,
          ),
          elevation: 20,
          titleSpacing: 20,
        ),
        body: TabBarView(
          children: children,
        ),
      ),
    );
  }
}
