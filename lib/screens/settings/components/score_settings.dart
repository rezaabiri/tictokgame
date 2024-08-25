import 'package:flutter/material.dart';
import 'package:funtictac/models/settings.dart';
import 'package:funtictac/screens/settings/components/material_button.dart';

class ScoreSettings extends StatefulWidget {
  final int index;
  const ScoreSettings(this.index, {super.key});

  @override
  _ScoreSettingsState createState() => _ScoreSettingsState();
}

class _ScoreSettingsState extends State<ScoreSettings> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: [
        Text(Settings.scoreTitles[widget.index], style: const TextStyle(fontSize: 19.0, fontFamily: 'morvarid')),
        Row(
          children: [
            MyMaterialButton(
              index: widget.index,
              icon: const Icon(Icons.remove),
              onPressed: Settings.scores[widget.index] > 1 ? decrementFunc : null,
            ),
            Text('${Settings.scores[widget.index]}', style: const TextStyle(fontFamily: 'morvarid'),),
            MyMaterialButton(
              index: widget.index,
              icon: const Icon(Icons.add),
              onPressed: Settings.scores[widget.index] < 20 ? incrementFunc : null,
            ),
          ],
        )
      ],
    );
  }

  void incrementFunc() {
    setState(() => Settings.scores[widget.index]++);
  }

  void decrementFunc() {
    setState(() => Settings.scores[widget.index]--);
  }
}
