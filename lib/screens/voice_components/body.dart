import 'package:flutter/material.dart';

import 'user_calling_card.dart';

class Body extends StatelessWidget {
  List<Map<String, dynamic>> demoData = List();
  String channelName = "";

  Body(List<Map<String, dynamic>> demoData, String channelName) {
    this.demoData = demoData;
    this.channelName = channelName;
  }

  @override
  Widget build(BuildContext context) {
    return

        GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: demoData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) => demoData[index]["isCalling"]
                ? Container(
                    height: 800,
                    child: UserCallingCard(
                      name: "Steve jon",
                      image: "assets/images/group_call_face_small.png",
                    ),
                  )
                : Container(
                    height: 800,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(demoData[index]['image']),
                            fit: BoxFit.cover)),
                    child: Center(
                      child: ListTile(
                        title: Text(
                          'Calling',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          demoData[index]['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: new Icon(
                          Icons.call,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ));

  }
}
