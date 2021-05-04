import 'package:flutter/material.dart';

class UserCallingCard extends StatelessWidget {
  const UserCallingCard({
    Key key,
    @required this.name,
    @required this.image,
  }) : super(key: key);

  final String name, image;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(Icons.call),
          ),
          Text(
            name,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          // Text(
          //   "Calling…",
          //   style: TextStyle(color: Colors.black),
          // )
        ],
      ),
    );
  }
}
