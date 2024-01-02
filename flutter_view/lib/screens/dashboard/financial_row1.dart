import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/chart_spline.dart';
import '../../components/chart_spline2.dart';
import '../../components/chart_spline3.dart';
import '../../constants.dart';

class FinancialRow1 extends StatelessWidget {
  const FinancialRow1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(defaultPadding / 2),
              height: 300,
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      'Financial Analytics',
                      style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: secondaryColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: defaultPadding / 2),
                      child: Text(
                        'Income',
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      width: defaultPadding * 2,
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: secondaryColor2),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: defaultPadding / 2),
                      child: Text(
                        'Expenses',
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding * 2,
                ),
                const Expanded(child: ChartSpline())
              ]),
            )),
        const SizedBox(
          width: defaultPadding * 2,
        ),
        Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding * 2),
                  height: 142,
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Income',
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '\$2,850.58',
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.moving,
                                  color: secondaryColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '11% vs last week',
                                  style: GoogleFonts.ubuntu(
                                      color: Colors.white38,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: defaultPadding,
                        ),
                        Expanded(child: ChartSpline2())
                      ]),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding * 1.5,
                        horizontal: defaultPadding),
                    height: 142,
                    decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Expenses',
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '\$1,256.58',
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.trending_down,
                                    color: secondaryColor2,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '4% vs last week',
                                    style: GoogleFonts.ubuntu(
                                        color: Colors.white38,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          Expanded(child: ChartSpline3())
                        ])),
              ],
            )),
      ],
    );
  }
}
