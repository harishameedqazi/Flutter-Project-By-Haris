import 'package:flutter/material.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/res/components/profile_component.dart';

class ReservedRoomDataScreen extends StatelessWidget {
  const ReservedRoomDataScreen({Key? key, required this.roomData})
      : super(key: key);

  final Map<String, dynamic> roomData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserved Room'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Number, Hostel Name, Price
            ProfileComponent(
                subtitle: Text('54784w3'),
                onTap: () {},
                icon: Icons.person,
                title: 'Hostel NAme'),
            ProfileComponent(
                onTap: () {}, icon: Icons.person, title: 'Room no'),
            ProfileComponent(onTap: () {}, icon: Icons.person, title: 'price'),
            ProfileComponent(
                onTap: () {}, icon: Icons.person, title: 'Total Beds'),
            ProfileComponent(
                onTap: () {}, icon: Icons.person, title: 'Available Beds'),

            const SizedBox(height: 20),
            // Description
            const Text(
              'Your Room Mates',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // ListView.builder(
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       return ProfileComponent(
            //           subtitle: Text('4u3853'),
            //           onTap: () {},
            //           icon: Icons.person,
            //           title: 'Ahmad ');
            //     }),
          ],
        ),
      ),
    );
  }
}
