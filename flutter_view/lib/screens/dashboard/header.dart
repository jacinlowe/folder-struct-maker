import 'package:flutter/material.dart';

import '../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // const Spacer(),
        Expanded(
          child: Container(
            height: 50,
            // width: 250,
            padding: const EdgeInsets.only(left: defaultPadding),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: primaryColor,
            ),
            child: TextFormField(
              // initialValue: 'Search...',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              decoration: const InputDecoration(
                  labelText: 'Search ...',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        const SizedBox(
          width: defaultPadding * 2,
        ),
        Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: const Icon(
            Icons.notifications_outlined,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
