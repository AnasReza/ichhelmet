import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../models/recording_file.dart';

// Future<List<RecordingFile>> fetchRecFiles(http.Client client) async {
//   final response = await client.get('http://192.168.1.84/api/mybrowser');
//
//   // Use the compute function to run parsePhotos in a separate isolate.
//   return compute(parseFiles, response.body);
// }

// List<RecordingFile> parseFiles(String responseBody) {
//   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
//   return parsed
//       .map<RecordingFile>((json) => RecordingFile.fromJson(json))
//       .toList();
// }

class MyRidesScreen extends StatelessWidget {
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
      //   //future: APICALLS.fetchRecFiles(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) print(snapshot.error);
      //     List<RecordingFile> list = List();
      //     list.add(RecordingFile(filename: "Video 1"));
      //     list.add(RecordingFile(filename: "Video 2"));
      //     list.add(RecordingFile(filename: "Video 3"));
      //     return RecFilesList(
      //       recFiles: list,
      //     );
      //     // return snapshot.hasData
      //     //     ? RecFilesList(
      //     //         recFiles: snapshot.data,
      //     //       )
      //     //     : Center(child: CircularProgressIndicator());
      //   },
      // ),
    );
  }
}

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("myRides");
    videoList.add(
        "http://mirrors.standaloneinstaller.com/video-sample/dolbycanyon.mp4");
    videoList.add(
        "http://mirrors.standaloneinstaller.com/video-sample/lion-sample.mp4");
    videoList.add(
        "http://mirrors.standaloneinstaller.com/video-sample/Panasonic_HDC_TM_700_P_50i.mp4");

    video_controller = VideoPlayerController.network(videoList[0])
      ..initialize().then((value) {
        setState(() {
          video_controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                onTap: () {
                  setState(() {
                    video_controller =
                        VideoPlayerController.network(videoList[index])
                          ..initialize().then((value) {
                            setState(() {
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
