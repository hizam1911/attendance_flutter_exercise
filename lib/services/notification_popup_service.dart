import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';

class NotificationPopupService {
  void showInfoPopup(BuildContext context, String title, String desc) {
    ElegantNotification.info(
      title:  Text(title),
      description:  Text(desc),
      icon: Icon(
        Icons.inbox,
        color: Colors.blue,
      ),
      width: MediaQuery.sizeOf(context).width - 40,
      toastDuration: Duration(seconds: 3),
    ).show(context);
  }

  static Future<bool?> showDialogPopup(BuildContext context, String title, String content) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),

        actions: [
          OutlinedButton(
              onPressed: () {
                Navigator.pop(_, false);
              },
              child: Text("Cancel")
          ),
          FilledButton(
              onPressed: () {
                Navigator.pop(_, true);
              },
              child: Text("Confirm")
          ),
        ],
      );
        }
    );
  }
}