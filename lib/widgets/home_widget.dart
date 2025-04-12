import 'package:flutter/material.dart';

import '../utils/dialog_utils.dart';

//notes: put each widget in one class only.. exp: HomeWidget in home_widget.dart and DashboardWidget in dashboard_widget.dart
//notes: if the widget is not reusable (called only once), then just put it inside the page, no need to put inside /widgets folder
//notes: _WidgetName is private while WidgetName is public..

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Column(
        children: [
          // logo
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            child: Image.asset('assets/images/logo-agmo.png', scale: 2,),
          ),
          const SizedBox(height: 20,),

          // btn Check In
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
            onPressed: () {
              Navigator.pushNamed(context, '/check_in');
            },
            child: Text("Check In"),
          ),
          const SizedBox(height: 20,),

          // btn Panel Clinic
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
            onPressed: () {
              Navigator.pushNamed(context, '/panel_clinic');
            },
            child: Text("Panel Clinic"),
          ),
          const SizedBox(height: 20,),

          // btn PDF View
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
            onPressed: () {
              Navigator.pushNamed(context, '/faq');
            },
            child: Text("PDF View"),
          ),
          const SizedBox(height: 20,),

          // btn Test
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
            onPressed: () {
              DialogUtils.showDismissDialog(context: context, title: "Alert Dialog Title", content: "This is a demo alert dialog.");
            },
            child: Text("Popup Test"),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
