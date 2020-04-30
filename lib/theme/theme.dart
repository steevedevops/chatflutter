import 'package:flutter/material.dart';
import 'package:morse/theme/colors.dart';

class AppTheme{
  static final ThemeData apptheme = ThemeData(
    primarySwatch: Colors.blue,
    backgroundColor: MorseColor.white,
    accentColor: MorseColor.dodgetBlue,
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    cardColor: Colors.white,
    unselectedWidgetColor: Colors.grey,
    bottomAppBarColor: Colors.white,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColor.white
    ),
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: MorseColor.white,
      iconTheme: IconThemeData(color: MorseColor.dodgetBlue,),
      elevation: 0,
      textTheme:  TextTheme(
          title:    TextStyle(color: Colors.black,  fontSize: 20),
          body1:    TextStyle(color: Colors.black87,fontSize: 14),
          body2:    TextStyle(color: Colors.black87,fontSize: 18),
          button:   TextStyle(color: Colors.white,  fontSize: 20),
          caption:  TextStyle(color: Colors.black45,fontSize: 16),
          headline: TextStyle(color: Colors.black87,fontSize: 26),
          subhead:  TextStyle(color: Colors.black,  fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'Opensans-Bold'),
          subtitle: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'Opensans-Bold'),
          display1: TextStyle(color: Colors.black87,fontSize: 14),
          display2: TextStyle(color: Colors.black87,fontSize: 18),
          display3: TextStyle(color: Colors.black87,fontSize: 22),
          display4: TextStyle(color: Colors.black87,fontSize: 24),
          overline: TextStyle(color: Colors.black87,fontSize: 10),
          )
        ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor:   MorseColor.dodgetBlue,
    ),
    colorScheme: ColorScheme(
      background: Colors.white,
      onPrimary: Colors.white,
      onBackground: Colors.black,
      onError: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      error: Colors.red,
      primary: Colors.blue,
      primaryVariant: Colors.blue,
      secondary: AppColor.secondary,
      secondaryVariant: AppColor.darkGrey,
      surface: Colors.white,
      brightness: Brightness.light
    )
  );
}