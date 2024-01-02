import 'package:Folder_Struct_Maker/screens/dashboard/chart_ring.dart';
import 'package:Folder_Struct_Maker/utils/string_casing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/container_bar.dart';
import '../../constants.dart';
import '../../controllers/reservation_provider.dart';
import '../../models/data.dart';
import '../../models/reservation_date_model.dart';

class Services_row3 extends HookConsumerWidget {
  const Services_row3({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedReservation = ref.watch(reservationProvider);
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              height: 300,
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(children: [
                Row(children: [
                  Text(
                    'Services',
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
                                ref
                                    .watch(reservationProvider.notifier)
                                    .changeType(value)
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
                          child: Row(children: [
                            Text(
                              selectedReservation.name.toCapitalized(),
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white54,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: defaultPadding / 4,
                            ),
                            const Icon(Icons.arrow_drop_down,
                                color: Colors.white54)
                          ])))
                ]),
                const ChartRing(),
                const Column(
                  children: [
                    Row(
                      children: [
                        containerBar(
                            title: 'Haircut',
                            value: '24.9%',
                            percentage: 25.0 / 100.0,
                            color: secondaryColor),
                        SizedBox(width: 20),
                        containerBar(
                            title: 'Make up',
                            value: '40.9%',
                            percentage: 40.0 / 100.0,
                            color: Color(0xFF4FF0B4)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        containerBar(
                            title: 'Hair Color',
                            value: '20.2%',
                            percentage: 0.2,
                            color: secondaryColor2),
                        SizedBox(width: 20),
                        containerBar(
                            title: 'Massage',
                            value: '12.2%',
                            percentage: 12.0 / 100.0,
                            color: Color(0xFFF9A266)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        containerBar(
                            title: 'Nails',
                            value: '18.2%',
                            percentage: 0.18,
                            color: Color(0xFF01DFFF)),
                        SizedBox(width: 20),
                        containerBar(
                            title: 'Skincare',
                            value: '9.2%',
                            percentage: 9.0 / 100.0,
                            color: Color(0xFFF9CE62)),
                      ],
                    ),
                  ],
                  // Row(
                  //   children:
                  // )
                )
              ]),
            )),
        const SizedBox(
          width: defaultPadding * 2,
        ),
        Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              height: 300,
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      'Upcoming dates for reservation',
                      style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: defaultPadding / 2),
                      // child: PopupMenuButton(
                      //   onSelected: (value) => {},
                      //   itemBuilder: (context) {
                      //     return List.generate(
                      //         ReservationType.values.length,
                      //         (index) => PopupMenuItem(
                      //             value: ReservationType
                      //                 .values[index],
                      //             child: Text(
                      //               ReservationType
                      //                   .values[index].name
                      //                   .toTitleCase(),
                      //               style: GoogleFonts.ubuntu(
                      //                   fontSize: 11,
                      //                   fontWeight:
                      //                       FontWeight.w400),
                      //             )));
                      //   },
                      // ),
                      child: Row(children: [
                        Text(
                          'June',
                          style: GoogleFonts.ubuntu(
                              color: Colors.white54,
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: defaultPadding / 4,
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.white54)
                      ]),
                    )
                  ]),
                  const SizedBox(height: defaultPadding),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: DataTable(
                      headingTextStyle: const TextStyle(color: Colors.white54),
                      headingRowHeight: 25,
                      horizontalMargin: 0,
                      dataRowMinHeight: 25,
                      dataRowMaxHeight: 35,
                      columnSpacing: 23,
                      columns: [
                        const DataColumn(
                            label: Text(
                          'Services',
                        )),
                        ...List.generate(
                            12,
                            (index) => DataColumn(
                                    label: Text(
                                  (11 + index).toString(),
                                )))
                        // DataColumn(label: Text('15')),
                        // DataColumn(label: Text('16')),
                        // DataColumn(label: Text('17')),
                        // DataColumn(label: Text('18')),
                        // DataColumn(label: Text('19')),
                        // DataColumn(label: Text('Services')),
                        // DataColumn(label: Text('Services')),
                      ],
                      rows: List.generate(demoDataModel.length,
                          (index) => _dataRow(demoDataModel[index])),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

// List<Widget> serviceList = List<Widget>.generate(ringChartData.length, (index){
//   if (index %2 == 0){
//   final rdata = ringChartData[index];
//   final prevData = ringChartData[index-1];
//     final wid =  Row(
//       children: [
//         containerBar(title: rdata.x, value: rdata.y.toString(), percentage: rdata.y/100, color: rdata.color),
//         const SizedBox(width: 10),
//         containerBar(title: prevData.x, value: prevData.y.toString(), percentage: prevData.y/100, color: prevData.color),
//         ],);
//   }
//   return const Row(children:[containerBar(title: 'test', value: '10', percentage: 0.23, color: Colors.white)])
// });

//column of rows with sized boxes between them

DataRow _dataRow(ReservationDateModel data) {
  return DataRow(cells: [
    DataCell(Text(
      data.title,
      style: const TextStyle(fontSize: 11, color: Colors.white),
    )),
    ...List.generate(data.icons.length, (index) => DataCell(data.icons[index]))
  ]);
}
