import 'package:flutter/material.dart';
import 'package:hostel_mangement/res/colors.dart';

class EditScreenComponent extends StatelessWidget {
  const EditScreenComponent({
    Key? key,
    required this.title,
    required this.hintText,
    required this.icon,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
  }) : super(key: key);

  final String title;
  final String hintText;
  final IconData icon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            color: AppColors.bluegrey,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: Icon(icon),
            prefixIconColor:
                AppColors.bluegrey, // Replace with your desired color
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 11),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
