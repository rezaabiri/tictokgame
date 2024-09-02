import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funtictac/utilities/splash_screen.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

import 'models/audio_resume.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  const appId = "lgpraohcagmcrisiipgannjajqllnkmrqmrcqggfgftrmlatrralmlksrdjnkelpnsbfeh";
  TapsellPlus.instance.setDebugMode(LogLevel.Debug);
  TapsellPlus.instance.initialize(appId);
  TapsellPlus.instance.setGDPRConsent(true);

  runApp(const MyApp());
  WidgetsBinding.instance.addObserver(Handler());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}
