import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/user/views/explore/explore_details.dart';

import 'package:hostel_mangement/user/views_models/explore/explore_model.dart';
import 'package:hostel_mangement/user/views_models/services/user_services_model.dart';

class UserServicesScreen extends StatelessWidget {
  UserServicesScreen({super.key});
  final AttractionController controller = Get.put(AttractionController());

  @override
  Widget build(BuildContext context) {
    final UserServicesModel controller = Get.put(UserServicesModel());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Service',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: .2,
      ),
      body: StreamBuilder(
        stream: controller.fetchServcieStream(), // Use the stream here
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Services found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var serviceData = snapshot.data![index];
              var serviceName = serviceData['serviceName'];
              var address = serviceData['address'];
              var serviceImage = serviceData['serviceImage'];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: AppColors.white.withOpacity(.99),
                  child: ListTile(
                    onTap: () {
                      Get.to(() => ExploreDetailsScreen(
                            serviceData: serviceData,
                          ));

                    },
                    leading: Image.network('$serviceImage'),
                    title: Text(serviceName),
                    subtitle: Text('$address'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
