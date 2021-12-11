//:ưimport 'package:do_an/Supabase/supabase_mange.dart';
import 'package:do_an/pop_menu.dart';
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
          backgroundColor: Colors.blueGrey,
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
                  'user.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            PopupOptionMenu()
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
