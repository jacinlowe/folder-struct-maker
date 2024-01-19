import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/appbar_menu_items.dart';

Iterable<Material> actionItems =
    AppbarMenuItemEnum.values.mapIndexed((index, element) {
  return Material(
    type: MaterialType.transparency,
    child: TextButton(
        onPressed: () {},
        child: Text(
          element.name,
          style: GoogleFonts.ubuntu(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
        )),
  );
});
