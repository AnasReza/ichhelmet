import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ich1/api/api_call.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../models/recording_file.dart';

class NewRides extends StatelessWidget {
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
  VideoPlayerController video1_controller;
  VideoPlayerController video2_controller;
  VideoPlayerController video3_controller;
  List<String> videoList = List();
  List<Widget> list = List();
  VidState vidState = VidState.NotInitiated;
  String subTitle = "";
  bool loading = false;
  String _tempDir = "";

  // APICALLS apiCall = APICALLS();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchRecordings();
    print("new_rec_vid_screen");
    getTemporaryDirectory().then((d) {
      _tempDir = d.path;
      List<Widget> tempList = List();
      videoList.add(
          "http://mirrors.standaloneinstaller.com/video-sample/dolbycanyon.mp4");
      video1_controller = VideoPlayerController.network(
          "http://mirrors.standaloneinstaller.com/video-sample/dolbycanyon.mp4")
        ..initialize().then((value) {
          String time = video1_controller.value.duration.toString();
          List<String> timeSplit = time.split(".");
          tempList.add(listVideo(
              "http://mirrors.standaloneinstaller.com/video-sample/dolbycanyon.mp4",
              "Video 1",
              timeSplit[0],
              0));
          videoList.add(
              "http://mirrors.standaloneinstaller.com/video-sample/lion-sample.mp4");
          video2_controller = VideoPlayerController.network(
              "http://mirrors.standaloneinstaller.com/video-sample/lion-sample.mp4")
            ..initialize().then((value) {
              String time1 = video2_controller.value.duration.toString();
              List<String> timeSplit1 = time1.split(".");

              tempList.add(listVideo(
                  "http://mirrors.standaloneinstaller.com/video-sample/lion-sample.mp4",
                  "Video 2",
                  timeSplit1[0],
                  1));
              videoList.add(
                  "http://mirrors.standaloneinstaller.com/video-sample/Panasonic_HDC_TM_700_P_50i.mp4");
              video3_controller = VideoPlayerController.network(
                  "http://mirrors.standaloneinstaller.com/video-sample/Panasonic_HDC_TM_700_P_50i.mp4")
                ..initialize().then((value) {
                  String time2 = video3_controller.value.duration.toString();
                  List<String> timeSplit2 = time2.split(".");
                  tempList.add(listVideo(
                      "http://mirrors.standaloneinstaller.com/video-sample/Panasonic_HDC_TM_700_P_50i.mp4",
                      "Video 3",
                      timeSplit2[0],
                      2));
                  setState(() {
                    loading = true;
                    list = tempList;
                  });
                  video_controller = VideoPlayerController.network(
                      "http://mirrors.standaloneinstaller.com/video-sample/dolbycanyon.mp4")
                    ..initialize().then((value) {
                      setState(() {
                        vidState = VidState.Playing;
                        video_controller.play();
                      });
                    });
                });
            });
        });
    });
  }

  void fetchRecordings() async {
    var files = await APICALLS.fetchRecFiles();
    print("fetchedFiles: $files");
  }

  Widget listVideo(
      String url, String video_name, String sub_title, int index) {
    GenThumbnailImage thumbnail = GenThumbnailImage(
      thumbnailRequest: ThumbnailRequest(
          video: url,
          thumbnailPath: _tempDir,
          imageFormat: ImageFormat.PNG,
          maxHeight: 80,
          maxWidth: 80,
          quality: 75),
    );

    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 20, bottom: 20),
        child: Row(
          children: [
            // Icon(Icons.video_collection_outlined),
            thumbnail,
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video_name,
                  ),
                  Text(sub_title)
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        print("$index index $video_name video name");
        setState(() {
          video_controller = VideoPlayerController.network(videoList[index])
            ..initialize().then((value) {
              print("${video_controller.value.size} size");
              print("${video_controller.value.duration} duration");

              setState(() {
                subTitle = video_controller.value.duration.toString();
                vidState = VidState.Playing;
                video_controller.play();
              });
            });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Column(
            children: [
              if (vidState == VidState.Playing)
                Container(
                  width: double.infinity,
                  height: 200,
                  child: VideoPlayer(video_controller),
                ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Column(
                  children: list,
                ),
              ),

              // ListView.builder(
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true,
              //     itemCount: recFiles.length,
              //     itemBuilder: (ctx, index) {
              //       return ListTile(
              //         title: Text(recFiles[index].filename),
              //         leading: Icon(Icons.video_collection_outlined),
              //         subtitle: Text(subTitle),
              //         onTap: () async {
              //           SharedPreferences prefs =
              //               await SharedPreferences.getInstance();
              //           String ip = prefs.getString(SharedPrefKeys.HOST_NAME);
              //           setState(() {
              //             video_controller = VideoPlayerController.network(
              //                 videoList[index])
              //               ..initialize().then((value) {
              //                 print("${video_controller.value.size} size");
              //                 print("${video_controller.value.duration} duration");
              //
              //                 setState(() {
              //                   subTitle = video_controller.value.duration.toString();
              //                   vidState = VidState.Playing;
              //                   video_controller.play();
              //                 });
              //               });
              //           });
              //         },
              //       );
              //     }),
            ],
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

class ThumbnailResult {
  final Image image;
  final int dataSize;
  final int height;
  final int width;

  const ThumbnailResult({this.image, this.dataSize, this.height, this.width});
}

class ThumbnailRequest {
  final String video;
  final String thumbnailPath;
  final ImageFormat imageFormat;
  final int maxHeight;
  final int maxWidth;
  final int timeMs;
  final int quality;

  const ThumbnailRequest(
      {this.video,
      this.thumbnailPath,
      this.imageFormat,
      this.maxHeight,
      this.maxWidth,
      this.timeMs,
      this.quality});
}

Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
  //WidgetsFlutterBinding.ensureInitialized();
  Uint8List bytes;
  final Completer<ThumbnailResult> completer = Completer();
  if (r.thumbnailPath != null) {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: r.video,
        thumbnailPath: r.thumbnailPath,
        imageFormat: r.imageFormat,
        maxHeight: r.maxHeight,
        maxWidth: r.maxWidth,
        timeMs: r.timeMs,
        quality: r.quality);

    print("thumbnail file is located: $thumbnailPath");

    final file = File(thumbnailPath);
    bytes = file.readAsBytesSync();
  } else {
    bytes = await VideoThumbnail.thumbnailData(
        video: r.video,
        imageFormat: r.imageFormat,
        maxHeight: r.maxHeight,
        maxWidth: r.maxWidth,
        timeMs: r.timeMs,
        quality: r.quality);
  }

  int _imageDataSize = bytes.length;
  print("image size: $_imageDataSize");

  final _image = Image.memory(bytes);
  _image.image
      .resolve(ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    completer.complete(ThumbnailResult(
      image: _image,
      dataSize: _imageDataSize,
      height: info.image.height,
      width: info.image.width,
    ));
  }));
  return completer.future;
}

class GenThumbnailImage extends StatefulWidget {
  final ThumbnailRequest thumbnailRequest;

  const GenThumbnailImage({Key key, this.thumbnailRequest}) : super(key: key);

  @override
  _GenThumbnailImageState createState() => _GenThumbnailImageState();
}

class _GenThumbnailImageState extends State<GenThumbnailImage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThumbnailResult>(
      future: genThumbnail(widget.thumbnailRequest),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final _image = snapshot.data.image;
          final _width = snapshot.data.width;
          final _height = snapshot.data.height;
          final _dataSize = snapshot.data.dataSize;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Center(
              //   child: Text(
              //       "Image ${widget.thumbnailRequest.thumbnailPath == null ? 'data size' : 'file size'}: $_dataSize, width:$_width, height:$_height"),
              // ),
              // Container(
              //   color: Colors.grey,
              //   height: 1.0,
              // ),
              _image,
            ],
          );
        } else if (snapshot.hasError) {
          return Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.red,
            child: Text(
              "Error:\n${snapshot.error.toString()}",
            ),
          );
        } else {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Text(
                //     "Generating the thumbnail for: ${widget.thumbnailRequest.video}..."),
                // SizedBox(
                //   height: 10.0,
                // ),
                CircularProgressIndicator(),
              ]);
        }
      },
    );
  }
}
