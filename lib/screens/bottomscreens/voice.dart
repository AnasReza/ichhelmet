import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:ich1/screens/voice_components/body.dart';
import 'package:ich1/utils/shared_pref_constant.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

const APP_ID = '4b5a83598cc64b71935386a89dfb7686';
const Token =
    '0064b5a83598cc64b71935386a89dfb7686IABctoddqGpRWY0AjKE9ByEIhX7qn53pwlV5+ZjXKfrLGX11jOoAAAAAEAC0V+LrB+EXYAEAAQAG4Rdg';

class VoiceApp extends StatefulWidget {
  @override
  _VoiceAppState createState() => _VoiceAppState();
}

// App state
class _VoiceAppState extends State<VoiceApp> {
  int screen = 1;
  bool _joined = false;
  int _remoteUid = null;
  bool _switch = false;
  bool check = true;
  Icon icon=Icon(Icons.call);
  List mainList = new List();
  MultiSelectController controller = new MultiSelectController();
  var engine;
  String channel_name="";


  Future<void> getSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    channel_name=prefs.getString(SharedPrefKeys.CHANNEL_ID);

  }

  @override
  void initState() {
    super.initState();
    mainList.add({"key": "John"});
    mainList.add({"key": "Angela"});
    mainList.add({"key": "Peter"});
    mainList.add({"key": "Jess"});

    controller.disableEditingWhenNoneSelected = true;
    controller.set(mainList.length);
    getSavedData();

  }

  void add() {
    mainList.add({"key": mainList.length + 1});

    setState(() {
      controller.set(mainList.length);
    });
  }

  void delete() {
    var list = controller.selectedIndexes;
    list.sort((b, a) =>
        a.compareTo(b)); //reoder from biggest number, so it wont error
    list.forEach((element) {
      mainList.removeAt(element);
    });

    setState(() {
      controller.set(mainList.length);
    });
  }

  void selectAll() {
    setState(() {
      controller.toggleAll();
    });
  }

  // Initialize the app
  Future<void> initPlatformState() async {
    // Get microphone permission
    print('inside the initPlatformState');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String saved = prefs.getString(SharedPrefKeys.HOST_NAME);
    await PermissionHandler().requestPermissions(
      [PermissionGroup.microphone],
    );

    // Create RTC client instance
    var engine = await RtcEngine.create(APP_ID);

    // Define event handler
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      print('joinChannelSuccess $channel $uid');
      setState(() {
        _joined = true;
      });
    }, userJoined: (int uid, int elapsed) {
      print('userJoined $uid');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline $uid ${reason}');
      setState(() {
        _remoteUid = null;
      });
    }, error: (code) {
      print('$code on error');
    }));
    await engine.enableWebSdkInteroperability(true);
    // Join channel 123
    await engine.joinChannel(Token, saved, null, 0);
  }

  List<Map<String, dynamic>> demoData = [
    {
      "isCalling": true,
      "name": "Steve jon",
      "image": "assets/images/group_call_face_small.png",
    },
  ];

  // Create a simple chat UI
  Widget build(BuildContext context) {
    return Scaffold(
      body: (screen == 1)
          ? ListView.builder(
              itemCount: mainList.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SizedBox(
                    height: 40,
                    child: Center(
                        child: Text(
                      "My friends on iCH Rider",
                      style: TextStyle(fontSize: 20),
                    )),
                  );
                } else if (index > 0 && index <= mainList.length)
                // else

                {
                  index = index - 1;
                  return InkWell(
                    onTap: () {},
                    child: MultiSelectItem(
                      isSelecting: controller.isSelecting,
                      onSelected: () {
                        print('multiselected $index');
                        var name = mainList[index]['key'];
                        String imagePath;
                        if (name == "John") {
                          imagePath = "assets/images/group_call_face_2.png";
                        } else if (name == "Angela") {
                          imagePath = "assets/images/goup_call_1.png";
                        } else if (name == "Peter") {
                          imagePath = "assets/images/group_call_face_4.png";
                        } else if (name == "Jess") {
                          imagePath = "assets/images/group_call_face_3.png";
                        } else {
                          imagePath = "assets/images/calling_face.png";
                        }
                        demoData.add(
                          {
                            "isCalling": false,
                            "name": "$name",
                            "image": imagePath,
                          },
                        );
                        setState(() {
                          controller.toggle(index);
                        });
                      },
                      child: Container(
                        child: ListTile(
                          leading: Icon(
                            Icons.supervised_user_circle_outlined,
                            size: 30,
                          ),
                          title: new Text(
                            "${mainList[index]['key']}",
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: new Text("online"),
                        ),
                        decoration: controller.isSelected(index)
                            ? new BoxDecoration(color: Colors.grey[300])
                            : new BoxDecoration(),
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    child: RaisedButton(
                      child: Text("Add more"),
                      onPressed: add,
                    ),
                  );
                }
              },
            )
          : Scaffold(
              backgroundColor: Colors.blueGrey.shade900,
              body: Body(demoData,channel_name),
            ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          if (demoData.length > 1) {
            if (check) {
              check=false;
              initPlatformState();
              setState(() {
                icon= Icon(Icons.call_end);
                screen = 2;
              });
            } else {
              controller.deselectAll();
              check=true;
              demoData.clear();
              demoData.add({
                "isCalling": true,
                "name": "Steve jon",
                "image": "assets/images/group_call_face_small.png",
              },);

              setState(() {
                icon=Icon(Icons.call);
                screen = 1;
              });
            }
          } else {
            Toast.show("Please a person to call", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          }
        },
        tooltip: 'Increment',
        child: icon,
      ),
    );
  }


}
