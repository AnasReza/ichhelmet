
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ThemeUtils {
  static final ThemeData defaultAppThemeData = appTheme();

  static ThemeData appTheme() {
    return ThemeData(
      fontFamily: 'AvenirNextLTPro',
      primaryColor: Colors.blueGrey.shade600,
      accentColor: Colors.red.shade800,
      hintColor: Color(0xFF999999),
      dividerColor: Color(0xFFE5E3DC),
      highlightColor: Colors.lightGreen,
      disabledColor: Color(0xFFE5E3DC),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueGrey.shade600,
        textTheme: ButtonTextTheme.primary,
        //  <-- this auto selects the right color
        shape: StadiumBorder(),
        disabledColor: Color(0xFFE5E3DC),
      ),
      scaffoldBackgroundColor: Colors.white,
      cardColor: Color(0xFFFDFBEF),
      cardTheme: CardTheme(elevation: 5),
      canvasColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.blueGrey.shade500,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.blue.shade900,
        ),
      ),
      textTheme: TextTheme(
          headline4: TextStyle(fontWeight: FontWeight.w900),
          headline5: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
          headline6:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900),
          subtitle1: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900),
          subtitle2: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900),
          bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          caption: TextStyle(fontSize: 13, color: Colors.blue.shade900),
          button: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

}

TextStyle appBarTitleStyle(BuildContext context) =>
    Theme.of(context).textTheme.subtitle2.copyWith(
      color: Theme.of(context).primaryColor,
      fontSize: 17,
      fontWeight: FontWeight.bold,
    );

TextStyle textFieldLabelStyle(BuildContext context) =>
    Theme.of(context).textTheme.caption.copyWith(
      color: Theme.of(context).accentColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

TextStyle textFieldHintStyle(BuildContext context) =>
    Theme.of(context).textTheme.caption.copyWith(
      color: Theme.of(context).hintColor,
      fontWeight: FontWeight.normal,
      height: 3,
    );

TextStyle textFieldInputStyle(BuildContext context) =>
    Theme.of(context).textTheme.caption.copyWith(
      color: Theme.of(context).primaryColor,
      fontSize: 15,
      fontWeight: FontWeight.normal,
    );
