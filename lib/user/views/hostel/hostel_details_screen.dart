import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/res/components/facitilies_component.dart';
import 'package:hostel_mangement/user/views/hostel/admin_rooms_details.dart';
import 'package:hostel_mangement/user/views/hostel/hostel_room_details.dart';
import 'package:hostel_mangement/user/views_models/hostel/admin_hostel_model.dart';
import 'package:hostel_mangement/user/views_models/hostel/hostel_model.dart';

class HostelDetailsScreen extends StatelessWidget {
  const HostelDetailsScreen({Key? key, required this.hostelData})
      : super(key: key);

  final hostelData;

  @override
  Widget build(BuildContext context) {
    var hostelModel = Get.put(HostelModel());
    hostelModel.checkFavouriteStatus(hostelData['hostelId']);
    final AdminHostelController controller = Get.put(AdminHostelController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background Image
            Stack(
              children: [
                Image.network(
                  '${hostelData['hostelImage']}',
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
                Obx(
                  () => Positioned(
                    top: 30.0,
                    right: 5,
                    child: IconButton(
                      onPressed: () async {
                        await hostelModel
                            .toggleFavourite(hostelData['hostelId']);
                      },
                      icon: Icon(
                        hostelModel.isFavourite.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: AppColors.bluegrey,
                        size: 25,
                      ),
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
                  // Hostel Name
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  Text(
                    '${hostelData['hostelName']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //     RatingBar.builder(
                  //       initialRating: 3,
                  //       itemSize: 20,
                  //       minRating: 1,
                  //       direction: Axis.horizontal,
                  //       allowHalfRating: true,
                  //       itemCount: 5,
                  //       itemPadding:
                  //           const EdgeInsets.symmetric(horizontal: 2.0),
                  //       itemBuilder: (context, _) => const Icon(
                  //         Icons.star,
                  //         color: Colors.amber,
                  //       ),
                  //       onRatingUpdate: (rating) {
                  //         print(rating);
                  //       },
                  //     )
                  //   ],
                  // ),

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
                        '${hostelData['address']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Hostel Facilities
                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    'Facilities',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FacilitiesComponents(
                        icon: Icons.wifi,
                        title: 'Wifi',
                      ),
                      FacilitiesComponents(
                        icon: Icons.food_bank_sharp,
                        title: 'Kitchen',
                      ),
                      FacilitiesComponents(
                        icon: Icons.window,
                        title: 'Cabinet',
                      ),
                      FacilitiesComponents(
                        icon: Icons.local_parking,
                        title: 'Parking',
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
                        '${hostelData['hostelCategory']}',
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
                        'Contact No',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${hostelData['phoneNo']}',
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
                        '${hostelData['totalRoomsAvailable']}',
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
                    height: 15,
                  ),

                  Obx(
                    () => Text(
                      '${hostelData['description']}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: hostelModel.showDetails.value ? 1000 : 3,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      hostelModel.showDetails.value =
                          !hostelModel.showDetails.value;
                    },
                    child: Obx(
                      () => Text(
                        hostelModel.showDetails.value
                            ? "Read Less"
                            : "Read More",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Hostel Images

                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Gallery',
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
                      itemCount: {hostelData['roomImages']}.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  '${hostelData['roomImages'][index]}'),
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
                            userid: hostelData['userId'],
                            hostelId:
                                hostelData['hostelId']), // Use the stream here
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
                                                  HostelRoomsDetailsScreen(
                                                      hostelData: hostelData,
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
     
    );
  }
}
