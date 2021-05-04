import 'package:flutter/material.dart';
import 'package:ich1/utils/shared_pref_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  String host = "", id = "";
  TextEditingController controller = TextEditingController();
  TextEditingController channel_controller = TextEditingController();
  SharedPreferences prefs;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Host Name'),
                    controller: controller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Channel ID'),
                    controller: channel_controller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        String hostName = controller.text;
                        String channelId = channel_controller.text;
                        print('hostname: $hostName    channelID: $channelId');
                        // If the form is valid, display a Snackbar.
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text('Processing Data'),
                        //   duration: Duration(seconds: 3),
                        // ));
                        saveData(hostName, channelId);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void saveData(String hostName, String channelId) async {
    print("hostname: $hostName");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPrefKeys.HOST_NAME, hostName).then((value) {
      print('$value value');
      String saved = prefs.getString(SharedPrefKeys.HOST_NAME);
      print("saved: $saved");
    });
    await prefs.setString(SharedPrefKeys.CHANNEL_ID, channelId);
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    String saved = prefs.getString(SharedPrefKeys.HOST_NAME);
    String id = prefs.getString(SharedPrefKeys.CHANNEL_ID);
    setState(() {
      controller.text = saved;
      channel_controller.text = id;
    });
    // controller = TextEditingController();
    // channel_controller = TextEditingController();
  }
}
