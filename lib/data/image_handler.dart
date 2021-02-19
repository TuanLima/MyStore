import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ImageHandler {
  ImageHandler() {
    resolveDir();
  }
  Directory imagePath;
  Directory resolvedDirectory;
  String _imageUrl;
  String _imagePathUrl;
  Future<Directory> get futureDirectory async {
    return getApplicationDocumentsDirectory();
  }

  Future<Image> pickImage(String imageUrl, String imagePathUrl) async {
    _imageUrl = imageUrl;
    _imagePathUrl = imagePathUrl;

    if (imageUrl.split(':').first == 'data') {
      return Image.memory(base64Decode(imagePathUrl));
    }

    Directory imgPath = await _loadImagePath(_imageUrl + _imagePathUrl);
    File file = File(imgPath.path);

    if (file.existsSync()) {
      final bytes = await file.readAsBytes();
      return Image.memory(
        bytes,
        errorBuilder: safetyCallback,
      );
    } else {
      final data =
          (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imagePathUrl))
              .buffer
              .asUint8List();
      saveImage(imageUrl + imagePathUrl, data);
      return Image.memory(
        data,
        errorBuilder: safetyCallback,
      );
    }
  }

  Future<void> saveImage(String imageUrl, Uint8List data) async {
    if (resolvedDirectory != null) {
      await futureDirectory;
    }
    Directory imgPath = await _loadImagePath(imageUrl);
    File _file = File(imgPath.path);
    _file.writeAsBytes(data);
  }

  Future<Directory> _loadImagePath(String imageUrl) async {
    if (resolvedDirectory == null) {
      resolvedDirectory = await futureDirectory;
    }
    imagePath =
        Directory(resolvedDirectory.path + '/' + imageUrl.split('/').last);
    return imagePath;
  }

  Future<void> resolveDir() async {
    resolvedDirectory = await futureDirectory;
  }

  Widget safetyCallback(
      BuildContext context, Object error, StackTrace stackTrace) {
    print(error);
    return Image.network(_imageUrl + _imagePathUrl);
  }
}
