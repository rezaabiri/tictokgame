import 'package:flutter/material.dart';
import 'package:funtictac/constants.dart';
import 'package:funtictac/screens/pickup/pickup_screen.dart';
import 'package:funtictac/models/responsive_ui.dart';
import 'package:funtictac/widgets/material_button.dart';

class MyScaffoldBody extends StatelessWidget {
  const MyScaffoldBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(child: _buildRichText(context)),
          MaterialButtonWidget(
            text: 'انتخاب مهره',
            textSize: ResponsiveUI.getFontSize(35.0),
            textPadding: 12.0,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PickUpScreen()),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRichText(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            _buildTextSpan(context, 'X', kXTextStyle),
            _buildTextSpan(context, 'O', kOTextStyle),
          ],
        ),
      ),
    );
  }

  TextSpan _buildTextSpan(BuildContext context, String letter, TextStyle textStyle) {
    return TextSpan(
      text: letter,
      style: textStyle.copyWith(
        fontSize: ResponsiveUI.getFontSize(200.0),
      ),
    );
  }
}
