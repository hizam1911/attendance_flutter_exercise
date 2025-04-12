import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static Future<T?> showDismissDialog<T>({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return showDialog<T?>(
        context: context,
        barrierDismissible: false, // Prevents dismissing by tapping outside
        builder: (_)
        {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(content),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        });
  }

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