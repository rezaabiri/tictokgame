import 'dart:math';

import 'package:blurbox/blurbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funtictac/constants.dart';
import 'package:funtictac/models/player.dart';
import 'package:funtictac/screens/welcome/welcome_screen.dart';
import 'package:funtictac/widgets/material_button.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:funtictac/models/responsive_ui.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

class MyResultContainer extends StatelessWidget {
  final Player player;
  final Function() onPressed;

  const MyResultContainer(
      {super.key, required this.player, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    randomAds();
    double containerHeight = ResponsiveUI.getHeight(0.23);
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
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      Player.winner
                          ? 'assets/images/win.png'
                          : 'assets/images/draw.png',
                      height: containerHeight * 0.53),
                  Text(
                    Player.getResultText(),
                    style: kTextStyle.copyWith(
                        fontSize: ResponsiveUI.getFontSize(40.0)),
                  )
                ],
              )).blurry(
            blur: 5,
            color: Colors.black12.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          ),
          const SizedBox(height: 20.0),
          MaterialButtonWidget(
            text: 'دوباره بازی میکنم',
            textSize: ResponsiveUI.getFontSize(28.0),
            onPressed: onPressed,
          ),
          MaterialButtonWidget(
            text: 'برگشت به خانه',
            textSize: ResponsiveUI.getFontSize(23.0),
            onPressed: () {
              player.resetData();
              Player.resetData1();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }

  void randomAds() {
    int random = Random.secure().nextInt(2);
    switch (random) {
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
          onOpened: (map) {}, onError: (map) {}, onClosed: (map) {});
    });
  }

  Future<void> videoAds() async {
    const zoneId = "66d74e8607a9f51fdc4acf28";
    TapsellPlus.instance.requestRewardedVideoAd(zoneId).then((responseId) {
      TapsellPlus.instance.showRewardedVideoAd(responseId, onOpened: (map) {
        // Ad opened
      }, onError: (map) {
        // Ad had error - map contains `error_message`
      }, onRewarded: (map) {
        // Ad shown completely
      }, onClosed: (map) {
        // Ad closed
      });
    });
  }
}
