import 'package:flutter/material.dart';

final ColorScheme greenColorScheme =
    ColorScheme.fromSeed(seedColor: Colors.green);

final ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  colorScheme: greenColorScheme,
);
