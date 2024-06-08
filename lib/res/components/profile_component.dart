import 'package:flutter/material.dart';
import 'package:hostel_mangement/res/colors.dart';

class ProfileComponent extends StatelessWidget {
  final onTap;
  final icon;
  final String? title;
  final  subtitle;
  final leadingicon;

  const ProfileComponent(
      {super.key,
      required this.onTap,
      required this.icon,
      this.title,
      this.leadingicon,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 1,
          color: AppColors.white,
          child: ListTile(
            leading: Icon(
              icon,
              color: AppColors.bluegrey,
            ),
            subtitle: subtitle,
            title: Text(title!),
            trailing: Icon(leadingicon),
          ),
        ),
      ),
    );
  }
}
