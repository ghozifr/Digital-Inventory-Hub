import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../controllers/analysis_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      appBar: AppBar(title: const Text('Analysis')),
      body: ListView(
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
          );
  }
}
