import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DraggableTest extends StatefulWidget {
  const DraggableTest({super.key});

  @override
  State<DraggableTest> createState() => _DraggableTestState();
}

class _DraggableTestState extends State<DraggableTest> {
  List<String> targetData = [];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Draggable(
              data: 'We are the world',
              child: Container(
                height: 100,
                width: 100,
                color: Colors.amber[100],
              ),
              childWhenDragging: Container(
                height: 100,
                width: 100,
                color: Colors.grey[300],
              ),
              feedback: Container(
                height: 100,
                width: 100,
                color: Colors.amber[100],
              ),
            )
          ],
        ),
        SizedBox(
          width: 200,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DragTarget(
              builder: ((BuildContext context, List<dynamic> accepted,
                  List<dynamic> rejected) {
                if (targetData.isEmpty) {
                  return SafeArea(
                    minimum: EdgeInsets.all(10),
                    child: Container(
                        height: MediaQuery.of(context).size.height / 1.2,
                        width: MediaQuery.sizeOf(context).width / 4,
                        color: Colors.cyan,
                        child: Center(child: Text('Empty'))),
                  );
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.2,
                  width: MediaQuery.sizeOf(context).width / 4,
                  child: Column(
                    children: [
                      ReorderableListView.builder(
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) newIndex--;
                            final item = targetData.removeAt(oldIndex);
                            targetData.insert(newIndex, item);
                          });
                        },
                        shrinkWrap: true,
                        itemCount: targetData.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = targetData[index];

                          // final key = ValueKey(item);
                          final key = Key('$index');
                          return Container(
                            key: key,
                            width: 300,
                            height: 100,
                            color: Colors.white,
                            child: Center(
                                key: key,
                                child: Text(
                                  targetData[index],
                                  key: key,
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )),
                          ).animate(key: key).fadeIn().shimmer();
                        },
                        // separatorBuilder: (context, index) => SizedBox(
                        //   height: 10,
                        // ),
                      ),
                    ],
                  ),
                );
              }),
              onAccept: ((String data) {
                setState(() {
                  targetData.add(data);
                });
              }),
              onWillAcceptWithDetails: (details) {
                return true;
              },
            ),
          ],
        )
      ],
    );
  }
}
