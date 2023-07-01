import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:tf11c_0031_codiego4_qr/models/qr_model.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<ChartData> data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    //ChartData(titleX: "Pedro", valueY: 30)
    CollectionReference qrCollection =
        FirebaseFirestore.instance.collection("qr_collection");
    QuerySnapshot collection = await qrCollection.get();
    List<QueryDocumentSnapshot> docs = collection.docs;
    List<QrModel> qrList = [];
    qrList = docs
        .map((e) => QrModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();

    qrList.forEach((element) {
      data.add(
        ChartData(titleX: element.description, valueY: element.price),
      );
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 100,
                interval: 20,
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
              ),
              series: <ChartSeries<ChartData, String>>[
                ColumnSeries<ChartData, String>(
                  dataSource: data,
                  xValueMapper: (ChartData temp, index) => temp.titleX,
                  yValueMapper: (ChartData temp, index) => temp.valueY,
                  name: "Gold",
                  color: Color.fromRGBO(8, 142, 255, 1),
                ),
              ],
            ),
            SfCircularChart(
              tooltipBehavior: TooltipBehavior(
                enable: true,
              ),
              legend: Legend(
                isVisible: true,
                title: LegendTitle(text: "Data general"),
              ),
              series: <CircularSeries>[
                PieSeries<ChartData, String>(
                  dataSource: data,
                  xValueMapper: (ChartData data, _) => data.titleX,
                  yValueMapper: (ChartData data, _) => data.valueY,
                ),
              ],
            ),
            SfCircularChart(
              tooltipBehavior: TooltipBehavior(
                enable: true,
              ),
              legend: Legend(
                isVisible: true,
                title: LegendTitle(text: "Data general"),
              ),
              series: <CircularSeries>[
                DoughnutSeries<ChartData, String>(
                  dataSource: data,
                  xValueMapper: (ChartData data, _) => data.titleX,
                  yValueMapper: (ChartData data, _) => data.valueY,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  double valueY;
  String titleX;
  ChartData({required this.titleX, required this.valueY});
}
