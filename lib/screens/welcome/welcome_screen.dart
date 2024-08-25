import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/responsive_ui.dart';
import '../../models/settings.dart';
import '../../utilities/audio_player.dart';
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
    if (Settings.audioValues[1]) AudioPlayer.playMusic();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveUI.getDeviceHeight(context);
    ResponsiveUI.getDeviceWidth(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: const MyScaffoldBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      title: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          'فان تیک تاک',
          textAlign: TextAlign.center,
          style: kTextStyle.copyWith(
            fontSize: ResponsiveUI.getFontSize(33.0),
          ),
        ),
      ),
      leading: IconButton(
        color: kTextColor,
        iconSize: ResponsiveUI.getFontSize(35.0),
        padding: const EdgeInsets.all(0.0),
        onPressed: () => MyAlertDialog.buildAlert(context),
        icon: const Icon(Icons.menu),
      ),
    );
  }
}
