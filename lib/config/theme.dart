import 'package:flutter/material.dart';
import 'package:webspark/config/colors.dart';

theme() {
  ThemeData theme = ThemeData();
  return ThemeData(
    radioTheme: const RadioThemeData(
      fillColor: WidgetStatePropertyAll(SparkColors.black),
    ),
      colorScheme: theme.colorScheme.copyWith(
        secondary: SparkColors.black,
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: SparkColors.black,
        thumbColor: SparkColors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: SparkColors.primary,
          backgroundColor: SparkColors.black,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 16, color: SparkColors.black),
        bodyMedium: TextStyle(
          fontSize: 12,
          color: SparkColors.black,
        ),
      ));
}
