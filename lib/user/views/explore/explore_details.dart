import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/user/views_models/hostel/hostel_model.dart';

class ExploreDetailsScreen extends StatelessWidget {
  const ExploreDetailsScreen({Key? key, required this.serviceData})
      : super(key: key);

  final serviceData;

  @override
  Widget build(BuildContext context) {
    var hostelModel = Get.put(HostelModel());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background Image
            Stack(
              children: [
                Image.network(
                  '${serviceData['serviceImage']}',
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
                Positioned(
                  top: 30.0,
                  right: 5,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border,
                      color: AppColors.white,
                      size: 25,
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
                    '${serviceData['serviceName']}',
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
                        "${serviceData['address']}",
                        style: TextStyle(
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
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  // serviceData['serviceImageList']
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: serviceData['serviceImageList'].length,
                      itemBuilder: (context, index) {
                        String imageUrl =
                            serviceData['serviceImageList'][index];

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
                      "${serviceData['description']}",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
