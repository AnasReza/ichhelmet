import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ich1/api/api_call.dart';
import 'package:ich1/providers/app_drawer_controller.dart';
import 'package:ich1/utils/shared_pref_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _led = true;
  AppDrawerWrapperController wrapperController = AppDrawerWrapperController();

  // static Future<String> getLocalIpAddress() async {
  //   final interfaces = await NetworkInterface.list(
  //       type: InternetAddressType.IPv4, includeLinkLocal: true);
  //
  //   try {
  //     // Try VPN connection first
  //     NetworkInterface vpnInterface =
  //         interfaces.firstWhere((element) => element.name == "tun0");
  //     return vpnInterface.addresses.first.address;
  //   } on StateError {
  //     // Try wlan connection next
  //     try {
  //       NetworkInterface interface =
  //           interfaces.firstWhere((element) => element.name == "wlan0");
  //       return interface.addresses.first.address;
  //     } catch (ex) {
  //       // Try any other connection next
  //       try {
  //         NetworkInterface interface = interfaces.firstWhere((element) =>
  //             !(element.name == "tun0" || element.name == "wlan0"));
  //         return interface.addresses.first.address;
  //       } catch (ex) {
  //         return null;
  //       }
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var ip = getLocalIpAddress();
    // ip.then((ip) {
    //   print("$ip value");
    //   var saved = saveIPAddress(ip);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
          color: Colors.red,
          child: Center(
            child: Image.asset(
              'assets/images/helmet.png',
              width: 150,
              height: 150,
            ),
          ),
        ),
        Container(
          child: Text(
            'Victoria Robertson',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          child: Text(
            'Helmet Model: iC-Rs+',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: ClipOval(
                      child: Image.asset(
                    "assets/images/leds.png",
                    fit: BoxFit.cover,
                    width: 90.0,
                    height: 90.0,
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5))),
                  child: ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20.0,
                    activeBgColor: Colors.white,
                    activeFgColor: Colors.black,
                    inactiveBgColor:
                        Color.fromARGB(100, 246, 246, 246).withOpacity(1.0),
                    inactiveFgColor:
                        Color.fromARGB(100, 196, 196, 196).withOpacity(1.0),
                    labels: ['LED OFF', 'LED ON'],
                    onToggle: (index) {
                      print('switched to: $index');
                      var response = APICALLS.ledOnOff(index);
                      response.then((value) {
                        setState(() {});
                      });
                    },
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: ClipOval(
                      child: Image.asset(
                    "assets/images/front_cam.png",
                    fit: BoxFit.cover,
                    width: 90.0,
                    height: 90.0,
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5))),child:  ToggleSwitch(
                  minWidth: 90.0,
                  cornerRadius: 20.0,
                  activeBgColor: Colors.white,
                  activeFgColor: Colors.black,
                  inactiveBgColor:
                  Color.fromARGB(100, 246, 246, 246).withOpacity(1.0),
                  inactiveFgColor:
                  Color.fromARGB(100, 196, 196, 196).withOpacity(1.0),
                  labels: ['REC OFF', 'REC ON'],
                  onToggle: (index) {
                    print('switched to: $index');
                    var response = APICALLS.recOnOff(index);
                    response.then((value) {
                      setState(() {});
                    });
                  },
                ),),

              ],
            ),
          ],
        )
      ],
    ));
  }

  Future<bool> saveIPAddress(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(SharedPrefKeys.IP_ADDRESSES, value);
  }
}
