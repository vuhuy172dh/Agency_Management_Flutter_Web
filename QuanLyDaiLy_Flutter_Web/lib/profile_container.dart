import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildProfile(),
    );
  }

  Widget buildProfile() {
    return FutureBuilder(
      future: supabaseManager.readDataProfile(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final doc = snapshot.data as PostgrestResponse?;
        if (doc == null) {
          return const SizedBox();
        }

        final datasets = this.datasets;
        datasets['Supabase Query'] = doc.data as List<dynamic>? ?? <dynamic>[];
        datasets['Supabase Query'] as List<dynamic>;
        final temp = datasets['Supabase Query'][0] as Map<String, dynamic>;
        final name = temp['name'];

        return Builder(
          builder: (context) {
            return Container(
              child: Row(
                children: [
                  Text('TÊN NGƯỜI DÙNG:'),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(name)
                ],
              ),
            );
          },
        );
      },
    );
  }
}
