import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:funtictac/constants.dart';
import 'package:funtictac/screens/settings/settings_screen.dart';

class MyAlertDialog {
  static AlertStyle alertStyle = AlertStyle(
    backgroundColor: kActiveCardColor,
    titleStyle: const TextStyle(
      fontSize: 25.0,
      fontFamily: 'morvarid',
    ),
    buttonAreaPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
    alertPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  static Future buildAlert(context) {
    return Alert(
      context: context,
      padding: const EdgeInsets.all(0.0),
      title: 'تنظیمات',
      closeIcon: const Icon(Icons.close),
      style: alertStyle,
      content: const SettingsScreen(),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: kBackgroundColor,
          child: const Text('ذخیره', style: TextStyle(fontFamily: 'morvarid', fontWeight: FontWeight.bold, fontSize: 16),),
        ),
      ],
    ).show();
  }
}
