import 'package:Folder_Struct_Maker/constants.dart';
import 'package:flutter/material.dart';

class ParameterField extends StatelessWidget {
  const ParameterField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
          child: Center(
            child: Text('Root Folder Name'),
          ),
        ),
        SizedBox(
          height: 550,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Table(
                  border: TableBorder.all(color: Colors.white30),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                        decoration: BoxDecoration(color: Colors.redAccent),
                        children: [
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Title 1'),
                              )),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Title 2'),
                              )),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Title 3'),
                              )),
                        ]),
                    ...List.generate(
                        20,
                        (index) => TableRow(children: [
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Cell 1'),
                                  )),
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Cell 2'),
                                  )),
                              TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Cell 3'),
                                  )),
                            ]))
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
