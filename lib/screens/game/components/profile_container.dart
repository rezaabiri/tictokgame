import 'package:flutter/material.dart';
import 'package:funtictac/constants.dart';
import 'package:funtictac/models/player.dart';
import 'package:funtictac/models/settings.dart';
import 'package:funtictac/screens/game/components/score_container.dart';

class MyProfileContainer extends StatelessWidget {
  final String symbol;
  final Color cardColor;
  final int playerIndex;

  const MyProfileContainer({super.key, required this.playerIndex, required this.symbol, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/profile_con.png')
            ),
            borderRadius: BorderRadius.circular(5.0),
            border: cardColor == kActiveCardColor || cardColor == kWinnerCardColor ? Border.all(color: Colors.white, width: 4) : null,
          ),
          constraints: const BoxConstraints.tightFor(
            width: 100.0,
            height: 145.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Settings.playerNames[playerIndex], style: kTextStyle.copyWith(fontSize: 15.0)),
              ),
              Image.asset(
                'assets/images/avatar-${Settings.playerAvatars[playerIndex]}.png',
                width: 45.0,
              ),
              Text(
                symbol,
                style: kTextStyle.copyWith(
                  color: symbol == 'X' ? kXColor : kOColor,
                  fontFamily: symbol == 'X' ? 'Carter' : 'Paytone',
                  fontSize: 30.0,
                ),
              ),
            ],
          ),
        ),
        MyScoreContainer('${Player.playerScores[playerIndex]}'),
      ],
    );
  }
}
