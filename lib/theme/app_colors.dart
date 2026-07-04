import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0D5C63);
  static const Color secondary = Color(0xFF44A1A0);
  static const Color accent = Color(0xFFF2C14E);
  static const Color background = Color(0xFFF3F7F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFE7F0F0);
  static const Color ink = Color(0xFF14323A);
  static const Color inkMuted = Color(0xFF5D7479);
  static const Color success = Color(0xFF138A5A);
  static const Color successSoft = Color(0xFFDDF4E8);
  static const Color danger = Color(0xFFB8405E);
  static const Color dangerSoft = Color(0xFFFADFE6);
  static const Color neutral = Color(0xFF5B6975);
  static const Color neutralSoft = Color(0xFFE6EBEF);
  static const Color chartTrack = Color(0xFFD7E4E4);
  static const Color cardShadow = Color(0x1A0D5C63);

  static const LinearGradient heroGradient = LinearGradient(
    colors: <Color>[primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient panelGradient = LinearGradient(
    colors: <Color>[Color(0xFFF7FBFB), Color(0xFFE8F4F4)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
