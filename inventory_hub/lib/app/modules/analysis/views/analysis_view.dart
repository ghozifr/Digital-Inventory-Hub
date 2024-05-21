import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/analysis_controller.dart';

class AnalysisView extends GetView<AnalysisController> {
  const AnalysisView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnalysisView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AnalysisView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
