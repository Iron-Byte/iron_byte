import 'package:flutter/material.dart';

class AppSpacing {
  static const double xs4 = 4;
  static const double sm8 = 8;
  static const double md12 = 12;
  static const double lg16 = 16;
  static const double xl20 = 20;
  static const double xxl24 = 24;
  static const double xxxl32 = 32;
  static const double huge36 = 36;

  static const allXs4 = EdgeInsets.all(xs4);
  static const allSm8 = EdgeInsets.all(sm8);
  static const allMd12 = EdgeInsets.all(md12);
  static const allLg16 = EdgeInsets.all(lg16);
  static const allXl20 = EdgeInsets.all(xl20);
  static const allXxl24 = EdgeInsets.all(xxl24);
  static const allXxxl32 = EdgeInsets.all(xxxl32);
  static const allHuge36 = EdgeInsets.all(huge36);

  static const hSm8 = EdgeInsets.symmetric(horizontal: sm8);
  static const hMd12 = EdgeInsets.symmetric(horizontal: md12);
  static const hLg16 = EdgeInsets.symmetric(horizontal: lg16);

  static const vSm8 = EdgeInsets.symmetric(vertical: sm8);
  static const vMd12 = EdgeInsets.symmetric(vertical: md12);
  static const vLg16 = EdgeInsets.symmetric(vertical: lg16);

  static const topMd12 = EdgeInsets.only(top: md12);
  static const bottomMd12 = EdgeInsets.only(bottom: md12);
  static const leftMd12 = EdgeInsets.only(left: md12);
  static const rightMd12 = EdgeInsets.only(right: md12);

  static const gapW8 = SizedBox(width: sm8);
  static const gapW12 = SizedBox(width: md12);
  static const gapW16 = SizedBox(width: lg16);

  static const gapH8 = SizedBox(height: sm8);
  static const gapH12 = SizedBox(height: md12);
  static const gapH16 = SizedBox(height: lg16);
}
