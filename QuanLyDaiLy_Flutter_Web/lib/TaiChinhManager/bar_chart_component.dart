import 'package:do_an/Supabase/supabase_mange.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class BarChartComponent extends StatefulWidget {
  const BarChartComponent({Key? key}) : super(key: key);

  @override
  _BarChartComponentState createState() => _BarChartComponentState();
}

class _BarChartComponentState extends State<BarChartComponent> {
  late List<tienxuatData> _chartData = [];
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
      future: supabaseManager.readDataThongKeTien(2021),
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
          _chartData.add(tienxuatData(temp['_thang'], temp['_tien']));
        }
        return Builder(
          builder: (context) {
            return Container(
              child: SfCartesianChart(
                title: ChartTitle(
                    text: 'DOANH SỐ XUẤT HÀNG THEO THÁNG TRONG NĂM',
                    textStyle: TextStyle(fontWeight: FontWeight.bold)),
                legend: Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries>[
                  BarSeries<tienxuatData, String>(
                      name: 'Tổng Tiền Xuất',
                      dataSource: _chartData,
                      xValueMapper: (tienxuatData tx, _) => tx.thang.toString(),
                      yValueMapper: (tienxuatData tx, _) => tx.tien,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      enableTooltip: true)
                ],
                primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Tháng')),
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

class tienxuatData {
  tienxuatData(this.thang, this.tien);
  final int thang;
  final int tien;
}
