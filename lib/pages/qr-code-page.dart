import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sendeaze/constants/color-constants.dart';
import 'package:sendeaze/pages/scan-details-page.dart';

dynamic base64Images;

class QRCodeScreen extends StatefulWidget {
  static String routeName = "/screens/home.qr-code";
  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: AppColors.WHITE),
        title: Text(
          "QR Code".toUpperCase(),
          style: TextStyle(color: AppColors.WHITE, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderLength: 20,
                  borderRadius: 10,
                  borderWidth: 10,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8,
                  overlayColor: Colors.black87),
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController qrcontroller) {
    this.controller = qrcontroller;
    controller!.scannedDataStream.listen((scannedData) async {
      controller!.pauseCamera();
      controller!.dispose();
      print("Scanned data ${scannedData.code}");
      Get.offAndToNamed(ScanDetails.routeName, arguments: scannedData.code);
//      Navigator.of(context).pop(scannedData.code);
    }, onError: (error) {
      print("QR Error: $error");
    });
  }
}
