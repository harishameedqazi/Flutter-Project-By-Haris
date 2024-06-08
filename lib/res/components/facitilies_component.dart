import 'package:flutter/material.dart';

import 'package:hostel_mangement/res/colors.dart';

class FacilitiesComponents extends StatelessWidget {
  const FacilitiesComponents({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String title;
  final  icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black.withOpacity(.1))),
      child: Column(
        children: [
          Icon(
           icon,
            color: AppColors.green,
            size: 20,
          ),
            Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
        ],
      ),
    );
  }
}
