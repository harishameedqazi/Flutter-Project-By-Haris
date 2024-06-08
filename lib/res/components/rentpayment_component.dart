import 'package:flutter/material.dart';

import 'package:hostel_mangement/main.dart';
import 'package:hostel_mangement/res/colors.dart';

class RentPaymentComponent extends StatelessWidget {
  const RentPaymentComponent({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * .3,
      height: size.height * .12,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.white.withOpacity(.3),
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
