import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PickImageUtils {
  static Future getImage({required ImageSource imageSource}) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      return image.path;
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }
}
