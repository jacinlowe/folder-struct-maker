import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as Path;

void main() async {
  final tempFolder = testCreateTempFolder();
  recursivelyCreateFolders(tempFolder, depth: 4);
  // await Future.wait([
  //   createFolder(tempFolder, 'test1'),
  //   createFolder(tempFolder, 'test2'),
  //   createFolder(tempFolder, 'test3'),
  //   createFolder(tempFolder, 'test4'),
  //   createFile(
  //     parentFolder: tempFolder,
  //     fileName: 'testFile1.txt',
  //     fileContent: null,
  //   ),
  //   copyFile(
  //       sourceFile:
  //           File(Path.join(tempFolder.parent.path, 'dummy project.aep')),
  //       destinationFile: Directory(Path.join(tempFolder.path, 'testCopy.aep')))
  // ]);
}

void recursivelyCreateFolders(Directory parentFolder,
    {required int depth}) async {
  final folderList = List.generate(
      4,
      (index) =>
          createFolder(parentFolder, 'depth_ $depth _test ${index + 1}'));

  for (var element in folderList) {
    if (depth <= 0) return;
    final result = await element;
    return recursivelyCreateFolders(result, depth: depth - 1);
  }
}

Directory testCreateTempFolder() {
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
  // print(currentDirectory);
  // print(rootFolder);
  // print(dummyFolder);
  if (dummyFolder.existsSync()) {
    print('creating Temp Folder: ${tempFolder.path}');
    tempFolder.createSync(recursive: true);
  }
  return tempFolder;
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

Future<Directory> createFolder(
    Directory? parentFolder, String folderName) async {
  if (parentFolder != null) {
    final Directory folderPath =
        Directory(Path.join(parentFolder.absolute.path, folderName));
    return await folderPath.create(recursive: true);
  } else {
    return await Directory(Path.join(Directory.current.path, folderName))
        .create(recursive: true);
  }
}

Future<File> createFile(
    {required Directory parentFolder,
    required String fileName,
    String? fileContent}) async {
  final String filePath = Path.join(parentFolder.absolute.path, fileName);
  final File file = File(filePath);
  if (!file.existsSync()) return await File(filePath).create(exclusive: true);
  return file;
}

Future<File> copyFile(
    {required File sourceFile, required Directory destinationFile}) async {
  if (!sourceFile.existsSync()) return Future.error(FileNotFoundException());
  return sourceFile.copy(destinationFile.path);
}

class FileNotFoundException extends FileSystemException {
  @override
  // TODO: implement message
  String get message => 'Source File not found $path ';
}
