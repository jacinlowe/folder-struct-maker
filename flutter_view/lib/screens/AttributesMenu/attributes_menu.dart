import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants.dart';
import '../../Features/attribute_fields/providers/attributeProvider.dart';
import '../../Features/bored_api/consumer.dart';
import '../../Features/attribute_fields/models/attribute_model.dart';

class AttributesMenu extends StatefulHookConsumerWidget {
  AttributesMenu({super.key});

  final List<({String name, AttributeType type})> attributeText =
      attributeTypeList;

  @override
  ConsumerState<AttributesMenu> createState() => _AttributesMenuState();
}

class _AttributesMenuState extends ConsumerState<AttributesMenu> {
  bool isCollapsed = false;
  double _width = 300;

  void setCollapsed() {
    setState(() {
      _width = _width == 300 ? 75 : 300;
      isCollapsed = !isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (!isCollapsed) {
        return FullSizeView(
          attributeText: widget.attributeText,
          onTap: setCollapsed,
        );
      }
      return CollapsedView(onTap: setCollapsed);
    });
  }
}

ListTile customListTileBox(String itemText) {
  return ListTile(
    // contentPadding: const EdgeInsets.symmetric(
    //     horizontal: defaultPadding),
    tileColor: primaryColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Gap(defaultPadding * 2),
        Container(width: 4, height: 26, color: secondaryColor),
        const Gap(defaultPadding),
        Text(
          itemText,
          style: GoogleFonts.ubuntu(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    ),
    onTap: () {},
  );
}

class FullSizeView extends ConsumerWidget {
  final List<({String name, AttributeType type})> attributeText;
  final Function onTap;

  const FullSizeView({
    super.key,
    required this.attributeText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
        flex: 3,
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
                              onTap();
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
              Padding(
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
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: attributeText.length,
                          itemBuilder: (context, index) {
                            String itemText = attributeText[index].name;
                            AttributeType itemData = attributeText[index].type;
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
        ));
  }
}

class CollapsedView extends StatelessWidget {
  const CollapsedView({
    super.key,
    required this.onTap,
  });
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Gap(75),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: Container(
            alignment: Alignment.centerRight,
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: IconButton(
              icon: const Icon(Icons.menu_outlined),
              iconSize: 28,
              onPressed: () {
                onTap();
              },
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)))),
            ),
          ),
        ),
      ],
    )).animate().scaleX(alignment: Alignment.centerRight);
  }
}
