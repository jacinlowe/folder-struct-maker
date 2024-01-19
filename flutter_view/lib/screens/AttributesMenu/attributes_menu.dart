import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants.dart';
import '../../Features/attribute_fields/attributeProvider.dart';
import '../../Features/bored_api/consumer.dart';
import '../../Features/attribute_fields/AttributeTypes/attribute_model.dart';

class AttributesMenu extends StatefulHookConsumerWidget {
  AttributesMenu({super.key});
  final List<({String name, AttributeType type})> attributeText =
      attributeTypeList;

  @override
  ConsumerState<AttributesMenu> createState() => _AttributesMenuState();
}

class _AttributesMenuState extends ConsumerState<AttributesMenu> {
  int flexNumber = 4;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flexNumber,
        child: Container(
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.logo_dev,
                            size: 65,
                          ),
                          Text(
                            'Folder Struct',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.menu_open_outlined),
                            iconSize: 28,
                            onPressed: () {
                              setState(() {
                                flexNumber = flexNumber == 2 ? 4 : 2;
                              });
                            },
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5)))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Attributes',
                          style: GoogleFonts.ubuntu(
                              fontSize: 34,
                              fontWeight: FontWeight.w600,
                              color: Colors.black))
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.attributeText.length,
                          itemBuilder: (context, index) {
                            String itemText = widget.attributeText[index].name;
                            AttributeType itemData =
                                widget.attributeText[index].type;
                            return GestureDetector(
                              onDoubleTap: () {
                                ref
                                    .read(attributeListProvider.notifier)
                                    .addAttribute(itemData);
                              },
                              child: Draggable(
                                data: itemData,
                                feedback: Container(
                                  width: 150,
                                  height: 50,
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      itemText,
                                      style: GoogleFonts.ubuntu(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: customListTileBox(itemText),
                                ),
                              ),
                            );
                          }),
                      const SizedBox(height: defaultPadding / 2),
                    ]),
              ),
              const Spacer(),
              const ActivityWidget()
            ],
          ),
        )).animate().scaleX();
  }

  ListTile customListTileBox(String itemText) {
    return ListTile(
      // contentPadding: const EdgeInsets.symmetric(
      //     horizontal: defaultPadding),
      tileColor: primaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: defaultPadding * 2,
          ),
          Container(width: 4, height: 26, color: secondaryColor),
          const SizedBox(
            width: defaultPadding,
          ),
          Text(
            itemText,
            style:
                GoogleFonts.ubuntu(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
