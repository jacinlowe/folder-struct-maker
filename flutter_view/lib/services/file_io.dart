import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:path/path.dart' as Path;

void main() {
  var pathMap = Path.joinAll([
    'D:',
    'CODE_PLAYGROUND',
    'folder-struct-maker',
    'dummy data',
    'dummy project.aep'
  ]);
  var myFile = File(pathMap);
  // myFile.copy(newPath)
  final Directory currentDirectory = Directory.current;
  final Directory rootFolder = Directory(currentDirectory.path).parent;
  final Directory dummyFolder =
      Directory(Path.join(rootFolder.path, 'dummy data'));
  final Directory tempFolder =
      Directory(Path.join(dummyFolder.path, 'tempFolder'));
  print('sys temp location: ${Directory.systemTemp}');
  print(currentDirectory);
  print(rootFolder);
  print(dummyFolder);
  if (dummyFolder.existsSync()) {
    Directory(Path.join(dummyFolder.path, 'tempFolder')).create();
  }

  // myFile.readAsBytes().then((Uint8List contents) => print(contents));
}

Directory getTempDir() {
  final Directory currentDirectory = Directory.current;
  final Directory rootFolder = Directory(currentDirectory.path).parent;
  final Directory dummyFolder =
      Directory(Path.join(rootFolder.path, 'dummy data'));
  final Directory tempFolder =
      Directory(Path.join(dummyFolder.path, 'tempFolder'));
  if (dummyFolder.existsSync()) {
    Directory(Path.join(dummyFolder.path, 'tempFolder')).create();
  }
  return tempFolder;
}

void testNode() {
  final rootNode = Node();
  rootNode
      .addChild(Node(parent: null, children: [], data: 'Jacin Lowe Folder'));
}

class Node {
  Node? parent;
  List<Node> _children = List.empty(growable: true);
  String id = Random.secure().toString();
  dynamic data;

  Node({dynamic data, parent, children});

  String toString() {
    return data.toString();
  }

  addChild(Node child) {
    _children.add(child);
  }

  removeChild(Node child) {
    if (_children.isEmpty) throw Exception('Node has no children');
    bool result = _children.remove(child);
    if (!result) throw Exception('Could not remove child');
  }

  int _getDepth(List<Node> node, {int depth = 0}) {
    if (node.isEmpty) return 0;
    depth++;
    node.forEach((element) {
      depth = max(depth, element._getDepth(element._children, depth: depth));
    });
    return depth;
  }

  int get depth {
    return _getDepth(_children);
  }
}

class NoChildrenException implements Exception {
  NoChildrenException([message]);
}

class TreeNode {
  List<TreeNode> children = [];

  void addChild(TreeNode child) {
    children.add(child);
  }
}

void createFolderStruct(Map<String, dynamic> struct) {
  final tempDir = getTempDir();
  final rootFolder = struct.entries.first;
  final currentFolder = Directory(Path.join(tempDir.path, rootFolder.key));
  currentFolder.createSync(recursive: true);

  createDir(parent, subItem) {
    // if (folder.)
  }
  if (rootFolder.value.runtimeType is List && rootFolder.value.length >= 1) {
    //walk the list and check for folders or if file generate file.

    rootFolder.value.forEach((subItem) => {
          if (subItem.runtimeType == String)
            {
              //This is a file
            }
          else
            {
              //this is a folder
              // subItem.key;
            }
        });
  }
}

final Map<String, dynamic> folderStructure = {
  'folder name 1': [
    'file1.txt',
    'file2.txt',
    'file3.txt',
    'file4.txt',
    {'Subfolder 2': []},
  ]
};
