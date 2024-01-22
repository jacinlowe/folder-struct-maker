import 'package:Folder_Struct_Maker/Features/attribute_fields/providers/attributeProvider.dart';
import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_table_view/material_table_view.dart';

import '../../../Features/attribute_fields/models/attribute_model.dart';
import '../../../Features/attribute_fields/models/date_attribute_model.dart';
import '../../../Features/attribute_fields/models/date_enums.dart';
import '../../../constants.dart';

class OptionsParamField extends StatefulHookConsumerWidget {
  const OptionsParamField({super.key});

  @override
  ConsumerState<OptionsParamField> createState() => _OptionsParamFieldState();
}

class _OptionsParamFieldState extends ConsumerState<OptionsParamField> {
  @override
  Widget build(BuildContext context) {
    final List<Attribute> items = ref.watch(attributeListProvider);
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
      Container(
        margin: const EdgeInsets.all(defaultPadding),
        child: SizedBox(
          height: 500,
          width: double.infinity,
          child: TableView.builder(
              rowCount: items.length,
              rowHeight: 75.0 + 4 * Theme.of(context).visualDensity.vertical,
              headerHeight: 30,
              style: const TableViewStyle(
                  scrollPadding: EdgeInsets.all(defaultPadding / 4)),
              headerBuilder: (context, contentBuilder) {
                return contentBuilder(
                  context,
                  (context, column) => Container(
                    child: Center(
                      child: Text(
                        optionTitles[column],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                );
              },
              columns: [
                for (final (index, _) in optionTitles.indexed)
                  index <= 2
                      ? const TableColumn(width: 200.0, freezePriority: 100)
                      : const TableColumn(
                          width: 105.0,
                        ),
              ],
              rowBuilder: (context, row, contentBuilder) {
                Attribute item = items[row];
                return switch (item.type) {
                  AttributeType.Number => NumberRowBuilder(
                      context: context,
                      row: row,
                      contentBuilder: contentBuilder,
                      item: item,
                    ),
                  AttributeType.Date => DateRowBuilder(
                      context: context,
                      row: row,
                      contentBuilder: contentBuilder,
                      item: item),
                  _ => OptionsRowBuilder(
                      context: context,
                      row: row,
                      contentBuilder: contentBuilder,
                      item: item,
                    ),
                };
              }),
        ),
      )
    ]);
  }
}

class OptionsRowBuilder extends HookConsumerWidget {
  final BuildContext context;

  final Widget Function(BuildContext, Widget Function(BuildContext, int))
      contentBuilder;

  final int row;
  final Attribute item;

  const OptionsRowBuilder({
    super.key,
    required this.context,
    required this.row,
    required this.contentBuilder,
    required this.item,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 4),
      child: contentBuilder(context, (context, column) {
        List<bool> itemOptionStates = item.properties.toList();
        return switch (column) {
          0 => SizedBox(
              width: 190,
              height: 60,
              child: TextField(
                readOnly: false,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    hintText: 'Parameter Name',
                    labelText: item.name,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
            ),
          1 => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: DropdownMenu(
                  width: 185,
                  initialSelection: item.type,
                  dropdownMenuEntries: [
                    ...AttributeType.values.mapIndexed((index, element) =>
                        DropdownMenuEntry(
                            value: element, label: element.readableName)),
                  ]),
            ),
          2 => SizedBox(
              width: 190,
              height: 60,
              child: TextField(
                readOnly: false,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    hintText: 'Default Value',
                    labelText: item.defaultValue,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
            ),
          _ =>
            Switch(value: itemOptionStates[column - 3], onChanged: (value) {})
        };
      }),
    );
  }
}

class NumberRowBuilder extends OptionsRowBuilder {
  const NumberRowBuilder(
      {super.key,
      required super.context,
      required super.row,
      required super.contentBuilder,
      required super.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.all(defaultPadding / 4),
        child: contentBuilder(context, (context, column) {
          List<bool> itemOptionStates = item.properties.toList();
          return switch (column) {
            0 => SizedBox(
                width: 190,
                height: 60,
                child: TextField(
                  readOnly: false,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                      hintText: 'Parameter Name',
                      labelText: item.name,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                ),
              ),
            1 => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: DropdownMenu(
                    width: 185,
                    initialSelection: item.type,
                    dropdownMenuEntries: [
                      ...AttributeType.values.mapIndexed((index, element) =>
                          DropdownMenuEntry(
                              value: element, label: element.readableName)),
                    ]),
              ),
            2 => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 190 / 2,
                    height: 60,
                    child: TextField(
                      readOnly: false,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                          labelText: '001',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4))),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Auto Increment',
                        style: TextStyle(fontSize: 12),
                      ),
                      Switch(value: true, onChanged: (value) {})
                    ],
                  )
                ],
              ),
            _ =>
              Switch(value: itemOptionStates[column - 3], onChanged: (value) {})
          };
        }));
  }
}

class DateRowBuilder extends OptionsRowBuilder {
  const DateRowBuilder(
      {super.key,
      required super.context,
      required super.row,
      required super.contentBuilder,
      required super.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(ref.watch(attributeListProvider.notifier).getItem(item: item));

    final dateItem = item as DateAttribute;
    return Padding(
        padding: const EdgeInsets.all(defaultPadding / 4),
        child: contentBuilder(context, (context, column) {
          List<bool> itemOptionStates = item.properties.toList();
          return switch (column) {
            0 => SizedBox(
                width: 190,
                height: 60,
                child: TextField(
                  readOnly: false,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                      hintText: 'Parameter Name',
                      labelText: dateItem.name,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                ),
              ),
            1 => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: DropdownMenu(
                    width: 185,
                    initialSelection: dateItem.type,
                    dropdownMenuEntries: [
                      ...AttributeType.values.mapIndexed((index, element) =>
                          DropdownMenuEntry(
                              value: element, label: element.readableName)),
                    ]),
              ),
            2 => DropdownMenu(
                  width: 200,
                  textStyle: const TextStyle(
                      overflow: TextOverflow.ellipsis, wordSpacing: -2),
                  initialSelection: dateItem.dateFormatType.format,
                  dropdownMenuEntries: [
                    ...DateFormats.values.mapIndexed((index, element) =>
                        DropdownMenuEntry(
                            value: element.format,
                            label: '${element.name}:\n ${element.example}')),
                  ]),
            _ =>
              Switch(value: itemOptionStates[column - 3], onChanged: (value) {})
          };
        }));
  }
}

final List<String> optionTitles = [
  'Parameter Name',
  'Type',
  'Default value',
  'Save History',
  'Folder Break',
  'Use in Path',
  'Locked',
  'Required',
];
