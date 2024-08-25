import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funtictac/constants.dart';
import 'package:funtictac/models/player.dart';
import 'package:funtictac/screens/welcome/welcome_screen.dart';
import 'package:funtictac/widgets/material_button.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:funtictac/models/responsive_ui.dart';

class MyResultContainer extends StatelessWidget {
  final Player player;
  final Function() onPressed;
  const MyResultContainer({super.key, required this.player, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double containerHeight = ResponsiveUI.getHeight(0.44);
    return DelayedDisplay(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              constraints: BoxConstraints.tightFor(
                width: ResponsiveUI.getWidth(context, 40.0),
                height: containerHeight,
              ),
              decoration: BoxDecoration(
                color: kContainerColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Player.winner ? 'assets/images/win.png' : 'assets/images/draw.png', height: containerHeight * 0.63),
                  Text(
                    Player.getResultText(),
                    style: kTextStyle.copyWith(fontSize: ResponsiveUI.getFontSize(40.0)),
                  )
                ],
              )),
          const SizedBox(height: 20.0),
          MaterialButtonWidget(
            text: 'بازی دوباره',
            textSize: ResponsiveUI.getFontSize(28.0),
            onPressed: onPressed,
          ),
          MaterialButtonWidget(
            text: 'خانه',
            textSize: ResponsiveUI.getFontSize(23.0),
            onPressed: () {
              player.resetData();
              Player.resetData1();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen()), (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
