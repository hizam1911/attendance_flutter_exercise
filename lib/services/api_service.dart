import 'dart:convert';

import 'package:flutter_attendance/models/clinic.dart';
import 'package:http/http.dart' as http;

import '../models/checkin.dart';

class ApiService {
  String baseURL = 'https://agmoacademy.com/flutter_jan2025';

  Future<QRModel> fetchQrCode() async {
    QRModel qr = QRModel(qrValue: "", qrValidDate: "");

    try {
      final myResponse = await http.get(
        Uri.parse('$baseURL/checkin_qr.php'),
      );

      if (myResponse.statusCode == 200) {
        final myData = json.decode(myResponse.body);
        qr = QRModel.fromJson(myData);
      } else {
        print('api issue');
      }
    } catch (e) {
      print("Error: $e");
      return qr;
    }

    return qr;
  }

  Future<List<ClinicModel>> fetchClinicData() async {
    List<ClinicModel> clinics = [];

    try {
      final myResponse = await http.get(
        Uri.parse('$baseURL/panel_clinic_list.php'),
      );

      if (myResponse.statusCode == 200) {
        final myData = json.decode(myResponse.body);
        List<dynamic> dataList = myData['panel_clinics_data'];
        for (var item in dataList) {
          ClinicModel clinic = ClinicModel.fromJson(item);
          clinics.add(clinic);
        }
      } else {
        print('api issue');
      }
    } catch (e) {
      print("Error: $e");
      return clinics;
    }

    return clinics;
  }

}