class RecordingFile {
  final String filename;
  final String size;


  RecordingFile({this.filename, this.size, });

  factory RecordingFile.fromJson(Map<String, dynamic> json) {
  return RecordingFile(
      filename: json['filename'] as String,
      size: json['size'] as String,
    );
  }
}
