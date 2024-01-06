import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import '../../popups/popupmanager.dart';

class PickFileHelper {
  BuildContext context;

  PickFileHelper(this.context);

  Future<File?> getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      if (file.lengthSync() > 3000001) {
        PopUpManager().errorPopup(context, "Dosya boyutu çok büyük");
      } else {
        //  uploadImage(file.path);
        return file;
      }
    } else {
      print("error");
      return null;
    }
    return null;
  }

  Future<File?> pickfile() async {
    var extensions = ["png", "jpeg"];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      if (!extensions.contains(file.path.split(".").last)) {
        PopUpManager().errorPopup(context,
            "Sadece resim dosyaları");
      } else if (file.lengthSync() > 2000001) {
        PopUpManager().errorPopup(context, "Dosya boyutu çok büyük.");
      } else {
        return file;
      }
    } else {
      print("error");
      return null;
    }
    return null;
  }
}