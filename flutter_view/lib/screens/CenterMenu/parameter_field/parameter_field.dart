import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../Features/attribute_fields/models/dropdown_attribute_model.dart';
import '../../../constants.dart';

import '../../../Features/attribute_fields/providers/attributeProvider.dart';
import '../../../Features/attribute_fields/models/attribute_model.dart';
import '../../../Features/attribute_fields/widgets/dropdown_attribute_parameter_widget.dart';
import '../../../services/row_generator.dart';
import '../../../Features/attribute_fields/widgets/text_attribute_parameter_widget.dart';

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
    return Column(children: [
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
      Expanded(
        flex: 5,
        child: DragTarget(
          builder: ((BuildContext context, List<dynamic> accepted,
              List<dynamic> rejected) {
            if (targetData.isEmpty) {
              return Container(
                  height: 520,
                  width: MediaQuery.sizeOf(context).width / 2,
                  color: Colors.white,
                  child: const Center(
                      child: Text(
                    "Drag n' drop or double click to \n add new a Parameter.",
                    textAlign: TextAlign.center,
                  )));
            }
            return Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                // width: MediaQuery.sizeOf(context).width / 4,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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

                          return Dismissible(
                            key: key,
                            onDismissed: (DismissDirection direction) {
                              ref
                                  .read(attributeListProvider.notifier)
                                  .removeAttribute(index);
                            },
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              alignment: AlignmentDirectional.centerStart,
                              color: Colors.red,
                              child: const Padding(
                                padding:
                                    EdgeInsets.only(left: defaultPadding * 2),
                                child: Icon(
                                  Icons.cancel,
                                  size: 36,
                                ),
                              ),
                            ),
                            child: Builder(builder: (context) {
                              switch (item.type) {
                                case AttributeType.Dropdown:
                                  return DropdownParameterItemWidget(
                                      key: key,
                                      item: item as DropdownAttribute,
                                      index: index);
                                case AttributeType.Date:
                                  return TextParameterItemWidget(
                                    key: key,
                                    item: item,
                                    index: index,
                                    canType: false,
                                  );
                                default:
                                  return TextParameterItemWidget(
                                      key: key, item: item, index: index);
                              }
                            }),
                          );
                        },
                        // separatorBuilder: (context, index) => SizedBox(
                        //   height: 10,
                        // ),
                      ),
                    ],
                  ),
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
      ),
    ]);
  }
}
