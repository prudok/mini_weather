
import 'package:flutter/material.dart';

final ColorScheme greenColorScheme =
    ColorScheme.fromSeed(seedColor: Colors.green);

final ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
  colorScheme: greenColorScheme,
  appBarTheme: const AppBarTheme().copyWith(backgroundColor: Colors.green[100])
);