import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../models/main_side_list.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: primaryColor,
          child: Column(children: [
            SizedBox(
              height: defaultPadding * 3,
            ),
            RichText(
                text: TextSpan(
                    text: "Beauty".toUpperCase(),
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                    children: <TextSpan>[
                  TextSpan(
                      text: 'date'.toUpperCase(),
                      style: GoogleFonts.ubuntu(
                          color: secondaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w600))
                ])),
            SizedBox(
              height: defaultPadding * 2,
            ),
            Expanded(
              child: SizedBox(
                height: 350,
                child: ListView.builder(
                    itemCount: mainSideList1.length,
                    itemBuilder: (context, index) {
                      return mSideList1(index, mainSideList1[index]);
                    }),
              ),
            ),
            SizedBox(
              height: defaultPadding * 2,
            ),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                    itemCount: mainSideList2.length,
                    itemBuilder: (context, index) {
                      return mSideList2(index, mainSideList2[index]);
                    }),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Color changeColors(index, color1, color2) {
    return index != null && _selectedIndex == index ? color1 : color2;
  }

  Container mSideList1(int index, MainSideList mainSideList) {
    return Container(
      decoration: BoxDecoration(
          color: changeColors(
            mainSideList.index,
            Color(0xFFCCEDDD),
            Colors.transparent,
          ),
          gradient: LinearGradient(
              colors: [secondaryColor2, secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          hoverColor: Color(0xFFFF),
          onTap: () {
            setState(() {
              _selectedIndex = mainSideList.index;
            });
          },
          leading: Padding(
            padding: const EdgeInsets.only(left: defaultPadding * 1.5),
            child: SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                mainSideList.icon,
                color: changeColors(
                    mainSideList.index, Colors.white, Colors.white54),
              ),
            ),
          ),
          title: Text(
            mainSideList.title,
            style: GoogleFonts.ubuntu(
                color: changeColors(
                    mainSideList.index, Colors.white, Colors.white54),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Container mSideList2(int index, MainSideList mainSideList) {
    return Container(
      decoration: BoxDecoration(
          color: changeColors(
            mainSideList.index,
            Color(0xFFCCEDDD),
            Colors.transparent,
          ),
          gradient: LinearGradient(
              colors: [secondaryColor2, secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          hoverColor: Color(0xFFFF),
          onTap: () {
            setState(() {
              _selectedIndex = mainSideList.index;
            });
          },
          leading: Padding(
            padding: const EdgeInsets.only(left: defaultPadding * 1.5),
            child: SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                mainSideList.icon,
                color: changeColors(
                    mainSideList.index, Colors.white, Colors.white54),
              ),
            ),
          ),
          title: Text(
            mainSideList.title,
            style: GoogleFonts.ubuntu(
                color: changeColors(
                    mainSideList.index, Colors.white, Colors.white54),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
