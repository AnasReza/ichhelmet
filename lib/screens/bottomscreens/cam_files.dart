import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CamFiles extends StatefulWidget {
  @override
  CamFilesState createState() => CamFilesState();
}

class CamFilesState extends State<CamFiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Cam Files',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
