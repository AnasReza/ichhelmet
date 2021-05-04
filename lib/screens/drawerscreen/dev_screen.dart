import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ich1/api/api_call.dart';
import 'package:ich1/models/recording_file.dart';
import 'package:ich1/utils/shared_pref_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:ich1/api/api_call.dart';


class DevScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RecFilesList(
        recFiles: [
          RecordingFile(filename: "Video 1"),
          RecordingFile(filename: "Video 2"),
          RecordingFile(filename: "Video 3")
        ],
      ),
      // body: FutureBuilder<List<RecordingFile>>(
      //   future: APICALLS.fetchRecFiles(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) print(snapshot.error);
      //     // List<RecordingFile> list = List();
      //     // list.add(RecordingFile(filename: "Video 1"));
      //     // list.add(RecordingFile(filename: "Video 2"));
      //     // list.add(RecordingFile(filename: "Video 3"));
      //     // return RecFilesList(
      //     //   recFiles: list,
      //     // );
      //     return snapshot.hasData
      //         ? RecFilesList(
      //             recFiles: snapshot.data,
      //           )
      //         : Center(child: CircularProgressIndicator());
      //   },
      // ),
    );
  }
}

enum VidState { Playing, NotInitiated }

class RecFilesList extends StatefulWidget {
  List<RecordingFile> recFiles;

  RecFilesList({Key key, this.recFiles}) : super(key: key);

  @override
  RecFilesListState createState() => RecFilesListState(recFiles: recFiles);
}

class RecFilesListState extends State<RecFilesList> {
  RecFilesListState({this.recFiles});

  List<RecordingFile> recFiles;
  VideoPlayerController video_controller;
  List<String> videoList = List();
  VidState vidState = VidState.NotInitiated;

  // APICALLS apiCall = APICALLS();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // fetchRecordings();
    print("dev_screen");
    videoList.add(
        "http://mirrors.standaloneinstaller.com/video-sample/dolbycanyon.mp4");
    videoList.add(
        "http://mirrors.standaloneinstaller.com/video-sample/lion-sample.mp4");
    videoList.add(
        "http://mirrors.standaloneinstaller.com/video-sample/Panasonic_HDC_TM_700_P_50i.mp4");

    //
    // video_controller = VideoPlayerController.network(
    //     "http://192.168.1.84/download/Sample.mp4")
    //   ..initialize().then((value) {
    //     setState(() {
    //       video_controller.play();
    //     });
    //   });
  }

  void fetchRecordings() async {
    var files = await APICALLS.fetchRecFiles();
    print("fetchedFiles: $files");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (vidState == VidState.Playing)
          Container(
            width: double.infinity,
            height: 200,
            child: VideoPlayer(video_controller),
          ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: recFiles.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Text(recFiles[index].filename),
                leading: Icon(Icons.video_collection_outlined),
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String ip = prefs.getString(SharedPrefKeys.HOST_NAME);
                  setState(() {
                    video_controller = VideoPlayerController.network(
                        "http://$ip:8000/download/${recFiles[index].filename}")
                      ..initialize().then((value) {
                        setState(() {
                          vidState = VidState.Playing;
                          video_controller.play();
                        });
                      });
                  });
                },
              );
            }),
      ],
    );
  }
}
