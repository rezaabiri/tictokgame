import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictokgame/utilities/splash_screen.dart';

import 'models/audio_resume.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
