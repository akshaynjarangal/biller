import 'dart:developer';
import 'dart:io';
import 'package:biller/src/data/service/abstraction/image_pick_service.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickImpl implements ImagePickerService {

  @override
  Future<File?> pickImageFromDevice({required ImageSource source}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        return File(image.path);
      } else {
        return null;
      }
    } catch (e) {
      log("Error $e");
      return null;
    }
  }
}
