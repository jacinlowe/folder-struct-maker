import 'package:Folder_Struct_Maker/constants.dart';
import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TreeViewMenu extends StatelessWidget {
  const TreeViewMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: secondaryColor2,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
      child: Column(
        children: [
          Row(
            children: [
              RotatedBox(
                quarterTurns: 2,
                child: IconButton(
                  icon: Icon(
                    Icons.menu_open_outlined,
                    color: Colors.white54,
                  ),
                  iconSize: 28,
                  onPressed: () {},
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Spacer(),
              Text(
                'Preview',
                style: GoogleFonts.ubuntu(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              Spacer()
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TreeView.simpleTyped<Explorable, TreeNode<Explorable>>(
                tree: tree,
                showRootNode: true,
                expansionBehavior: ExpansionBehavior.scrollToLastChild,
                expansionIndicatorBuilder: (context, node) {
                  if (node.isRoot)
                    return PlusMinusIndicator(
                      tree: node,
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                    );

                  return ChevronIndicator.rightDown(
                    tree: node,
                    alignment: Alignment.centerLeft,
                    color: Colors.white,
                  );
                },
                indentation: const Indentation(),
                builder: (context, node) => Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ListTile(
                    title: Text(
                      node.data?.name ?? "N/A",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      formatDate(node.data?.createdAt),
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: node.icon,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String formatDate(DateTime? date) {
  if (date == null) return 'N/A';
  return DateFormat('dd/MM/yyyy kk:mm a').format(date);
}

extension on ExplorableNode {
  Icon get icon {
    if (isRoot) return Icon(Icons.data_object, color: Colors.white);

    if (this is FolderNode) {
      if (isExpanded) return Icon(Icons.folder_open, color: Colors.white);
      return Icon(Icons.folder, color: Colors.white);
    }

    if (this is FileNode) {
      final file = this.data as File;
      if (file.mimeType.startsWith("image"))
        return Icon(
          Icons.image,
          color: Colors.white,
        );
      if (file.mimeType.startsWith("video"))
        return Icon(Icons.video_file, color: Colors.white);
    }

    return Icon(Icons.insert_drive_file, color: Colors.white);
  }
}

abstract class Explorable {
  final String name;
  final DateTime createdAt;

  Explorable(this.name) : this.createdAt = DateTime.now();

  @override
  String toString() => name;
}

class File extends Explorable {
  final String mimeType;

  File(super.name, {required this.mimeType});
}

class Folder extends Explorable {
  Folder(super.name);
}

typedef ExplorableNode = TreeNode<Explorable>;

typedef FileNode = TreeNode<File>;

typedef FolderNode = TreeNode<Folder>;

final tree = TreeNode<Explorable>.root(data: Folder("/root"))
  ..addAll([
    FolderNode(data: Folder("Documents"))
      ..addAll([
        FileNode(
          data: File("report.doc", mimeType: "application/msword"),
        ),
        FileNode(
          data: File("budget.xls", mimeType: "application/vnd.ms-excel"),
        ),
        FileNode(
          data: File("training.ppt", mimeType: "application/vnd.ms-powerpoint"),
        )
      ]),
    FolderNode(data: Folder("Media"))
      ..addAll([
        FolderNode(data: Folder("Pictures"))
          ..addAll([
            FileNode(data: File("birthday_1.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("birthday_2.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("birthday_3.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("birthday_4.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("birthday_5.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("birthday_6.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("birthday_7.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("birthday_8.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("birthday_9.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("lunch_1.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("lunch_2.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("lunch_3.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("lunch_4.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("lunch_5.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("lunch_6.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("lunch_7.jpg", mimeType: "image/jpeg")),
            FileNode(data: File("banner.png", mimeType: "image/png")),
          ]),
        FolderNode(data: Folder("Videos"))
          ..addAll([
            FolderNode(data: Folder("Birthday_23"))
              ..addAll([
                FileNode(
                    data: File("birthday_23_1.mp4", mimeType: "video/mp4")),
                FileNode(
                    data: File("birthday_23_2.mp4", mimeType: "video/mp4")),
              ]),
            FolderNode(data: Folder("vacation_ibiza"))
              ..addAll([
                FileNode(data: File("snorkeling.mp4", mimeType: "video/mp4")),
                FileNode(data: File("scuba.mp4", mimeType: "video/mp4")),
              ])
          ])
      ]),
    FolderNode(data: Folder("System"))
      ..addAll([
        FolderNode(data: Folder("temp")),
        FolderNode(data: Folder("apps"))
          ..addAll([
            FileNode(
              data: File("word.exe", mimeType: "application/win32_exe"),
            ),
            FileNode(
              data: File("powerpoint.exe", mimeType: "application/win32_exe"),
            ),
            FileNode(
              data: File("excel.exe", mimeType: "application/win32_exe"),
            ),
          ]),
        FileNode(
          data: File("sys.exe", mimeType: "application/win32_exe"),
        ),
        FileNode(
          data: File("config.exe", mimeType: "application/win32_exe"),
        )
      ]),
  ]);
