import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/services/row_generator.g.dart';

@riverpod
class RowGenerator extends _$RowGenerator {
  @override
  List<RowItems> build() {
    return [];
  }

  void seedState() {
    if (state.isNotEmpty) return;
    state = List.generate(
        3,
        (index) => RowItems(
            cell1: 'cell1 $index',
            cell2: 'cell2 $index',
            cell3: 'cell3 $index'));
  }

  void addRow(RowItems row) {
    row.updateIndex(state.length - 1);
    state = [...state, row];
  }
}

class RowItems {
  String cell1;
  String cell2;
  String cell3;

  RowItems({required this.cell1, required this.cell2, required this.cell3});

  (String, String, String) get rowItems {
    return (cell1, cell2, cell3);
  }

  updateIndex(int index) {
    cell1 = '$cell1 ${index.toString()}';
    cell2 = '$cell2 ${index.toString()}';
    cell3 = '$cell3 ${index.toString()}';
  }
}
