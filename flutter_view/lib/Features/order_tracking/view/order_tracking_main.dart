import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../controller/order_status_enum.dart';
import 'order_status_item_view.dart';

class OrderTrackingStatus extends StatelessWidget {
  const OrderTrackingStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 4,
        child: Container(
          color: const Color.fromARGB(255, 22, 29, 33),
          child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: OrderStatusEnum.values.mapIndexed((index, e) {
                  return OrderStatusItemView(
                    color: e.color,
                    title: e.title,
                    subtitle: e.description,
                    icon: e.icon,
                    isActive: index < OrderStatusEnum.values.length - 2,
                    showLine: index < OrderStatusEnum.values.length - 2,
                  );
                }).toList(),
              )),
        ));
  }
}
