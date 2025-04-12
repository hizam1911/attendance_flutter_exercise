import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class Faq extends StatelessWidget {
  static const String routeName = '/faq';
  Faq({super.key});
  String baseURL = 'https://api.whatsapp.com/send?phone=601126636263&text=Hello';

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(baseURL))) {
      throw Exception('Could not launch $baseURL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
        actions: [
          IconButton(
              onPressed: _launchUrl,
              icon: Icon(Icons.message),
          ),
        ],
      ),
      body: SfPdfViewer.network('https://www.mohr.gov.my/pdf/FAQ%202024.pdf'),
    );
  }
}
