import 'package:flutter/material.dart';
import 'package:note_pad/views/utils/colors.dart';

extension TextStyleExtensions on TextStyle?{
  TextStyle get whiteTextStyle => const TextStyle(color: Colors.white,fontSize: 14.0);
  TextStyle get whiteTitleTextStyle => const TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.w500,letterSpacing: 1);
  TextStyle get blackTextStyle => const TextStyle(color: Colors.black,fontSize: 14.0);
  TextStyle get primaryTextStyle => const TextStyle(color: colorBlack,fontSize: 14.0);

}