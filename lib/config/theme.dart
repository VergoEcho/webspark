import 'package:flutter/material.dart';
import 'package:webspark/config/colors.dart';

theme() {
  return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: SparkColors.black,
          backgroundColor: SparkColors.secondary,
          minimumSize: const Size(double.infinity, 0),
          padding: const EdgeInsets.symmetric(vertical: 12),
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
