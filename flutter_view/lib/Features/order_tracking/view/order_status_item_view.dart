import '../../../constants.dart';
import 'package:flutter/material.dart';

class OrderStatusItemView extends StatefulWidget {
  Color color;
  String title;
  String subtitle;
  IconData icon;
  bool showLine;
  bool isActive;

  OrderStatusItemView(
      {super.key,
      required this.color,
      required this.title,
      required this.subtitle,
      required this.icon,
      this.showLine = true,
      this.isActive = true});

  @override
  State<OrderStatusItemView> createState() => _OrderStatusItemViewState();
}

class _OrderStatusItemViewState extends State<OrderStatusItemView> {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor;
    final Color textColor;

    switch (widget.isActive) {
      case true:
        primaryColor = widget.color;
        textColor = Colors.white;
      default:
        primaryColor = Colors.grey.shade600;
        textColor = Colors.white30;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(alignment: Alignment.center, children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 25,
                height: 25,
              ),
              Container(
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: primaryColor),
                width: 15,
                height: 15,
              ),
            ]),
            if (widget.showLine)
              ...List<Widget>.generate(5, (index) {
                return Column(children: [
                  Container(
                    width: 1,
                    height: 10,
                    color: primaryColor,
                  ),
                  SizedBox(
                    height: 4,
                  )
                ]);
              })
          ],
        ),
        SizedBox(
          width: defaultPadding,
        ),
        Padding(
          padding: const EdgeInsets.only(top: defaultPadding / 2),
          child: Container(
            width: 230,
            height: 65,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 47, 63, 71),
                border: Border.all(),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(fontSize: 18, color: textColor),
                    ),
                    // SizedBox(
                    //   height: defaultPadding / 4,
                    // ),
                    Text(
                      widget.subtitle,
                      style: TextStyle(fontSize: 12, color: textColor),
                    )
                  ],
                ),
                Spacer(),
                Icon(
                  widget.icon,
                  color: primaryColor,
                )
              ]),
            ),
          ),
        )
      ],
    );
  }
}
