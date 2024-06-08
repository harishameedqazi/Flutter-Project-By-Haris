import 'package:flutter/material.dart';
import 'package:hostel_mangement/main.dart';
import 'package:hostel_mangement/res/colors.dart';

class BedStatusComponent extends StatelessWidget {
  BedStatusComponent({
    Key? key,
    required this.title,
    required this.colors,
     this.futureValue,
    this.value,
  }) : super(key: key);

  final String title;
  final Color colors;
  final  futureValue;
  final value;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: futureValue,
      builder: (context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display loading indicator while waiting for the future to complete
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Display error message if an error occurs
          return Text('Error: ${snapshot.error}');
        } else {
          // Display the total number of rooms
          return Container(
            width: size.width * 0.462,
            height: size.height * 0.126,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.3),
              border: Border.all(color: Colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  snapshot.data.toString(),
                  style: TextStyle(
                      color: colors, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
