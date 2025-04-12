import 'package:flutter/material.dart';
import 'package:flutter_attendance/models/clinic.dart';
import 'package:flutter_attendance/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class PanelClinic extends StatefulWidget {
  static const String routeName = '/panel_clinic';
  const PanelClinic({super.key});

  @override
  State<PanelClinic> createState() => _PanelClinicState();
}

class _PanelClinicState extends State<PanelClinic> {
  List<ClinicModel> clinicData = [];
  bool isLoading = true;

  @override
  void initState() {
    fetchClinicData();
    super.initState();
  }

  Future<void> fetchClinicData() async {
    clinicData = await ApiService().fetchClinicData();
    setState(() {});
  }

  Future<void> launchURL(String myUrl) async {
    final Uri myUri = Uri.parse(myUrl);

    if (await canLaunchUrl(myUri)) {
      print("can launch $myUrl");
      await launchUrl(myUri);
    } else {
      throw "Could not launch the $myUrl";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Panel Clinic"),),
      body: RefreshIndicator(
        onRefresh: fetchClinicData,
        child: ListView.builder(
            itemCount: clinicData.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(clinicData[index].clinicThumbnail),
                title: Text(clinicData[index].clinicName),
                subtitle: Text(clinicData[index].address),
                trailing: IconButton(
                    onPressed: () {
                      print(clinicData[index].googleMap);
                      launchURL(clinicData[index].googleMap);
                    },
                    icon: Icon(Icons.map)
                ),
              );
            }
        ),
      ),
    );
  }
}
