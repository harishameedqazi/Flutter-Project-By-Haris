import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/user/views/students/student_details.dart';
import 'package:hostel_mangement/user/views_models/students/admin_students_model.dart';

class AdminStudentsDetails extends StatelessWidget {
  const AdminStudentsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminStudnetsModel adminStudnetsModel = Get.put(AdminStudnetsModel());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Stundets Details'),
      ),
      body: StreamBuilder(
        stream: adminStudnetsModel
            .fetchstudentRequestStream(), // Use the stream here
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (adminStudnetsModel.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Students found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var students = snapshot.data![index];
              var studentsName = students['guestName'];
              var hostelName = students['hostelName'];
              var studentImage = students['guestImage'];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: AppColors.white.withOpacity(.99),
                  child: ListTile(
                    onTap: () {
                      Get.to(
                        () => StudentDetailsScreen(
                          data: students,
                        ),
                      );
                    },
                    leading: Image.network('$studentImage'),
                    title: Text(studentsName),
                    subtitle: Text('$hostelName'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
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
