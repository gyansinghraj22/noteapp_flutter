import 'dart:developer';

import 'package:file_picker/file_picker.dart';

Future<PlatformFile?> pickFile() async {
  const int maxFileSize = 2 * 1024 * 1024;

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['csv', 'xlsx'],
  );

  if (result != null) {
    PlatformFile file = result.files.first;

    if (file.size > maxFileSize) {
      log("File size exceeds 2MB limit. Please select a smaller file.");
      return null;
    }

    return file;
  }

  return null;
}
