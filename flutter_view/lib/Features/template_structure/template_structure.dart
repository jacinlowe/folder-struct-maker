import 'data/example_tree.dart';
import 'models/template_structure_model.dart';

List<TemplateStructure> templates = [
  TemplateStructure(name: 'name', structure: tree('nameyggyg')),
  TemplateStructure(name: 'Default Project', structure: tree('Default 1')),
  TemplateStructure(
      name:
          'Default Project with really long name to test extended names view in the dropdown menu',
      structure: tree('Default 2')),
  TemplateStructure(
      name: 'Default Project with long text to make sure we see it all',
      structure: tree('Default 3')),
  TemplateStructure(name: 'Default 4', structure: tree('Default 4')),
];
