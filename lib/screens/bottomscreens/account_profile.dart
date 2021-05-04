import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountProfile extends StatefulWidget {
  @override
  AccountProfileState createState() => AccountProfileState();
}

class AccountProfileState extends State<AccountProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Account Profile',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
