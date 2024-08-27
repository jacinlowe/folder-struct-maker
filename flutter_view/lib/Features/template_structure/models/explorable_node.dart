import 'package:animated_tree_view/animated_tree_view.dart';

abstract class Explorable {
  String name;
  final DateTime createdAt;

  Explorable(this.name) : createdAt = DateTime.now();

  @override
  String toString() => name;
}

class File extends Explorable {
  final String mimeType;

  File(super.name, {required this.mimeType});
  @override
  String toString() => '$name ($mimeType)';
}

class Folder extends Explorable {
  Folder(super.name);
}

typedef ExplorableNode = TreeNode<Explorable>;

typedef FileNode = TreeNode<File>;

typedef FolderNode = TreeNode<Folder>;
