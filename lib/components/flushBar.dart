import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class NotificationUtils {
  static void showNotification(BuildContext context, String message) {
    _buildFlushbar(message).show(context);
  }

  static Flushbar _buildFlushbar(String message) {
    return Flushbar(
      message: message,
      duration: Duration(milliseconds: 900),
    );
  }
}
