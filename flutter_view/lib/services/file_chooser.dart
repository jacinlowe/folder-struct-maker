import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

abstract class Failure {}

class NoDirectorySelected implements Failure {
  final String reason;
  const NoDirectorySelected({required this.reason});
}

class FileChooser {
  Future<Directory> getFolder() async {
    String? selectedFolder = await FilePicker.platform
        .getDirectoryPath(dialogTitle: 'Select the Parent Folder');
    debugPrint(selectedFolder);
    if (selectedFolder == null) {
      throw NoDirectorySelected(reason: 'User Did not select a directory');
    }
    return Directory(selectedFolder);
  }
}
