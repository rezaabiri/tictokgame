import 'package:flutter/material.dart';

import '../constants.dart';

class MaterialButtonWidget extends StatelessWidget {
  final String text;
  final double textSize;
  final textPadding;
  final Function() onPressed;

  const MaterialButtonWidget({super.key, required this.text, required this.textSize, this.textPadding, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/btn3.png'),
              fit: BoxFit.contain
            )
        ),
        child: SizedBox(
          width: 400,
          height: 100,
          child: MaterialButton(
            padding: EdgeInsets.all(textPadding ?? 8.0),
            textColor: kTextColor,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            disabledColor: Colors.transparent,
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(fontFamily: 'morvarid', fontSize: textSize),
            ),
          ),
        ),
      ),
    );
  }
}
