import 'attribute_model.dart';

class DropdownAttribute extends Attribute<String> {
  List<String>? selectableItems;

  String? selectedItem;

  DropdownAttribute(this.selectableItems,
      {required String super.id,
      required String super.name,
      required AttributeProperties super.properties})
      : super(type: AttributeType.Dropdown) {
    selectableItems = [];
    selectedItem = null;
  }

  @override
  String get value => selectedItem ?? '';

  @override
  String get defaultValue => selectedItem ?? '';

  @override
  String toString() {
    return value;
  }

  void addSelectableItem(String val) {
    if (!selectableItems!.contains(val)) {
      selectableItems!.add(val);
    }
    return;
  }

  void updateSelectableItem(String previousVal, String val) {
    if (!selectableItems!.contains(previousVal)) {
      throw Exception('Item doesnt exists');
    }
    final index = selectableItems!.indexOf(previousVal);
    selectableItems![index] = val;
  }

  void removeSelectableItem(int? index, String? val) {
    if (selectableItems!.isEmpty) {
      throw Exception('No items in SelectableItems');
    }
    if (index == null && val == null) {
      throw Exception('Please provide either an index or a value');
    } else if (index != null) {
      if (index > selectableItems!.length) {
        throw Exception('Index out of bounds');
      } else {
        selectableItems!.removeAt(index);
      }
    } else if (val != null) {
      if (selectableItems!.contains(val)) {
        selectableItems!.remove(val);
      } else {
        throw Exception('Item doesnt exist');
      }
    }
  }

  void clearSelectableItems() {
    selectableItems!.clear();
  }

  @override
  void updateDefaultValue(String newDefaultValue) {
    if (!selectableItems!.contains(newDefaultValue)) {
      throw Exception('Not a valid selection');
    } else {
      selectedItem = newDefaultValue;
    }
  }

  @override
  void updateValue(String newValue) {
    if (!selectableItems!.contains(newValue)) {
      throw Exception('Not a valid selection');
    } else {
      selectedItem = newValue;
    }
  }
}
