import 'package:flutter/material.dart';

class AppRadius {
  static const double xs6 = 6; // logo mark, icons
  static const double sm8 = 8; // buttons, inputs, service cards
  static const double md12 = 12; // service cards alt
  static const double lg16 = 16; // contact card, outer wrap
  static const double pill20 = 20; // tag / pill chips
  static const double padd36 = 36; // tag / padding between chips

  static const borderXs6 = BorderRadius.all(Radius.circular(xs6));
  static const borderSm8 = BorderRadius.all(Radius.circular(sm8));
  static const borderMd12 = BorderRadius.all(Radius.circular(md12));
  static const borderLg16 = BorderRadius.all(Radius.circular(lg16));
  static const borderPill36 = BorderRadius.all(Radius.circular(pill20));
  static const borderPadd36 = BorderRadius.all(Radius.circular(padd36));
}
