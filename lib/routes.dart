import 'package:flutter/widgets.dart';
import 'package:ich1/main.dart';
import 'package:ich1/screens/drawerscreen/dev_screen.dart';
import 'screens/bottomscreens/home.dart';
import 'screens/home_screen.dart';
import 'package:ich1/screens/new_rec_vid_screen.dart';


final Map<String, WidgetBuilder> appRoutes = <String, WidgetBuilder>{
  "/": (BuildContext context) => TabScreen(),
  "/my-rides": (BuildContext context) => NewRides(),
  "/dev": (BuildContext context) => DevScreen(),
};
