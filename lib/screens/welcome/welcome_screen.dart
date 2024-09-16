import 'dart:developer';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tapsell_plus/NativeAdPayload.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

import '../../constants.dart';
import '../../models/responsive_ui.dart';
import '../../models/settings.dart';
import '../../utilities/audio_player.dart';
import '../game/components/alert_result.dart';
import 'components/alert_dialog.dart';
import 'components/scaffold_body.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    listenForConnectionChanges();
    checkInternetConnection();
    if (Settings.audioValues[1]) AudioPlayer.playMusic();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveUI.getDeviceHeight(context);
    ResponsiveUI.getDeviceWidth(context);
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/bg6.jpg'),
              fit: BoxFit.cover
              )
          ),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                IconButton(
                  color: kTextColor,
                  iconSize: ResponsiveUI.getFontSize(35.0),
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () => MyAlertDialog.buildAlert(context),
                  icon: const Icon(Icons.menu),
                ),
                const SizedBox(width: 20,),
                Text(
                  'نقطه‌باز',
                  textAlign: TextAlign.center,
                  style: kTextStyle.copyWith(
                    fontSize: ResponsiveUI.getFontSize(33.0),
                  ),
                ),

              ],),
              const Expanded(child: MyScaffoldBody()),

            ],
          )),
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
