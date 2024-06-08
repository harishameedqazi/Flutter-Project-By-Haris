import 'package:flutter/material.dart';
import 'package:hostel_mangement/res/components/profile_component.dart';

class StudentDetailsScreen extends StatelessWidget {
  const StudentDetailsScreen({super.key, required this.data});
  final data;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${data['guestName']}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: size.width * .2,
                backgroundImage: NetworkImage(
                  "${data['guestImage']}",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ProfileComponent(
                onTap: () {},
                icon: Icons.person,
                title: "${data['guestName']}"),
            ProfileComponent(
                onTap: () {},
                icon: Icons.phone,
                title: "${data['guestPhone']}"),
            ProfileComponent(
                onTap: () {},
                icon: Icons.menu_book,
                title: "${data['guestAddress']}"),
            ProfileComponent(
                onTap: () {},
                icon: Icons.perm_identity,
                title: "${data['clinic']}"),
            ProfileComponent(
                onTap: () {},
                icon: Icons.calendar_month_rounded,
                title: "${data['age']}"),
            ProfileComponent(
                onTap: () {},
                icon: Icons.hotel,
                title: "${data['hostelName']}"),
            ProfileComponent(
                onTap: () {}, icon: Icons.hotel, title: "${data['roomNo']}"),
          ],
        ),
      ),
    );
  }
}
