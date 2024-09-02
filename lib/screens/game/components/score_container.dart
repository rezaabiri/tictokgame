import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funtictac/constants.dart';

class MyScoreContainer extends StatelessWidget {
  final String text;
  const MyScoreContainer(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
/*
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: kContainerColor,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: kTextStyle.copyWith(
          fontSize: 30.0,
        ),
      ),
    );
*/
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/images/score_con.png', width: 50,),
          Text(
            text,
            textAlign: TextAlign.center,
            style: kTextStyle.copyWith(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}
