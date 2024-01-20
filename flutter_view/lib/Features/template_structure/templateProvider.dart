import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../attribute_fields/attributeProvider.dart';

part '../../generated/Features/template_structure/templateProvider.g.dart';

@riverpod
class TemplateProvider extends _$TemplateProvider {
  @override
  ExplorableNode build() {
    final rootName = ref.watch(attributeCombinerProvider);
    final updatedTree = tree;

    updatedTree.data!.name = rootName;

    return updatedTree;
  }

  List<Explorable> treeAsNestedList() {
    final rootNode = state;
    List<Explorable> result = [];

    void traverse(TreeNode node) {
      result.add(node.data);

      if (node.children.isNotEmpty) {
        for (var child in node.children.values) {
          traverse(child as TreeNode);
        }
      }
    }

    traverse(rootNode);
    return result;
  }

  traverseTree<T>(T Function(TreeNode) operation) {
    final rootNode = state;

    traverse<T>(TreeNode node, T Function(TreeNode) operation) {
      operation(node);
      var result;
      if (node.children.isNotEmpty) {
        for (var child in state.children.values) {
          result = traverse<T>(child as TreeNode, operation);
        }
      }
      return result;
    }

    return traverse<T>(rootNode, operation);
  }
}

abstract class Explorable {
  String name;
  final DateTime createdAt;

  Explorable(this.name) : this.createdAt = DateTime.now();

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

final tree = ExplorableNode.root(data: Folder('/root'))
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
