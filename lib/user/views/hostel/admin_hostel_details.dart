import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/res/const/firebase_const.dart';
import 'package:hostel_mangement/user/views/hostel/admin_add_rooms.dart';
import 'package:hostel_mangement/user/views/hostel/admin_rooms_details.dart';
import 'package:hostel_mangement/user/views_models/hostel/admin_hostel_model.dart';
import 'package:hostel_mangement/user/views_models/hostel/hostel_model.dart';

class AdminHostelDetailsScreen extends StatelessWidget {
  const AdminHostelDetailsScreen({Key? key, required this.data})
      : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    final AdminHostelController controller = Get.put(AdminHostelController());

    var hostelModel = Get.put(HostelModel());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background Image
            Stack(
              children: [
                Image.network(
                  '${data['hostelImage']}',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * .45,
                  width: double.infinity,
                ),
                // Back Button
                Positioned(
                  top: 30.0,
                  left: 5,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),

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
                    '${data['hostelName']}',
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
                        Icons.location_on,
                        color: AppColors.green,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${data['address']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Hostel category
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hostel Category',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${data['hostelCategory']}',
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
                        'Total Room Available',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${data['totalRoomsAvailable']}',
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

                  // GestureDetector(
                  //   onTap: () {
                  //     hostelModel.showDetails.value =
                  //         !hostelModel.showDetails.value;
                  //   },
                  //   child: Obx(
                  //     () => Text(
                  //       hostelModel.showDetails.value
                  //           ? "Read Less"
                  //           : "Read More",
                  //       style: const TextStyle(
                  //         color: Colors.blue,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // Hostel Images

                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Hostel Gallery',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data['roomImages'].length,
                      itemBuilder: (context, index) {
                        String imageUrl = data['roomImages'][index];

                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 150,
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

                  SizedBox(
                    height: MediaQuery.of(context).size.height * .7,
                    child: StreamBuilder(
                        stream: controller.fetchRoomsStream(
                          userid: auth.currentUser!.uid,
                            hostelId: data['hostelId']), // Use the stream here
                        builder: (context,
                            AsyncSnapshot<List<Map<String, dynamic>>>
                                snapshot) {
                          if (controller.isLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No Rooms found.'));
                          }

                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var rooms = snapshot.data![index];
                                var roomsId = rooms['roomNo'];
                                // var hostelName = hostel['hostelName'];
                                // var totalRoomsAvailable = hostel['totalRoomsAvailable'];
                                // var hostelImage = hostel['hostelImage'];
                                // var hostelId = hostel['hostelId'];

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Room No $roomsId',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      height: 100,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: rooms['roomImages'].length,
                                        itemBuilder: (context, index) {
                                          String imageUrl =
                                              rooms['roomImages'][index];

                                          return InkWell(
                                            onTap: () {
                                              Get.to(() =>
                                                  AdminRoomsDetailsScreen(
                                                      hostelData: data,
                                                      data: rooms));
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              width: 150,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: NetworkImage(imageUrl),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                );
                              });
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          controller.selectedImage.value = null;
          controller.roomImages.forEach((element) {
            element.image.value = null;
          });

          Get.to(() => AdminAddRoomsScreen(
                data: data,
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
        child: Text(
          'Add Rooms in ${data['hostelName']}',
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
