import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funtictac/utilities/splash_screen.dart';
import 'package:tapsell_plus/tapsell_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/audio_resume.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      title: "نقطه‌باز",
      theme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}
