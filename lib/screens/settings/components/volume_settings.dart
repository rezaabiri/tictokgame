import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funtictac/constants.dart';
import 'package:funtictac/models/settings.dart';
import 'package:funtictac/utilities/audio_player.dart';

class VolumeSettings extends StatefulWidget {
  const VolumeSettings({super.key});

  @override
  _VolumeSettingsState createState() => _VolumeSettingsState();
}

class _VolumeSettingsState extends State<VolumeSettings> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.rtl,
      children: [
        const Text('صدای بازی', style: TextStyle(fontSize: 19.0, fontFamily: 'morvarid')),
        const SizedBox(width: 5.0),
        _buildSwitchButtons(0),
        const SizedBox(width: 10.0),
        const Text('آهنگ زمینه', style: TextStyle(fontSize: 19.0, fontFamily: 'morvarid')),
        const SizedBox(width: 5.0),
        _buildSwitchButtons(1),
      ],
    );
  }

  _buildSwitchButtons(int index) {
    return Transform.scale(
      scale: 0.85,
      child: Switch.adaptive(
        activeColor: kBackgroundColor,
        inactiveTrackColor: kContainerColor,
        inactiveThumbColor: kTextColor,
        value: Settings.audioValues[index],
        onChanged: (v) => setState(() {
          Settings.audioValues[index] = v;
          if (index == 1) _musicHandler();
        }),
      ),
    );
  }

  void _musicHandler() {
    if (Settings.audioValues[1]) {
      AudioPlayer.playMusic();
    } else if (!Settings.audioValues[1]) {
      AudioPlayer.toggleLoop();
      AudioPlayer.stopMusic();
    }
  }
}
