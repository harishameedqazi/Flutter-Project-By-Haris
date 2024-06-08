import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/user/views/hostel/hostel_details_screen.dart';
import 'package:hostel_mangement/user/views_models/hostel/hostel_model.dart';

class HostelScreen extends StatelessWidget {
  const HostelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HostelModel controller = Get.put(HostelModel());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Hostels',
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

        else  if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hostels found.'));
          }
else{
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var hostel = snapshot.data![index];
              var hostelName = hostel['hostelName'];
              var totalRoomsAvailable = hostel['totalRoomsAvailable'];
              var hostelImage = hostel['hostelImage'];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: AppColors.white.withOpacity(.99),
                  child: ListTile(
                    onTap: () {
                      Get.to(() => HostelDetailsScreen(
                        hostelData:hostel
                      ));
                    },
                    leading: Image.network('$hostelImage'),
                    title: Text(hostelName),
                    subtitle: Text('$totalRoomsAvailable rooms available'),
                  ),
                ),
              );
            },
          );
        }
   } ),
    );
  }
}
