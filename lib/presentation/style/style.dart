import 'package:flutter/material.dart';
import 'package:qtank_mobile/presentation/style/color.dart';

class QTankTextStyle {
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: QTankColor.white,
  );

  static const TextStyle titleBlack = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: QTankColor.black,
  );

  static const TextStyle largeTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: QTankColor.white,
  );

  static const TextStyle miniTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: QTankColor.white,
  );

  static const TextStyle miniTitleBlack = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: QTankColor.black,
  );

  static const TextStyle alertText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: QTankColor.orange,
  );

  static const TextStyle alertTextBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: QTankColor.red,
  );

  static const TextStyle planeWhiteText = TextStyle(
    fontSize: 12,
    color: QTankColor.white,
  );

  static const TextStyle planeBlackText = TextStyle(
    fontSize: 12,
    color: QTankColor.black,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    color: QTankColor.white,
  );

  static const TextStyle subtitleOrange = TextStyle(
    fontSize: 14,
    color: QTankColor.orange,
  );

  static const TextStyle subtitleBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: QTankColor.white,
  );

  static const TextStyle subtitleBlack = TextStyle(
    fontSize: 14,
    color: QTankColor.black,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    color: QTankColor.black,
    fontWeight: FontWeight.w600,
    shadows: <Shadow>[
      Shadow(
        color: QTankColor.white,
        offset: Offset(1.2, 1.2),
        blurRadius: 3.0,
      ),
    ],
  );

  static const TextStyle textBoldWithShadow = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: QTankColor.white,
    shadows: <Shadow>[
      Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 2.0,
        color: QTankColor.greyBlack,
      )
    ],
  );

  static const TextStyle linkText = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: QTankColor.lightBlue,
      decoration: TextDecoration.underline);
}
