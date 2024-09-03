import 'dart:developer';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:funtictac/constants.dart';
import 'package:funtictac/widgets/material_button.dart';
import 'package:funtictac/models/player.dart';
import 'package:funtictac/models/responsive_ui.dart';
import 'package:funtictac/screens/game/game_screen.dart';
import 'package:funtictac/screens/pickup/gesture_detector.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

import '../game/components/alert_result.dart';

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
    checkInternetConnection();
    listenForConnectionChanges();
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
  void randomAds() {
    int random = Random.secure().nextInt(2);
    switch(random){
      case 0:
        imageAds();
        break;
      case 1:
        videoAds();
        break;
    }
  }
  Future<void> imageAds() async {
    const zoneId = "66d74b9d4fb52428cc027cef";
    TapsellPlus.instance.requestInterstitialAd(zoneId).then((responseId) {
      TapsellPlus.instance.showInterstitialAd(responseId,
          onOpened: (map) {
          }, onError: (map) {
          }, onClosed: (map) {
          }
      );
    });
  }
  Future<void> videoAds() async {
    const zoneId = "66d74e8607a9f51fdc4acf28";
    TapsellPlus.instance.requestRewardedVideoAd(zoneId).then((responseId) {
      TapsellPlus.instance.showRewardedVideoAd(responseId,
          onOpened: (map) {
            // Ad opened
          }, onError: (map) {
            // Ad had error - map contains `error_message`
          }, onRewarded: (map) {
            // Ad shown completely
          }, onClosed: (map) {
            // Ad closed
          }
      );

    });

  }

  void checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      MyAlert.showAlert(context, 'اینترنت قطع شده است!', '❌', 'وصل کردم', () {
        Navigator.pop(context);
        checkInternetConnection();
      });
    } else {
      randomAds();
    }
  }
  void listenForConnectionChanges() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        MyAlert.showAlert(context, 'اینترنت قطع شده است!', '❌', 'وصل کردم', () {
          Navigator.pop(context);
          checkInternetConnection();
        });
      }else{
        randomAds();
      }
    });
  }
}
