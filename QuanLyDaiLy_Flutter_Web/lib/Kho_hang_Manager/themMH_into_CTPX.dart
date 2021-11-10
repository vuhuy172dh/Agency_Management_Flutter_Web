import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class ThemMHCTPX extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController maMH;
  final TextEditingController soluong;
  const ThemMHCTPX(
      {Key? key,
      required this.formKey,
      required this.maMH,
      required this.soluong})
      : super(key: key);

  @override
  _ThemMHCTPXState createState() => _ThemMHCTPXState();
}

class _ThemMHCTPXState extends State<ThemMHCTPX> {
  SupabaseManager supabaseManager = SupabaseManager();
  final datasets = <String, dynamic>{};
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        alignment: Alignment.center,
        child: Form(
          key: widget.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.blueGrey),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      width: 200,
                      child: Text('MÃ MẶT HÀNG',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: BuildMaMHFormField())),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.blueGrey),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      width: 200,
                      child: Text('SỐ LƯỢNG',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Chưa nhập SỐ LƯỢNG";
                          } else {
                            return null;
                          }
                        },
                        initialValue: widget.soluong.text,
                        onChanged: (value) {
                          widget.soluong.text = value;
                        },
                        cursorColor: Colors.blueGrey[800],
                        style: TextStyle(color: Colors.blueGrey[800]),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BuildMaMHFormField() {
    return FutureBuilder(
      future: supabaseManager.readDataMaMH(),
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

        List<dynamic> data = datasets['Supabase Query'] as List<dynamic>;
        List<String> mamathangdata = [];
        for (var i in data) {
          final temp = (i as Map<String, dynamic>);
          mamathangdata.add(temp['mamathang'].toString());
        }
        return Builder(builder: (context) {
          return TextFormField(
            style: TextStyle(color: Colors.blueGrey[800]),
            cursorColor: Colors.blueGrey[800],
            controller: widget.maMH,
            validator: (value) {
              if (value!.isEmpty) {
                return "Bạn chưa nhập MÃ MẶT HÀNG";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: widget.maMH.text,
              border: InputBorder.none,
              suffixIcon: PopupMenuButton<String>(
                color: Colors.blueGrey[100],
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blueGrey,
                ),
                onSelected: (value) {
                  widget.maMH.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return mamathangdata.map<PopupMenuItem<String>>((e) {
                    return PopupMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(color: Colors.blueGrey[800]),
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          );
        });
      },
    );
  }
}
