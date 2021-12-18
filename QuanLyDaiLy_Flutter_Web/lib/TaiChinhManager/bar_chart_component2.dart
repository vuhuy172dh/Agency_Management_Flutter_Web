import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class BarChartComponent2 extends StatefulWidget {
  const BarChartComponent2({Key? key}) : super(key: key);

  @override
  _BarChartComponent2State createState() => _BarChartComponent2State();
}

class _BarChartComponent2State extends State<BarChartComponent2> {
  late List<tiennoData> _chartData = [];
  late TooltipBehavior _tooltipBehavior;
  SupabaseManager supabaseManager = SupabaseManager();

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buidBarChart();
  }

  Widget buidBarChart() {
    return FutureBuilder(
      future: supabaseManager.readDataDanhSachTienNoDaiLy(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final doc = snapshot.data as PostgrestResponse?;
        if (doc == null) {
          return const SizedBox();
        }

        final datasets = <String, dynamic>{};
        datasets['Supabase Query'] = doc.data as List<dynamic>? ?? <dynamic>[];
        List<dynamic> data = datasets['Supabase Query'] as List<dynamic>;

        for (var i in data) {
          final temp = (i as Map<String, dynamic>);
          _chartData.add(tiennoData(temp['tendaily'], temp['tienno']));
        }
        return Builder(
          builder: (context) {
            return Container(
              child: SfCartesianChart(
                title: ChartTitle(
                    text: 'TIỀN NỢ HIỆN TẠI CỦA CÁC ĐẠI LÝ',
                    textStyle: TextStyle(fontWeight: FontWeight.bold)),
                legend: Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries>[
                  BarSeries<tiennoData, String>(
                      name: 'Tiền Nợ',
                      dataSource: _chartData,
                      xValueMapper: (tiennoData tx, _) => tx.tendl,
                      yValueMapper: (tiennoData tx, _) => tx.tn,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      enableTooltip: true)
                ],
                primaryXAxis:
                    CategoryAxis(title: AxisTitle(text: 'Tên Đại Lý')),
                primaryYAxis: NumericAxis(
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    numberFormat: NumberFormat.simpleCurrency(
                        decimalDigits: 0, locale: 'vi_VN'),
                    title: AxisTitle(text: 'Tiền theo đơn vị Việt Nam đồng')),
              ),
            );
          },
        );
      },
    );
  }
}

class tiennoData {
  tiennoData(this.tendl, this.tn);
  final String tendl;
  final int tn;
}
