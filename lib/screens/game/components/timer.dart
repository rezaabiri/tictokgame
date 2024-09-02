import 'package:flutter/material.dart';

class MyCountDownTimer extends StatelessWidget {
  final int seconds;
  final int maxSeconds;

  const MyCountDownTimer({super.key, required this.seconds, required this.maxSeconds});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: 60.0,
        height: 60.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/progress.png', width: 100, height: 100,),
            Positioned(
              top: -2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  backgroundColor: Colors.blueAccent,
                  strokeWidth: 5,
                ),
              ),
            ),
            Center(child: Text('$seconds', style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'morvarid'),)),
          ],
        ),
      ),
    );
  }
}
