import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/qr_scan_controller.dart';

class QrScanView extends GetView<QrScanController> {
  const QrScanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QrScanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'QrScanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
