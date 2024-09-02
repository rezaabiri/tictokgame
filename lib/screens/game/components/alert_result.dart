import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:funtictac/constants.dart';

class MyAlert {
  static TextStyle textStyle = const TextStyle(
      fontSize: 23.0, fontFamily: 'morvarid', fontWeight: FontWeight.bold);

  static Future showAlert(BuildContext context, String msg, String emoji,
      String btnTitle, Function() nextRoundFunc) {
    return Alert(
      context: context,
      padding: const EdgeInsets.all(0),
      onWillPopActive: true,
      style: AlertStyle(
        titleStyle: textStyle,
        backgroundColor: Colors.transparent, // تنظیم بک‌گراند ترنسپرنت
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      closeFunction: nextRoundFunc,
      closeIcon: const SizedBox(),
      content: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 250.0,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/alert_bg.png'),
            // مسیر تصویر خود را اینجا قرار دهید
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                msg,
                style: const TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'morvarid',
                    fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                emoji,
                style: const TextStyle(fontSize: 50.0, fontFamily: 'morvarid'),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(
                height: 16,
              ),
              DialogButton(
                width: 200,
                onPressed: nextRoundFunc,
                color: kBackgroundColor,
                child: Text(
                  btnTitle,
                  style: const TextStyle(fontFamily: 'morvarid', fontSize: 23),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ),
      ),
      buttons: [],
    ).show();
  }
}
