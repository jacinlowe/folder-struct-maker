import 'package:Folder_Struct_Maker/controllers/reservation_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/visits_data.dart';
import '../../utils/string_casing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/container_bar.dart';
import '../../constants.dart';

final visitSwitchProvider = Provider<List<VisitData>>((ref) {
  final selectedReservation = ref.watch(reservationProvider);
  switch (selectedReservation) {
    case ReservationType.month:
      return visitData2;

    default:
      return visitData;
  }
});

class VisitStats extends StatefulHookConsumerWidget {
  VisitStats({super.key, required selectedReservation});
  @override
  _Row2State createState() => _Row2State();
}

class _Row2State extends ConsumerState<VisitStats> {
  @override
  Widget build(BuildContext context) {
    final selectedReservation = ref.watch(reservationProvider);

    final vData = ref.watch(visitSwitchProvider);

    return Expanded(
        flex: 2,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          height: 280,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Visits',
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: defaultPadding / 2),
                    child: PopupMenuButton(
                      onSelected: (value) => {
                        print(value),
                        setState(() => ref
                            .read(reservationProvider.notifier)
                            .changeType(value))
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
                height: defaultPadding,
              ),
              ...List.generate(vData.length, (index) {
                final data = vData[index];
                return Expanded(
                  child: Column(
                    children: [
                      containerBar(
                        title: data.title,
                        value: data.value.toString(),
                        percentage: data.percentage,
                        color: data.color,
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ));
  }
}
