import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/attribute_model.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/attributeProvider.dart';
import '../../../constants.dart';

class TextParameterItemWidget extends StatefulHookConsumerWidget {
  final Attribute<dynamic> item;
  final int index;
  bool canType;

  TextParameterItemWidget(
      {required super.key,
      required this.item,
      required this.index,
      this.canType = true});

  @override
  ConsumerState<TextParameterItemWidget> createState() =>
      _ParameterItemWidgetState();
}

class _ParameterItemWidgetState extends ConsumerState<TextParameterItemWidget> {
  late final item = widget.item;

  late final key = widget.key;

  @override
  Widget build(BuildContext context) {
    bool readOnly = false;
    bool disabled = item.properties.useInPath;
    bool locked = item.properties.locked;
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
                FittedBox(
                  child: AutoSizeText(
                    attributeTypeList
                        .firstWhere((e) => e.type == item.type)
                        .name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    minFontSize: 8,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
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
            child: TextField(
              readOnly: !widget.canType,
              // enabled: widget.canType,
              onChanged: (value) {
                ref
                    .read(attributeListProvider.notifier)
                    .updateAttribute(widget.index, value: value);
                //print(value);
              },
              inputFormatters: [
                item.type == AttributeType.Number
                    ? FilteringTextInputFormatter.digitsOnly
                    : FilteringTextInputFormatter.singleLineFormatter
              ],
              key: key,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                  hintText: item.toString(),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4))),
            ),
          )
        ],
      ),
    ).animate(key: key).fadeIn().shimmer();
  }
}
