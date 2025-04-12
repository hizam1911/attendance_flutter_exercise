import 'package:flutter/material.dart';
import 'package:flutter_attendance/models/checkin.dart';
import 'package:flutter_attendance/services/api_service.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CheckIn extends StatefulWidget {
  static const String routeName = '/check_in';
  const CheckIn({super.key});

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  QRModel qr = QRModel(qrValue: "", qrValidDate: "");
  String qrCodeValue = '';
  String qrValidDate = '';

  Future<void> fetchQrCode() async {
    qr = await ApiService().fetchQrCode();
    setState(() {
      qrCodeValue = qr.qrValue;
      qrValidDate = qr.qrValidDate;
    });
  }

  @override
  void initState() {
    fetchQrCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR Page"),),
      body: RefreshIndicator(
        onRefresh: fetchQrCode,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  QrImageView(
                    data: qrCodeValue,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  if(qrCodeValue.isNotEmpty)
                    Text("QR Value: $qrCodeValue \nValid Till: $qrValidDate"),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
