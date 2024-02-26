import 'package:flutter/material.dart';
import 'package:note_pad/views/utils/colors.dart';
import 'package:note_pad/views/utils/extensions/text_style_extensions.dart';

class AppTheme {
  ThemeData getAppTheme() => ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kPrimaryColor,
      appBarTheme: _appBarTheme(),
      elevatedButtonTheme: _buttonThemeData(),
      floatingActionButtonTheme: _floatingActionButtonThemeData,
      dialogTheme: _dialogTheme());

  AppBarTheme _appBarTheme() => AppBarTheme(
    iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: kPrimaryColor,
      titleTextStyle: const TextStyle().whiteTitleTextStyle);

  ElevatedButtonThemeData _buttonThemeData() => ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
      ));

  DialogTheme _dialogTheme() =>
      DialogTheme(contentTextStyle: const TextStyle().primaryTextStyle);

  get _floatingActionButtonThemeData =>
      const FloatingActionButtonThemeData(backgroundColor: Colors.white);
}
