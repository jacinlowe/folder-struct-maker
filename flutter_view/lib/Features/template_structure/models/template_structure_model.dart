import 'package:animated_tree_view/tree_view/tree_node.dart';

import 'explorable_node.dart';

class TemplateStructure {
  String name;
  ExplorableNode? structure;
  TemplateStructure({required this.name, this.structure});

  String getTemplateName() {
    return name;
  }

  void updateTemplateName(String newName) {
    name = newName;
  }

  List<Explorable> treeAsNestedList() {
    final rootNode = structure!;
    List<Explorable> result = [];

    void traverse(ExplorableNode node) {
      result.add(node.data!);

      if (node.children.isNotEmpty) {
        for (var child in node.children.values) {
          traverse(child as ExplorableNode);
        }
      }
    }

    traverse(rootNode);
    return result;
  }

  traverseTree<T>(T Function(TreeNode) operation) {
    if (structure == null) {
      throw Exception('No structure to traverse');
    }
    final rootNode = structure!;

    traverse<T>(TreeNode node, T Function(TreeNode) operation) {
      operation(node);
      var result;
      if (node.children.isNotEmpty) {
        for (var child in structure!.children.values) {
          result = traverse<T>(child as TreeNode, operation);
        }
      }
      return result;
    }

    return traverse<T>(rootNode, operation);
  }
}
