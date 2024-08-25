import 'package:flutter/material.dart';

class Settings {
  static List<bool> audioValues = [true, true];
  static List<String> playerRoleNames = ['نام شما', 'نام رقیب'];
  static List<String> playerNames = ['بازیکن 1', 'بازیکن 2'];
  static List playerAvatars = [0, 0];
  static List<bool> p1AvatarList = [true, false, false, false];
  static List<bool> p2AvatarList = [true, false, false, false];

  static List<int> scores = [3, 5];
  static List<String> scoreTitles = ['امتیاز برد ', 'امتیاز قرعه کشی '];

  static final TextEditingController controllerP1 = TextEditingController();
  static final TextEditingController controllerP2 = TextEditingController();
  static List<TextEditingController> textControllers = [controllerP1, controllerP2];

  static void getTextFieldValues() {
    controllerP1.text = playerNames[0];
    controllerP2.text = playerNames[1];
  }

  static void updatePlayerNames() {
    playerNames[0] = controllerP1.text;
    playerNames[1] = controllerP2.text;
  }
}
