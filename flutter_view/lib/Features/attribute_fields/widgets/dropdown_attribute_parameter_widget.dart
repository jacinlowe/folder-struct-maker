import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/attribute_model.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/dropdown_attribute_model.dart';
import '../providers/attributeProvider.dart';
import '../../../constants.dart';

class DropdownParameterItemWidget extends StatefulHookConsumerWidget {
  final DropdownAttribute item;
  final int index;

  DropdownParameterItemWidget({
    required super.key,
    required this.item,
    required this.index,
  });

  @override
  ConsumerState<DropdownParameterItemWidget> createState() =>
      _ParameterItemWidgetState();
}

class _ParameterItemWidgetState
    extends ConsumerState<DropdownParameterItemWidget> {
  late final item = widget.item;

  late final key = widget.key;

  @override
  Widget build(BuildContext context) {
    bool readOnly = false;
    bool disabled = item.properties.useInPath;
    bool locked = item.properties.locked;
    List<String> selectableItems = item.selectableItems!;
    return SizedBox(
      key: key,
      // width: 900,
      height: 75,
      // color: Colors.blue[400],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: defaultPadding * 2,
          ),
          SizedBox(
            width: 70,
            child: Column(
              children: [
                Text(
                  attributeTypeList.firstWhere((e) => e.type == item.type).name,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                switch (locked) {
                  true => Switch(
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.grey[350],
                      value: disabled,
                      onChanged: (value) {}),
                  _ => Switch(
                      value: disabled,
                      onChanged: (value) {
                        if (!locked) {
                          setState(() {
                            ref
                                .read(attributeListProvider.notifier)
                                .changeUseInPath(widget.index);
                          });
                        }
                      }),
                },
              ],
            ),
          ),
          const SizedBox(
            width: defaultPadding,
          ),
          SizedBox(
            width: 250,
            height: 45,
            child: GestureDetector(
              onDoubleTap: () {
                if (!locked) {
                  setState(() => readOnly = !readOnly);
                  print(readOnly);
                }
              },
              child: TextField(
                key: key,
                readOnly: false,
                onChanged: (value) => ref
                    .read(attributeListProvider.notifier)
                    .updateAttribute(widget.index, name: value),
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    hintText: item.name,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
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
            child: DropdownMenu(
              width: 250,
              inputDecorationTheme: InputDecorationTheme(
                  isDense: true,
                  contentPadding: EdgeInsets.all(defaultPadding / 2),
                  constraints: BoxConstraints.tight(Size.fromHeight(45)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4))),
              initialSelection: item.defaultValue,
              dropdownMenuEntries: [
                ...List.from(selectableItems).mapIndexed((index, element) =>
                    DropdownMenuEntry(value: element, label: element)),
                DropdownMenuEntry(value: '', label: 'null')
              ],
              onSelected: (value) {
                setState(() {
                  item.selectedItem = value;
                  item.updateValue(value);
                  ref
                      .read(attributeListProvider.notifier)
                      .updateAttribute(widget.index, value: value);
                });
              },
            ),
          )
        ],
      ),
    ).animate(key: key).fadeIn().shimmer();
  }
}
