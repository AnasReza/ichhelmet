import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ich1/models/recording_file.dart';
import 'package:ich1/utils/shared_pref_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APICALLS {
  static Future ledOnOff(int signal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ip = prefs.getString(SharedPrefKeys.HOST_NAME);
    var url = 'http://$ip:8000/back_led/$signal';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response.body;
  }

  static Future recOnOff(int signal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ip = prefs.getString(SharedPrefKeys.HOST_NAME);
    var url = 'http://$ip:8000/rec_ride/$signal';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response.body;
  }

  static Future<List<RecordingFile>> fetchRecFiles() async {
    print("fetchRecFiles() triggered");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ipValue = prefs.getString(SharedPrefKeys.HOST_NAME);
    print("ipValue: $ipValue");
    var url = 'http://$ipValue:8000/api/mybrowser';
    final response = await http.get(url);
    // Use the compute function to run parsePhotos in a separate isolate.
    print(response.body);
    var servResponse = await compute(parseFiles, response.body);
    print("servResponse: $servResponse");
    return servResponse;
  }

  static List<RecordingFile> parseFiles(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    print("parsed: $parsed");
    return parsed
        .map<RecordingFile>((json) => RecordingFile.fromJson(json))
        .toList();
  }
}
