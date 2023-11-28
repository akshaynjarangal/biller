import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImagePickerService {

  Future<File?> pickImageFromDevice({required ImageSource source});
  
}