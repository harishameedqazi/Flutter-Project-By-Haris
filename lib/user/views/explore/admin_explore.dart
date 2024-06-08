import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/main.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/user/views/explore/add_admin_services.dart';
import 'package:hostel_mangement/user/views/explore/admin_service_details.dart';
import 'package:hostel_mangement/user/views_models/services/admin_service_model.dart';

class AdminServicesScreen extends StatelessWidget {
  const AdminServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminServiceController controller = Get.put(AdminServiceController());

    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          ' Your Services',
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
            return const Center(child: Text('No Service found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var service = snapshot.data![index];
              var serviceName = service['serviceName'];
              var address = service['address'];
              var serviceImage = service['serviceImage'];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: AppColors.white.withOpacity(.99),
                  child: ListTile(
                    onTap: () {
                      Get.to(
                        AdminExploreDetailsScreen(
                          data: service,
                        ),
                      );
                    },
                    leading: Image.network('$serviceImage'),
                    title: Text("$serviceName"),
                    subtitle: Text('$address'),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Handle edit action
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              // Handle delete action
                            },
                            icon: Icon(
                              Icons.delete,
                              color: AppColors.bluegrey,
                            ),
                          ),
                        ],
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
            Get.to(() => AdminAddServicesScreen());
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
