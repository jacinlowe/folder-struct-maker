import 'dart:io';
import 'package:Folder_Struct_Maker/Features/template_structure/templateProvider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Features/attribute_fields/providers/attributeProvider.dart';
import '../file_io.dart';

part '../../generated/services/create_project/create_project_provider.g.dart';

@riverpod
class CreateProject extends _$CreateProject {
  @override
  void build() {}

  void createProject({required Directory parentFolder}) {
    try {
      print(ref.read(templateProviderProvider.notifier).treeAsNestedList());
    } catch (e) {
      print("Exception: $e");
      return;
    }

    final projectFolderName = ref.read(projectTitleProvider);
    projectFolderName.isNotEmpty
        ? createFolder(parentFolder, projectFolderName)
        : createFolder(parentFolder, 'test12');
  }
}
