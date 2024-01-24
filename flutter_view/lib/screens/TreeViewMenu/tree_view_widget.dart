import '../../constants.dart';
import 'package:animated_tree_view/animated_tree_view.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../Features/attribute_fields/providers/attributeProvider.dart';
import '../../Features/template_structure/templateProvider.dart';

class TreeViewWidget extends StatefulHookConsumerWidget {
  const TreeViewWidget({super.key});

  @override
  ConsumerState<TreeViewWidget> createState() => _TreeViewWidgetState();
}

class _TreeViewWidgetState extends ConsumerState<TreeViewWidget> {
  @override
  Widget build(BuildContext context) {
    final rootName = ref.watch(attributeCombinerProvider);
    final tree = ref.watch(templateProviderProvider);
    return TreeView.simpleTyped<Explorable, TreeNode<Explorable>>(
      tree: tree,
      showRootNode: true,
      expansionBehavior: ExpansionBehavior.scrollToLastChild,
      onTreeReady: (controller) =>
          controller.expandAllChildren(tree, recursive: true),
      expansionIndicatorBuilder: (context, node) {
        if (node.isRoot) {
          return PlusMinusIndicator(
            tree: node,
            alignment: Alignment.centerLeft,
            color: Colors.white,
          );
        }

        return ChevronIndicator.rightDown(
          tree: node,
          alignment: Alignment.centerLeft,
          color: Colors.white,
        );
      },
      indentation: const Indentation(),
      builder: (context, node) {
        String name = node.data?.name ?? "N/A";

        return Padding(
          padding: const EdgeInsets.only(left: defaultPadding / 2),
          child: ListTile(
            dense: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            title: Text(
              name != '/root'
                  ? name
                  : rootName == ''
                      ? '/root'
                      : rootName,
              style: TextStyle(color: Colors.white),
            ),
            // subtitle: Text(
            //   formatDate(node.data?.createdAt),
            //   style: TextStyle(color: Colors.white),
            // ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: node.icon,
            ),
          ),
        );
      },
    );
  }
}

String formatDate(DateTime? date) {
  if (date == null) return 'N/A';
  return DateFormat('dd/MM/yyyy kk:mm a').format(date);
}

ExplorableNode treeData(ref) {
  return ExplorableNode.root(
      data: Folder(ref.watch(attributeCombinerProvider)));
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
      if (file.mimeType.startsWith('application'))
        return Icon(
          Icons.terminal,
          color: Colors.white,
        );
    }

    return Icon(Icons.insert_drive_file, color: Colors.white);
  }
}
