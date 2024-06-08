import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hostel_mangement/main.dart';

import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/res/components/custom_slider.dart';
import 'package:hostel_mangement/res/components/rentpayment_component.dart';
import 'package:hostel_mangement/res/widgets/slider_images_list.dart';
import 'package:hostel_mangement/user/views/students/user_student_room_status_details.dart';
import 'package:hostel_mangement/user/views_models/hostel/hostel_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HostelModel controller = Get.put(HostelModel());

    // Retrieve screen size using MediaQuery
    size = MediaQuery.of(context).size;

    // Scaffold for the overall screen structure
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          // Container for notification icon
          Container(
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(.3),
              border: Border.all(color: Colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none,
                color: AppColors.green,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section: Total Guest
              const Text(
                'Hostels',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              // Container for displaying total guest information
              CustomSlider(
                hostelList: hostelList,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Services',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomSlider(
                hostelList: servicesImages,
              ),
              const SizedBox(
                height: 15,
              ),

              // Section: Bed Status
              const Text(
                'Bed Status',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),

              // Row to display bed status components
              InkWell(
                onTap: () {
                  Get.to(() => ReservedRoomDataScreen(
                        roomData: {},
                      ));
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .23,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              'assets/room.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // const SizedBox(
              //   height: 10,
              // ),
              // Row to display bed status components
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // BedStatusComponent widget with Total value
                  //   BedStatusComponent(
                  //     title: 'Total',
                  //     colors: Colors.black,
                  //     value: '25',
                  //   ),
                  //   // BedStatusComponent widget with Total value
                  //   BedStatusComponent(
                  //     title: 'Total',
                  //     colors: Colors.black,
                  //     value: '25',
                  //   ),
                ],
              ),

              
            ],
          ),
        ),
      ),
    );
  }
}





  // Container(
  //             padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
  //             width: size.width,
  //             height: size.height * .14,
  //             decoration: BoxDecoration(
  //               gradient: AppColors.gradient,
  //               border: Border.all(color: Colors.black.withOpacity(0.1)),
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             // Row to display guest count and an icon
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 // Column for guest-related text
  //                 Column(
  //                   children: [
  //                     const Text(
  //                       'Guests',
  //                       style: TextStyle(
  //                         color: AppColors.white,
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 5,
  //                     ),
  //                     // Displaying the guest count
  //                     Text(
  //                       '15',
  //                       style: TextStyle(
  //                         color: AppColors.yellow,
  //                         fontSize: 25,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 // Circular icon
  //                 Icon(
  //                   Icons.brightness_1,
  //                   color: AppColors.yellow,
  //                 ),
  //               ],
  //             ),
  //           ),