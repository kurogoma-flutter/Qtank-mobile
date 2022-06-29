import 'package:flutter/material.dart';
import 'package:qtank_mobile/presentation/style/color.dart';

class QTankTextStyle {
  static const TextStyle title = TextStyle(
    fontSize: 20,
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

  static const TextStyle alertTextBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: QTankColor.red,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    color: QTankColor.white,
  );
}
