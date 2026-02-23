import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/core/services/image_upload_service.dart';

class ImageUtils {
  static Future customImagePicker() async {
    File file;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      Map fileProp = getFileSizeString(bytes: result.files.single.size);
      if (fileProp["imageSize"] >= 2.0 && fileProp["imageSuff"] == "MB") {
        print("The uploaded image size is${fileProp["imageSize"]}");
        // showErrorToast(ResString.imageSizeMeg);
        return '';
      }
      // if(fileSize >= )
      file = File(result.files.single.path.toString());
      print(file.toString());
      return file;
    } else {
      return '';
      // User canceled the picker
    }
  }

  static Map getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) {
      Map imageProp = {"imageSize": "0", "imageSuff": "Bytes"};
      return imageProp;
    }
    const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    Map imageProp = {
      "imageSize": double.parse(
        (bytes / pow(1024, i)).toStringAsFixed(decimals),
      ),
      "imageSuff": suffixes[i],
    };
    return imageProp;
  }

  static getFileSizeFromPath({
    required String filepath,
    int decimals = 1,
  }) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) {
      Map imageProp = {"imageSize": "0", "imageSuff": "Bytes"};
      return imageProp;
    }
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    Map imageProp = {
      "imageSize": double.parse(
        (bytes / pow(1024, i)).toStringAsFixed(decimals),
      ),
      "imageSuff": suffixes[i],
    };
    return imageProp;
  }

  static Future customCameraPicker() async {
    File file;
    final ImagePicker picker = ImagePicker();

    final XFile? result = await picker.pickImage(source: ImageSource.camera);
    if (result != null) {
      Map fileProp = await getFileSizeFromPath(filepath: result.path);
      if (fileProp["imageSize"] >= 10.0 && fileProp["imageSuff"] == "MB") {
        print("The uploaded image size is${fileProp["imageSize"]}");
        // showErrorToast(ResString.imageSizeMeg);
        return '';
      } else {
        file = File(result.path.toString());
        return file;
      }
    } else {
      return '';
      // User canceled the picker
    }
  }

  static Future<String> uploadImagesToServers({
    required File image,
    required String apiUrl,
  }) async {
    final imageUploadService = GetIt.instance.get<ImageUploadService>();
    try {
      var result = await imageUploadService.imageUpload(
        image: image,
        apiUrl: apiUrl,
      );
      result.fold(
        (l) {
          return l;
        },
        (r) {
          return '';
        },
      );
      return '';
    } catch (e) {
      return '';
    }
  }
}
