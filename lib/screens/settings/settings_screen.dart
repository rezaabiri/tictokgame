import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funtictac/screens/settings/components/score_settings.dart';
import 'package:funtictac/screens/settings/components/toggle_buttons.dart';
import 'package:funtictac/screens/settings/components/volume_settings.dart';
import 'package:funtictac/screens/settings/components/player_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          const Divider(thickness: 3.0, height: 0.0),
          VolumeSettings(),
          const Divider(thickness: 3.0, height: 0.0),
          const SizedBox(height: 10.0),
          const PlayerSettings(playerIndex: 0),
          const SizedBox(height: 7.0),
          _buildAvatarSettings(0),
          const Divider(thickness: 3.0, height: 10.0),
          const SizedBox(height: 5.0),
          const PlayerSettings(playerIndex: 1),
          const SizedBox(height: 7.0),
          _buildAvatarSettings(1),
          const Divider(thickness: 3.0, height: 10.0),
          const ScoreSettings(0),
          const ScoreSettings(1),
        ],
      ),
    );
  }

  Row _buildAvatarSettings(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 50.0, height: 10.0),
        const Text('پروفایل', style: TextStyle(fontSize: 19.0, fontFamily: 'morvarid')),
        const SizedBox(width: 10.0),
        MyToggleButtons(index),
      ],
    );
  }
}
