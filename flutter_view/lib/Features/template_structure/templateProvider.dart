import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:post_composer/Features/template_structure/models/template_structure_model.dart';
import 'package:post_composer/Features/template_structure/template_structure.dart';
import 'template_name.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../attribute_fields/providers/attributeProvider.dart';
import 'data/example_tree.dart';
import 'models/explorable_node.dart';

part '../../generated/Features/template_structure/templateProvider.g.dart';

@riverpod
class TemplateProvider extends _$TemplateProvider {
  @override
  TemplateStructure build() {
    final selectedTemplate = ref.watch(selectedTemplateNameProvider);
    return templates.firstWhere((element) => element.name == selectedTemplate);
  }
}
