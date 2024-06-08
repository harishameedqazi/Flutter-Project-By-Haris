import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/main.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/res/components/bedstatus_components.dart';
import 'package:hostel_mangement/res/components/rentpayment_component.dart';
import 'package:hostel_mangement/user/views/students/admin_students_details.dart';
import 'package:hostel_mangement/user/views/students/reservation_request_screen.dart';
import 'package:hostel_mangement/user/views_models/students/admin_students_model.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminStudnetsModel adminStudnetsModel = Get.put(AdminStudnetsModel());

    size = MediaQuery.of(context).size;
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
              onPressed: () {
                Get.to(() => const ReservationRequestScreen());
              },
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            // Container for displaying total guest information
            InkWell(
              onTap: () {
                Get.to(() => const AdminStudentsDetails());
              },
              child: Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                width: size.width,
                height: size.height * .14,
                decoration: BoxDecoration(
                  gradient: AppColors.gradient,
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(10),
                ),
                // Row to display guest count and an icon
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Column for guest-related text
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Students',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FutureBuilder<int>(
                          future: adminStudnetsModel.fetchTotalStudents(),
                          builder: (context, AsyncSnapshot<int> snapshot) {
                            if (adminStudnetsModel.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Error: ${snapshot.error}',
                                ),
                              );
                            }

                            if (!snapshot.hasData) {
                              return Center(
                                child: Text(
                                  'Loading...',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }

                            if (snapshot.data == 0) {
                              return Center(
                                child: Text(
                                  'No Students found.',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }

                            return Text(
                              snapshot.data.toString(),
                              style: TextStyle(
                                color: AppColors.yellow,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    // Circular icon
                    Icon(
                      Icons.brightness_1,
                      color: AppColors.yellow,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // Section: Bed Status
            const Text(
              'Room Status',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            // Row to display bed status components
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // BedStatusComponent widget with Total value
                BedStatusComponent(
                  title: 'Total',
                  colors: Color.fromRGBO(0, 0, 0, 1),
                  futureValue: adminStudnetsModel.fetchTotalRooms(),
                ),

                // BedStatusComponent widget with Total value
                BedStatusComponent(
                  title: 'Available',
                  colors: Colors.black,
                  futureValue: adminStudnetsModel.fetchTotalRooms(),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // Row to display bed status components
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // BedStatusComponent widget with Total value
                // BedStatusComponent(
                //   title: 'Reserved',
                //   colors: Colors.black,
                //   value: '25',
                //   futureValue: ,
                // ),
                // // BedStatusComponent widget with Total value
                // BedStatusComponent(
                //   title: 'Maintanance',
                //   colors: Colors.black,
                //   value: '5',
                // ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            // Section: Rent Payment
            const Text(
              'Rent Payment',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            // Row to display rent payment components
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // RentPaymentComponent widget with Total value
                RentPaymentComponent(
                  title: 'Total',
                  value: '50000',
                ),
                // RentPaymentComponent widget with Total value
                RentPaymentComponent(
                  title: 'Total',
                  value: '25',
                ),
                // RentPaymentComponent widget with Total value
                RentPaymentComponent(
                  title: 'Total',
                  value: '25',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
