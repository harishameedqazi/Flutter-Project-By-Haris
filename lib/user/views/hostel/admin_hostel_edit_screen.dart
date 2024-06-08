import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/user/views_models/hostel/hostel_model.dart';

class AdminHostelEditScreen extends StatelessWidget {
  const AdminHostelEditScreen({Key? key, required this.hostelName})
      : super(key: key);

  final String hostelName;

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
                Image.asset(
                  'assets/papas.jpg',
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
                  //  Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$hostelName',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                      const Text(
                        'BahawalPur',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Hostel contact
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: AppColors.green,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        '0301583934',
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
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage('assets/food.jpeg'),
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
                      "Welcome to your home away from home! Our hostel rooms are designed with your comfort and convenience in mind, providing a cozy and vibrant living space during your stay. Each room is thoughtfully furnished to cater to the needs of modern travelers.\n\n"
                      "Ample Storage: Stay organized with spacious storage solutions for your belongings. Each room comes equipped with lockers or wardrobes to secure your valuables.\n\n"
                      "Study Area: For those moments of focused productivity, there's a dedicated study area within the room, equipped with a desk and chair.\n\n"
                      "High-Speed Wi-Fi: Stay connected with friends and family or catch up on work with our reliable high-speed Wi-Fi available throughout the hostel.\n\n"
                      "Charging Outlets: Charge your devices hassle-free with conveniently located power outlets in the room, ensuring your gadgets are always ready to go.\n\n"
                      "Clean and Tidy: Our housekeeping team maintains a high standard of cleanliness, ensuring a fresh and inviting atmosphere throughout your stay.\n\n"
                      "Shared Facilities: While each room provides privacy, our hostel also offers shared facilities like communal kitchens, lounges, and bathrooms, fostering a sense of community among guests.\n\n"
                      "Security: Your safety is our priority. Benefit from secure access control and surveillance to ensure a worry-free stay.",
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
