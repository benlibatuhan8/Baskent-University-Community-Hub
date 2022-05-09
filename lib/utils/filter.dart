import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class Filter {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/assets/hard.txt');
  }

  Future<File> getImageFileFromAssets() async {
    final byteData = await rootBundle.load('assets/data/hard.txt');

    final file =
        File('${(await getTemporaryDirectory()).path}/assets/hard.txt');

    return file;
  }

  Future<String> filter(String text) async {
    try {
      final file = await rootBundle.loadString('assets/textFiles/hard.txt');
      LineSplitter ls = new LineSplitter();
      List<String> hard = ls.convert(file);
      text = " " + text;
      for (var b in hard) {
        if (text.contains(" " + b)) {
          var l = b.length;
          var result = text.replaceAll(b, " ***** ");
          text = result;
        }
      }
    } on Exception catch (e) {
      print(e);
    }
    return text;
  }
}
