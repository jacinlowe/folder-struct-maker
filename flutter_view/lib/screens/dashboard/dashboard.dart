import 'package:flutter/material.dart';

import '../../constants.dart';
import 'financial_row1.dart';
import 'financial_row2.dart';
import 'header.dart';
import 'services_row3.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2, vertical: defaultPadding),
      child: const Column(children: [
        FinancialRow1(),
        SizedBox(
          height: defaultPadding * 2,
        ),
        FinancialRow2(),
        SizedBox(
          height: defaultPadding * 2,
        ),
        Services_row3()
      ]),
    );
  }
}
