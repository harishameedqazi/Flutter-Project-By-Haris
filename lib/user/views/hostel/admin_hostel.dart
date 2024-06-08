import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/user/views/hostel/admin_add_hostel.dart';
import 'package:hostel_mangement/user/views/hostel/admin_hostel_details.dart';
import 'package:hostel_mangement/user/views_models/hostel/admin_hostel_model.dart';

class AdminHostel extends StatelessWidget {
  const AdminHostel({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminHostelController controller = Get.put(AdminHostelController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Your Hostels',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: .2,
      ),
      body: StreamBuilder(
        stream: controller.fetchHostelsStream(), // Use the stream here
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hostels found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var hostel = snapshot.data![index];
              var hostelName = hostel['hostelName'];
              var totalRoomsAvailable = hostel['totalRoomsAvailable'];
              var hostelImage = hostel['hostelImage'];
              var hostelId = hostel['hostelId'];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: AppColors.white.withOpacity(.99),
                  child: ListTile(
                    onTap: () {
                      Get.to(
                        () => AdminHostelDetailsScreen(
                          data: hostel,
                        ),
                      );
                    },
                    leading: Image.network('$hostelImage'),
                    title: Text(hostelName),
                    subtitle: Text('$totalRoomsAvailable rooms available'),
                    trailing: SizedBox(
                      width: 100,
                      child: IconButton(
                        onPressed: () {
                          // Handle delete action

                          controller.deleteHostel(hostelId);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: AppColors.bluegrey,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 68.0),
        child: FloatingActionButton(
          backgroundColor: AppColors.bluegrey,
          onPressed: () {
            Get.to(() => AdminAddHostelScreen());
            // Navigate to the screen where you add a new hostel
          },
          child: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
