import 'package:flutter/material.dart';
import 'package:hostel_mangement/res/colors.dart';

class Button extends StatelessWidget {
  Button({
    Key? key,
    required this.text,
    this.textColor = Colors.white, // Set the default value to white
    this.width = 200, // Set the default value to white
    this.height = 50,
    this.ontap,
    this.gradient = AppColors.gradient,
    this.isLoading = false,
  }) : super(key: key);

  final Color textColor;
  final String text;
  final ontap;
  final double width;
  final double height;
  final isLoading;
  final gradient;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: ontap,
        child: Container(
          width: width,
          height: height,
          decoration: isLoading
              ? BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                )
              : BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(14),
                ),
          child: Center(
            child: isLoading
                ? CircularProgressIndicator(
                    color: AppColors.bluegrey,
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
