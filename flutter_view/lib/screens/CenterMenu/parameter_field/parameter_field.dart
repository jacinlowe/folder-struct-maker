import 'package:Folder_Struct_Maker/Features/attribute_fields/AttributeTypes/attribute_model.dart';
import 'package:Folder_Struct_Maker/Features/attribute_fields/attributeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants.dart';
import '../../../services/row_generator.dart';

class ParameterField extends StatefulHookConsumerWidget {
  const ParameterField({
    super.key,
  });

  @override
  ConsumerState<ParameterField> createState() => _ParameterFieldState();
}

class _ParameterFieldState extends ConsumerState<ParameterField> {
  // List<String> targetData = [];
  @override
  Widget build(BuildContext context) {
    List<Attribute> targetData = ref.watch(attributeListProvider);
    final rowItems = ref.watch(rowGeneratorProvider);
    bool readOnly = true;
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
              child: Center(
                child: Text('Root Folder Name'),
              ),
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: defaultPadding * 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
              child: Center(
                child: Text('Parameter Name'),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
              child: Center(
                child: Text('Value'),
              ),
            ),
            SizedBox(
              width: 270,
            )
          ],
        ),
        // TableView(rowItems: rowItems),
        DragTarget(
          builder: ((BuildContext context, List<dynamic> accepted,
              List<dynamic> rejected) {
            if (targetData.isEmpty) {
              return Container(
                  height: 520,
                  width: MediaQuery.sizeOf(context).width / 2,
                  color: Colors.cyan,
                  child: const Center(child: Text('Empty')));
            }
            return Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                // width: MediaQuery.sizeOf(context).width / 4,
                child: Column(
                  children: [
                    ReorderableListView.builder(
                      onReorder: (oldIndex, newIndex) {
                        ref
                            .read(attributeListProvider.notifier)
                            .reorder(oldIndex, newIndex);
                      },
                      shrinkWrap: true,
                      itemCount: targetData.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = targetData[index];
                        final key = Key('$index');

                        return Container(
                          key: key,
                          // width: 900,
                          height: 75,
                          color: Colors.blue[400],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: defaultPadding * 2,
                              ),
                              SizedBox(
                                width: 70,
                                child: Column(
                                  children: [
                                    Text(
                                      attributeTypeList
                                          .firstWhere(
                                              (e) => e.type == item.type)
                                          .name,
                                      // item.type.name,
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Switch(
                                        value: true,
                                        onChanged: (value) => !value),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              SizedBox(
                                width: 250,
                                height: 45,
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    setState(() => readOnly = !readOnly);
                                    print(readOnly);
                                  },
                                  child: TextField(
                                    key: key,
                                    readOnly: false,
                                    onChanged: (value) => ref
                                        .read(attributeListProvider.notifier)
                                        .updateAttribute(index, name: value),
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        hintText: item.name,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4))),
                                  ),
                                ),
                              ),
                              SizedBox(
                                key: key,
                                width: defaultPadding / 2,
                              ),
                              SizedBox(
                                width: 250,
                                height: 45,
                                child: TextField(
                                  onChanged: (value) => ref
                                      .read(attributeListProvider.notifier)
                                      .updateAttribute(index, value: value),
                                  inputFormatters: [
                                    item.type == AttributeType.Number
                                        ? FilteringTextInputFormatter.digitsOnly
                                        : FilteringTextInputFormatter
                                            .singleLineFormatter
                                  ],
                                  key: key,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                      hintText: item.toString(),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                ),
                              ),
                            ],
                          ),
                        ).animate(key: key).fadeIn().shimmer();
                      },
                      // separatorBuilder: (context, index) => SizedBox(
                      //   height: 10,
                      // ),
                    ),
                  ],
                ),
              ),
            );
          }),
          onAccept: ((AttributeType data) {
            ref.watch(attributeListProvider.notifier).addAttribute(data);
          }),
          onWillAcceptWithDetails: (details) {
            return true;
          },
        ),
      ]),
    );
  }
}

class TableView extends StatelessWidget {
  const TableView({
    super.key,
    required this.rowItems,
  });

  final List<RowItems> rowItems;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Table(
              border: TableBorder.all(color: Colors.white30),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                    decoration: BoxDecoration(color: Colors.redAccent),
                    children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Text('Title 1'),
                          )),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Text('Title 2'),
                          )),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Title 3'),
                            ),
                          )),
                    ]),
                ...rowItems.map((e) => TableRow(children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Text(e.cell1),
                          )),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Text(e.cell2),
                          )),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.cell3),
                            ),
                          )),
                    ])),
                ...List.generate(
                    2,
                    (index) => const TableRow(children: [
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Center(
                                child: Text('Pre poped Cell 1'),
                              )),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Center(
                                child: Text('Pre poped Cell 2'),
                              )),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Pre poped Cell 3'),
                                ),
                              )),
                        ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
