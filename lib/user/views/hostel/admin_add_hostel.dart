import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/res/components/edit_screen_components.dart';
import 'package:hostel_mangement/res/widgets/utils.dart';
import 'package:hostel_mangement/services/notification/push_notication.dart';
import 'package:hostel_mangement/user/views_models/hostel/admin_hostel_model.dart';
import 'package:hostel_mangement/user/views_models/hostel/hostel_model.dart';

class AdminAddHostelScreen extends StatelessWidget {
  const AdminAddHostelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminHostelController controller = Get.put(AdminHostelController());
    var hostelModel = Get.put(HostelModel());

    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text('Add Hostel'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return controller.selectedImage.value != null
                  ? Image.file(
                      controller.selectedImage.value!,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: double.infinity,
                    )
                  : GestureDetector(
                      onTap: controller.pickImage,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: double.infinity,
                        color: Colors.grey, // You can customize the color
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(height: 8),
                            Text(
                              "Add Hostel Image",
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EditScreenComponent(
                      controller: controller.hostelnameController,
                      title: 'Hostel Name ',
                      hintText: 'hostel Name',
                      icon: Icons.bed),
                  const SizedBox(
                    height: 10,
                  ),
                  EditScreenComponent(
                    controller: controller.addressController,
                    title: 'Address ',
                    hintText: 'Address',
                    icon: Icons.bookmark,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  EditScreenComponent(
                    controller: controller.descriptionController,
                    title: 'Description ',
                    hintText: 'Description',
                    icon: Icons.description,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  EditScreenComponent(
                    controller: controller.phoneController,
                    title: 'Phone No ',
                    hintText: 'Phone No',
                    icon: Icons.phone,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  EditScreenComponent(
                    controller: controller.roomController,
                    title: 'Total Rooms ',
                    hintText: 'Total Rooms',
                    icon: Icons.meeting_room_sharp,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  EditScreenComponent(
                    controller: controller.availableRoomsController,
                    title: 'Available Rooms ',
                    hintText: 'Available Rooms',
                    icon: Icons.meeting_room_sharp,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  EditScreenComponent(
                    controller: controller.hostelIdController,
                    title: 'Hostel Id ',
                    hintText: '1',
                    icon: Icons.meeting_room_sharp,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hostel Category',
                          style: TextStyle(
                            color: AppColors.bluegrey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Obx(
                            () => DropdownButton<String>(
                              isExpanded: true,
                              hint: Text(
                                'Hostel Category',
                                style: TextStyle(color: AppColors.bluegrey),
                              ),
                              onChanged: (newValue) {
                                hostelModel.hostelSelected(newValue.toString());
                              },
                              value: hostelModel.hostelselect.value,
                              items: hostelModel.hostelCategories
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Room Category',
                  //         style: TextStyle(
                  //           color: AppColors.bluegrey,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 200,
                  //         child: Obx(
                  //           () => DropdownButton<String>(
                  //             isExpanded: true,
                  //             hint: Text(
                  //               'Bed Type',
                  //               style: TextStyle(color: AppColors.bluegrey),
                  //             ),
                  //             onChanged: (newValue) {
                  //               hostelModel.setSelected(newValue.toString());
                  //             },
                  //             value: hostelModel.selected.value,
                  //             items: hostelModel.roomCategories
                  //                 .map<DropdownMenuItem<String>>(
                  //                     (String value) {
                  //               return DropdownMenuItem<String>(
                  //                 value: value,
                  //                 child: Text(value),
                  //               );
                  //             }).toList(),
                  //           ),
                  //         ),
                  //       )
                  //     ]),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Text(
                    "Gallery",
                    style: TextStyle(
                        color: AppColors.bluegrey,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.roomImages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => controller.getImageFromGallery(index),
                          child: Obx(
                            () => Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors
                                    .primaries[index % Colors.primaries.length],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  controller.roomImages[index].image.value !=
                                          null
                                      ? Container(
                                          width: 150,
                                          height: 119,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: FileImage(controller
                                                  .roomImages[index]
                                                  .image
                                                  .value!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Column(children: [
                                          const Icon(Icons.add,
                                              color: Colors.white),
                                          const SizedBox(height: 8),
                                          Text(
                                            controller.roomImages[index].name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ])
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: ElevatedButton(
            onPressed: controller.isLoading.value
                ? null // Disable button when loading
                : () {
                    // Check if hostel image and at least one room image is selected

                    if (controller.selectedImage.value != null &&
                        controller.roomImages.any(
                            (roomImage) => roomImage.image.value != null)) {
                      controller.addHostelToFirestore(
                        // Pass other parameters as needed
                        hostelName: controller.hostelnameController.text,
                        address: controller.addressController.text,
                        description: controller.descriptionController.text,
                        phoneNo: controller.phoneController.text,
                        totalRoomsAvailable: controller.roomController.text,
                        availableRooms:controller.availableRoomsController.text,
                        hostelCategory: hostelModel.hostelselect.value,
                        hostelId: controller.hostelIdController.text,
                      );
                    } else {
                      Utils.flutterToast(
                        'Please select hostel image and at least one room image.',
                      );
                    }
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
            child: controller.isLoading.value
                ? CircularProgressIndicator(
                    color: AppColors.bluegrey,
                  ) // Loading indicator
                : const Text(
                    'Add Hostel',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}