import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

// Custom color palette extracted from trips_screen.dart
class AppColors {
  static const Color neonGreen = Color(0xFF39FF14);
  static final Color neonGreenBg = const Color(0xFF39FF14).withAlpha(51);
  static const Color orange = Color(0xFFFF8A00);
  static final Color orangeBg = const Color(0xFFFF8A00).withAlpha(51);
  static const Color whiteBorder = Color(0x1AFFFFFF);
  static const Color grayText = Color(0xFF9CA3AF);
  static const Color pink = Color(0xFFFF2D95);
  static const Color purple = Color(0xFFBD00FF);
  static const Color dark = Color(0xFF232323);
  static const Color white = Colors.white;
}

class AppTheme {

  final int selectedColor;
  final bool isDarkmode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkmode = false,
  }): assert( selectedColor >= 0, 'Selected color must be greater then 0' ),  
      assert( selectedColor < colorList.length, 
        'Selected color must be less or equal than ${ colorList.length - 1 }');

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: colorList[ selectedColor ],
    appBarTheme: const AppBarTheme(
      centerTitle: false
    ),
  );


  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkmode
  }) => AppTheme(
    selectedColor: selectedColor ?? this.selectedColor,
    isDarkmode: isDarkmode ?? this.isDarkmode,
  );

  /// Custom dark theme for trips screens
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.dark,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.pink,
        secondary: AppColors.purple,
        surface: AppColors.dark,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.white,
        error: AppColors.orange,
        onError: AppColors.white,
      ),
      dividerColor: AppColors.whiteBorder,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.white),
        bodyMedium: TextStyle(color: AppColors.grayText),
        bodySmall: TextStyle(color: AppColors.grayText),
        titleLarge: TextStyle(color: AppColors.white),
        titleMedium: TextStyle(color: AppColors.white),
        titleSmall: TextStyle(color: AppColors.white),
      ),
      iconTheme: const IconThemeData(color: AppColors.pink),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.pink,
        foregroundColor: AppColors.white,
      ),
      cardColor: AppColors.dark,
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: AppColors.dark,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.whiteBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.whiteBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.pink),
        ),
      ),
      // Otros detalles pueden agregarse según necesidades específicas
    );
  }

}