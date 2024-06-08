import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hostel_mangement/res/components/edit_screen_components.dart';
import 'package:hostel_mangement/res/widgets/button.dart';
import 'package:hostel_mangement/services/notification/push_notication.dart';
import 'package:hostel_mangement/user/views_models/hostel/hostel_model.dart';

class RoomBookingPage extends StatelessWidget {
  const RoomBookingPage({
    Key? key,
    required this.hostelId,
    required this.hostelName,
    required this.userId,
    required this.price,
    required this.token,
  }) : super(key: key);
  final String hostelId;
  final String hostelName;
  final String userId;
  final String price;
  final String token;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HostelModel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Room Booking',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: .2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                return controller.selectedImage.value != null
                    ? Image.file(
                        controller.selectedImage.value!,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                      )
                    : GestureDetector(
                        onTap: controller.pickImage,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.grey, // You can customize the color
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: Colors.white),
                              SizedBox(height: 8),
                              Text(
                                "Add Your Image",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              }),
              EditScreenComponent(
                controller: controller.nameController,
                title: 'Name ',
                hintText: 'Name',
                icon: Icons.person,
              ),
              EditScreenComponent(
                controller: controller.phoneController,
                title: 'Phone No',
                hintText: '+9231334456',
                icon: Icons.call,
              ),
              EditScreenComponent(
                controller: controller.addressController,
                title: 'Address',
                hintText: 'Address',
                icon: Icons.menu_book,
              ),
              EditScreenComponent(
                controller: controller.clinicController,
                title: 'Cinic',
                hintText: 'Cinic',
                icon: Icons.perm_identity,
              ),
              EditScreenComponent(
                controller: controller.roomNOController,
                title: 'Room No',
                hintText: 'Room No',
                icon: Icons.perm_identity,
              ),
              EditScreenComponent(
                controller: controller.ageController,
                title: 'Age',
                hintText: 'Age',
                icon: Icons.calendar_month_rounded,
              ),
              const SizedBox(height: 25),
              Button(
                ontap: () async {
                  controller.bookingHostelRequest(
                      guestName: controller.nameController.text,
                      guestPhone: controller.phoneController.text,
                      guestAddress: controller.addressController.text,
                      clinic: controller.clinicController.text,
                      age: controller.ageController.text,
                      hostelName: hostelName,
                      hostelId: hostelId,
                      adminId: userId,
                      roomNo: controller.roomNOController.text,
                      price: price);
                  FirebaseNotification().sendBookingNotificationToAdmin(
                      guestName: controller.nameController.text,
                      hostelName: hostelName,
                      adminId: userId);
                },
                text: 'Book ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
