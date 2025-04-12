import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatelessWidget {
  static const String routeName = '/qr_page';
  QrPage({super.key});

  String qrValue = "1234567890";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR Page"),),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            QrImageView(
              data: qrValue,
              version: QrVersions.auto,
              size: 200.0,
            ),
            Text("QR Value: $qrValue"),
          ],
        ),
      ),
    );
  }
}
