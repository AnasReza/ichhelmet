import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ich1/screens/bottomscreens/account_profile.dart';
import 'package:ich1/screens/bottomscreens/cam_files.dart';
import 'package:ich1/screens/bottomscreens/home.dart';
import 'package:ich1/screens/bottomscreens/settings.dart';
import 'package:ich1/screens/drawerscreen/settings_screen.dart';
import 'package:ich1/screens/bottomscreens/voice.dart';

import 'new_rec_vid_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  TabScreenState createState() => TabScreenState();
}

class TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  int _navBarIndex = 0;
  TabController _tabController;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    AlanVoice.addButton(
        "e6e03eeb53c0af1e07716ef9081b19bb2e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  _handleCommand(Map<String, dynamic> data) {
    print("${data.toString()}  data");
    print("${data['route']} routedata");
    String route = data['route'];
    if (route == 'settings') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
    } else if (route == "my_rides") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewRides()),
      );
    } else if (route == "back") {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _navBarIndex = _tabController.index;
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Text(
            "iC-Rider",
            style: TextStyle(fontSize: 25),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(children: [
                  SizedBox(
                      width: 80,
                      height: 80,
                      child: Image(
                          image: AssetImage("assets/images/Ambrose.png"))),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Ambrose Dodson"),
                        Icon(
                          Icons.edit,
                          size: 15,
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              ListTile(
                title: Text('Friends'),
                leading: Icon(Icons.supervisor_account_outlined),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('My Rides'),
                leading: Icon(Icons.map_outlined),
                onTap: () {
                  Navigator.pushNamed(context, "/my-rides");
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.map_outlined),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen()));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Dev Screen'),
                leading: Icon(Icons.map_outlined),
                onTap: () {
                  Navigator.pushNamed(context, "/dev");
                  // Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Container(
          child: getBody(_navBarIndex),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 15.0,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Builder(
          builder: (context) => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).accentColor,
            currentIndex: _navBarIndex,
            selectedFontSize: 0,
            items: [
              BottomNavigationBarItem(
                  label: '',
                  icon: ImageIcon(
                    AssetImage('assets/icons/home.png'),
                    size: 40,
                    color: Colors.black,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/home.png',
                    width: 40,
                    height: 40,
                    color: Colors.red,
                  )),
              BottomNavigationBarItem(
                  label: '',
                  icon: ImageIcon(
                    AssetImage('assets/icons/meeting.png'),
                    size: 40,
                    color: Colors.black,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/meeting.png',
                    width: 40,
                    height: 40,
                    color: Colors.red,
                  )),
              BottomNavigationBarItem(
                  label: '',
                  icon: ImageIcon(
                    AssetImage('assets/icons/social.png'),
                    size: 40,
                    color: Colors.black,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/social.png',
                    width: 40,
                    height: 40,
                    color: Colors.red,
                  )),
              BottomNavigationBarItem(
                  label: '',
                  icon: ImageIcon(
                    AssetImage('assets/icons/video.png'),
                    size: 40,
                    color: Colors.black,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/video.png',
                    width: 40,
                    height: 40,
                    color: Colors.red,
                  )),
              BottomNavigationBarItem(
                  label: '',
                  icon: ImageIcon(
                    AssetImage('assets/icons/settings.png'),
                    size: 40,
                    color: Colors.black,
                  ),
                  activeIcon: Image.asset(
                    'assets/icons/settings.png',
                    width: 40,
                    height: 40,
                    color: Colors.red,
                  )),
            ],
            onTap: (index) {
              setState(() {
                _navBarIndex = index;
              });
            },
          ),
        ));
  }

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return MyHomePage();
      case 1:
        return VoiceApp();
      case 2:
        return AccountProfile();
      case 3:
        return CamFiles();
        case 4:
          return Settings();
      default:
        return MyHomePage();
    }
  }
}
