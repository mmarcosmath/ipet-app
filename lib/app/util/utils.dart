import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

Future<Uint8List?> selectImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: [
      'jpg',
      "jpeg",
      "png",
    ],
  );

  if (result != null) {
    var imageBytes = await File(result.files.single.path!).readAsBytes();
    return imageBytes;
  }
}

Future<List<Uint8List>?> selectMultipleImages() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.custom,
    allowedExtensions: [
      'jpg',
      "jpeg",
      "png",
    ],
  );

  if (result != null) {
    List<Uint8List> imagesBytes =
        result.paths.map((path) => File(path!).readAsBytesSync()).toList();
    return imagesBytes;
  }
}
