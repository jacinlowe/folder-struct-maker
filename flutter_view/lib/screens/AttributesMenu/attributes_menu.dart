import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class AttributesMenu extends StatefulWidget {
  const AttributesMenu({super.key});

  @override
  State<AttributesMenu> createState() => _AttributesMenuState();
}

class _AttributesMenuState extends State<AttributesMenu> {
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
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Row(
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
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.menu_open_outlined),
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
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: attributeText.length,
                          itemBuilder: (context, index) {
                            String itemText = attributeText[index];
                            return Material(
                              type: MaterialType.transparency,
                              child: ListTile(
                                // contentPadding: const EdgeInsets.symmetric(
                                //     horizontal: defaultPadding),
                                tileColor: primaryColor,
                                title: Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: defaultPadding * 2,
                                      ),
                                      Container(
                                          width: 4,
                                          height: 26,
                                          color: secondaryColor),
                                      SizedBox(
                                        width: defaultPadding,
                                      ),
                                      Text(
                                        itemText,
                                        style: GoogleFonts.ubuntu(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {},
                              ),
                            );
                          }),
                      const SizedBox(height: defaultPadding / 2),
                    ]),
              )
            ],
          ),
        )).animate().scaleX();
  }
}

final List<String> attributeText = [
  'Date',
  'Number',
  'Loop',
  "Saveable Field",
  'Dropdown',
  'User Name',
  'Custom Text'
];
