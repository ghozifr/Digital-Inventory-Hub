import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../controllers/analysis_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//check update
// check for main
class AnalysisView extends StatelessWidget {
  final AnalysisController _controller = Get.put(AnalysisController());

 @override
Widget build(BuildContext context) {
  final Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;
  final String userUid = args['userUid'];
  final String productUid = args['productUid'];

  // Print statements to verify arguments
  print("User UID: $userUid");
  print("Product UID: $productUid");

  return Scaffold(
    appBar: AppBar(
      title: const Text('STATISTICS', style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold, fontSize: 20),),
      centerTitle: true,
      backgroundColor: const Color(0xFF2F2D4E), // Set your desired AppBar color
    ),
    backgroundColor: const Color(0xFF2F2D4E), // Set your desired Scaffold background color
    body: Container(
      color: const Color(0xFFFFFFFF), // Set your desired background color for ListView
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _controller.getChartData(userUid, productUid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No data available'));
              }

              List<charts.Series<Map<String, dynamic>, String>> series = [
                charts.Series<Map<String, dynamic>, String>(
                  id: 'Sales',
                  domainFn: (Map<String, dynamic> data, _) => data['updatedAt'].toString(),
                  measureFn: (Map<String, dynamic> data, _) => data['qty'],
                  data: snapshot.data!.docs.map((doc) => doc.data()).toList(),
                )
              ];

              return SizedBox(
                height: 400,
                child: charts.BarChart(
                  series,
                  animate: true,
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
}
