import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/user/views/hostel/hostel_booking.dart';
// import 'package:hostel_mangement/user/views_models/hostel/admin_hostel_model.dart';
import 'package:hostel_mangement/user/views_models/hostel/hostel_model.dart';

class HostelRoomsDetailsScreen extends StatelessWidget {
  const HostelRoomsDetailsScreen(
      {Key? key, required this.data, this.hostelData})
      : super(key: key);
  final dynamic data;
  final dynamic hostelData;

  @override
  Widget build(BuildContext context) {
    // final AdminHostelController controller = Get.put(AdminHostelController());

    var hostelModel = Get.put(HostelModel());
    return Scaffold(
      appBar: AppBar(
        title: Text('Room No ${data['roomNo']}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Content Container
            Container(
              width: double.infinity,
              // height: MediaQuery.of(context).size.height * 6,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.white,
                // borderRadius: const BorderRadius.only(
                //   topLeft: Radius.circular(30),
                //   topRight: Radius.circular(30),
                // ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${hostelData['hostelName']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Hostel Address
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.money,
                        color: AppColors.green,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${data['price']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Beds Available',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${data['totalBeds']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Hostel Description
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    '${data['description']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: hostelModel.showDetails.value ? 1000 : 3,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Rooms',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: data['roomImages'].length,
                      itemBuilder: (context, index) {
                        String imageUrl = data['roomImages'][index];

                        return Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(right: 10),
                          height: 200,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => RoomBookingPage(
                  price: '${data['price']}',
                  hostelId: '${hostelData['hostelId']}',
                  userId: '${hostelData['userId']}',
                  token: '${hostelData['token']}',
                  hostelName: '${hostelData['hostelName']}',
                ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.green,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Book Now',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
