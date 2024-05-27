//fix this code. make sure it's address correct current useruid and productuid.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../controllers/analysis_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnalysisView extends StatefulWidget {
  @override
  _AnalysisViewState createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  final AnalysisController _controller = Get.put(AnalysisController());
  User? currentUser;
  String? userUid;
  String? productUid;

  @override
  void initState() {
    super.initState();
    _initializeUserAndProduct();
  }

  Future<void> _initializeUserAndProduct() async {
    // Get the current user from Firebase Auth
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userUid = currentUser!.uid;
      // Fetch the productUid based on userUid or some other logic
      productUid = await _getProductUidForUser(userUid!);

      setState(() {});
    }
  }

  Future<String?> _getProductUidForUser(String userUid) async {
    // Replace this logic with how you retrieve the productUid for the user
    // For example, querying Firestore to get the productUid for the current user
    var userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userUid).get();
    if (userDoc.exists) {
      return userDoc.data()?['currentProductUid'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analysis')),
      body: userUid == null || productUid == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _controller.getChartData(userUid!, productUid!),
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
                        domainFn: (Map<String, dynamic> data, _) =>
                            data['updatedAt'].toString(),
                        measureFn: (Map<String, dynamic> data, _) =>
                            data['qty'],
                        data: snapshot.data!.docs
                            .map((doc) => doc.data())
                            .toList(),
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
