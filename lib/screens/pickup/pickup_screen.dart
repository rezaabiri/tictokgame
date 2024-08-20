import 'package:flutter/material.dart';
import 'package:funtictac/constants.dart';
import 'package:funtictac/widgets/material_button.dart';
import 'package:funtictac/models/player.dart';
import 'package:funtictac/models/responsive_ui.dart';
import 'package:funtictac/screens/game/game_screen.dart';
import 'package:funtictac/screens/pickup/gesture_detector.dart';

class PickUpScreen extends StatefulWidget {
  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  @override
  void initState() {
    Player.pressed = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Choose a side',
              textAlign: TextAlign.center,
              style: kTextStyle.copyWith(fontSize: ResponsiveUI.getFontSize(30.0)),
            ),
            MyGestureDetector(
              onTapFunction: () => setState(() => Player.pressed = Player.X),
              containerColor: Player.pressed == Player.X ? kContainerCardColor : kBackgroundColor,
              text: "X",
            ),
            MyGestureDetector(
              onTapFunction: () => setState(() => Player.pressed = Player.O),
              containerColor: Player.pressed == Player.O ? kContainerCardColor : kBackgroundColor,
              text: "O",
            ),
            MaterialButtonWidget(
              text: 'Start',
              textSize: ResponsiveUI.getFontSize(30.0),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen())),
            )
          ],
        ),
      ),
    );
  }
}
