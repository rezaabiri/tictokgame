import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:funtictac/constants.dart';

class MyAlert {
  static TextStyle textStyle = const TextStyle(
    fontSize: 23.0,
    fontFamily: 'morvarid',
  );
  static AlertStyle alertStyle = AlertStyle(
    backgroundColor: kActiveCardColor,
    titleStyle: textStyle,
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  static Future showAlert(BuildContext context, String msg, String emoji, String btnTitle, Function() nextRoundFunc) {
    return Alert(
        context: context,
        padding: const EdgeInsets.all(0),
        onWillPopActive: true,
        title: msg,
        style: alertStyle,
        closeIcon: const Icon(Icons.close),
        closeFunction: nextRoundFunc,
        content: Center(child: Text(emoji, style: const TextStyle(fontSize: 50.0, fontFamily: 'morvarid'), textDirection: TextDirection.rtl,)),
        buttons: [
          DialogButton(
            onPressed: nextRoundFunc,
            color: kBackgroundColor,
            child: Text(btnTitle, style: textStyle, textDirection: TextDirection.rtl,),
          ),
        ]).show();
  }
}
