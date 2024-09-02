import 'dart:async';
import 'package:blurbox/blurbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funtictac/constants.dart';
import 'package:funtictac/models/settings.dart';
import 'package:funtictac/screens/game/components/alert_result.dart';
import 'package:funtictac/screens/game/components/profile_container.dart';
import 'package:funtictac/screens/game/components/result_container.dart';
import 'package:funtictac/screens/game/components/card_gesture_detector.dart';
import 'package:funtictac/models/player.dart';
import 'package:funtictac/models/responsive_ui.dart';
import 'package:funtictac/screens/game/components/timer.dart';
import 'package:funtictac/screens/game/components/score_container.dart';
import 'package:funtictac/utilities/audio_player.dart';
import 'package:funtictac/screens/game/components/text_button.dart';

Player player = Player();

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    Player.resetStaticData();
    Player.resetData1();
    player.getPlayerSides();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  static const maxSeconds = 15;
  int seconds = maxSeconds;
  int pauseSeconds = 0;
  late Timer? timer;

  void resetTimer() => setState(() => seconds = maxSeconds);

  void stopTimer() => setState(() => timer!.cancel());

  void pauseTimer() => setState(() => pauseSeconds = seconds);

  void resumeTimer() => setState(() => seconds = pauseSeconds);

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0 && seconds < 16) {
        setState(() => seconds--);
      } else if (seconds == 0) {
        Player.player1 = !Player.player1;
        Player.changeProfileCardColor();
        resetTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg6.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                  visible: !Player.completed,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            pauseTimer();
                            stopTimer();
                            MyAlert.showAlert(context, 'بازی متوقف شد!', '⏸', 'ادامه بازی', () {
                              Navigator.pop(context);
                              resumeTimer();
                              startTimer();
                            });
                          },
                            child: Image.asset('assets/images/stop.png', width: 50,)
                        ),
                        InkWell(
                          onTap: () {
                            resetTimer();
                            Player.resetStaticData();
                            Player.updatePlayer1();
                          },
                            child: Image.asset('assets/images/renew.png', width: 50,)
                        ),

                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MyProfileContainer(playerIndex: 0, symbol: Player.p1, cardColor: Player.cardColorP1),
                  const SizedBox(width: 15.0),
                  Column(
                    children: [
                      Visibility(
                        visible: !Player.completed,
                        child: MyCountDownTimer(seconds: seconds, maxSeconds: maxSeconds),
                      ),
                      const SizedBox(height: 40.0),
                      Text('D', style: kTextStyle.copyWith(fontSize: 30.0, color: Colors.blue)),
                      MyScoreContainer('${Player.drawScore}'),
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  MyProfileContainer(playerIndex: 1, symbol: Player.p2, cardColor: Player.cardColorP2),
                ],
              ),
              Player.completed ? _buildResultContainer() : Expanded(child: _buildGameContainer(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameContainer(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.tightFor(
          width: ResponsiveUI.getWidth(context, 30.0),
          height: ResponsiveUI.getWidth(context, 30.0),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Wrap(children: _buildCardButtons()),
      ).blurry(
        blur: 10,
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      ),
    );
  }

  MyResultContainer _buildResultContainer() {
    return MyResultContainer(
      player: player,
      onPressed: () {
        setState(() {
          resetTimer();
          startTimer();
          Player.resetStaticData();
          Player.resetData1();
          Player.changeProfileCardColor();
        });
      },
    );
  }

  List<CardGestureDetector> _buildCardButtons() {
    List<CardGestureDetector> buttons = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        buttons.add(
          CardGestureDetector(
            onTapFunction: () => showPlayerSide(i, j),
            boxSide: Player.matrix[i][j],
            cardColor: Player.cardColors[i][j],
          ),
        );
      }
    }
    return buttons;
  }

  void showPlayerSide(int x, int y) {
    setState(() {
      if (Player.matrix[x][y] == '' && !Player.finished) {
        player.updateMatrix(x, y);
        if (Settings.audioValues[0]) AudioPlayer.playSound(Player.side);
        if (player.checkWinner(x, y)) {
          winnerLogic();
        } else if (Player.count == 9) {
          drawLogic();
        } else {
          Player.changeProfileCardColor();
          resetTimer();
        }
      }
    });
  }

  void winnerLogic() {
    stopTimer();
    Player.finished = true;
    player.changeWinnerCardColor();
    Future.delayed(const Duration(milliseconds: 100), () => setState(() => player.updateCardColors()));
    Future.delayed(
      const Duration(milliseconds: 800),
      () => setState(() {
        Player.winner = true;
        Player.updateScores();
        if (!Player.completed) MyAlert.showAlert(context, Player.getAlertTitle(), '😎', 'راند بعدی', nextRoundFunc);
        if (Settings.audioValues[0]) AudioPlayer.playResultSound(Player.winnerPlayer);
      }),
    );
  }

  void drawLogic() {
    stopTimer();
    Future.delayed(
      const Duration(milliseconds: 800),
      () => setState(() {
        Player.draw = true;
        Player.updateScores();
        if (!Player.completed) MyAlert.showAlert(context, Player.getAlertTitle(), '😔', 'راند بعدی', nextRoundFunc);
        if (Settings.audioValues[0]) AudioPlayer.playResultSound(Player.winnerPlayer);
      }),
    );
  }

  void nextRoundFunc() {
    setState(() {
      Player.resetStaticData();
      Player.changeProfileCardColor();
      resetTimer();
      startTimer();
      Navigator.pop(context);
    });
  }
}
