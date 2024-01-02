import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'visit_stats.dart';
import 'chart_column.dart';
import '../../utils/string_casing.dart';
import '../../constants.dart';
import '../../controllers/reservation_provider.dart';

class FinancialRow2 extends HookConsumerWidget {
  const FinancialRow2({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedReservation = ref.watch(reservationProvider);
    return Row(
      children: [
        Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(defaultPadding),
              height: 280,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      'Reservations',
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
                        'This Week',
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
                        'Last Week',
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      width: defaultPadding * 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: defaultPadding / 2),
                      child: PopupMenuButton(
                        onSelected: (value) => {
                          ref
                              .read(reservationProvider.notifier)
                              .changeType(value),
                        },
                        itemBuilder: (context) {
                          return List.generate(
                              ReservationType.values.length,
                              (index) => PopupMenuItem(
                                  value: ReservationType.values[index],
                                  child: Text(
                                    ReservationType.values[index].name
                                        .toTitleCase(),
                                    style: GoogleFonts.ubuntu(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  )));
                        },
                        child: Row(
                          children: [
                            Text(
                              selectedReservation.name.toTitleCase(),
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white54,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: defaultPadding / 4,
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.white54)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: ChartColumn(),
                        height: 160,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(
                      width: defaultPadding * 2,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          child: CircularPercentIndicator(
                            radius: 60,
                            lineWidth: 15,
                            percent: 0.6,
                            progressColor: secondaryColor,
                            circularStrokeCap: CircularStrokeCap.round,
                            backgroundColor: bgColor,
                            center: Text(
                              '12%',
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: secondaryColor2),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: defaultPadding / 2),
                              child: Text(
                                'More thank last week',
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                )
              ]),
            )),
        const SizedBox(
          width: defaultPadding * 2,
        ),
        VisitStats(
          selectedReservation: selectedReservation,
        ),
      ],
    );
  }
}
