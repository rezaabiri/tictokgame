import 'package:flutter/material.dart';
import 'package:funtictac/constants.dart';
import 'package:funtictac/widgets/material_button.dart';
import 'package:funtictac/models/player.dart';
import 'package:funtictac/models/responsive_ui.dart';
import 'package:funtictac/screens/game/game_screen.dart';
import 'package:funtictac/screens/pickup/gesture_detector.dart';

class PickUpScreen extends StatefulWidget {
  const PickUpScreen({super.key});

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
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/bg6.jpg'),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40,),
            Text(
              'یک مهره انتخاب کنید',
              textAlign: TextAlign.center,
              style: kTextStyle.copyWith(fontSize: ResponsiveUI.getFontSize(30.0)),
            ),
            MyGestureDetector(
              onTapFunction: () => setState(() => Player.pressed = Player.X),
              containerColor: Player.pressed == Player.X ? kContainerCardColor : Colors.white.withOpacity(0.5),
              text: "X",
            ),
            MyGestureDetector(
              onTapFunction: () => setState(() => Player.pressed = Player.O),
              containerColor: Player.pressed == Player.O ? kContainerCardColor : Colors.white.withOpacity(0.5),
              text: "O",
            ),
            MaterialButtonWidget(
              text: 'شروع بازی',
              textSize: ResponsiveUI.getFontSize(30.0),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen())),
            )
          ],
        ),
      ),
    );
  }
}
