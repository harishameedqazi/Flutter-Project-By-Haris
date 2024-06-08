import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/res/widgets/button.dart';
import 'package:hostel_mangement/user/views/students/student_details.dart';
import 'package:hostel_mangement/user/views_models/students/admin_students_model.dart';

class ReservationRequestScreen extends StatelessWidget {
  const ReservationRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminStudnetsModel adminStudnetsModel = Get.put(AdminStudnetsModel());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reservation Request'),
      ),
      body: StreamBuilder(
        stream:
            adminStudnetsModel.fetchStundentsStream(), // Use the stream here
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
                child: Column(
                  children: [
                    Card(
                      color: AppColors.white.withOpacity(.99),
                      child: ListTile(
                        onTap: () {
                          Get.to(
                            StudentDetailsScreen(
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Button(
                          ontap: () {
                            adminStudnetsModel.acceptRequest(
                                studentId: students['studentId'],
                                userId: students['adminId'],
                                roomId: students['roomNo'],
                                hostelName: students['hostelName'],
                                adminName: students['hostelName'],
                                hostelId: students['hostelId']);
                          },
                          width: 160,
                          height: 50,
                          text: 'Accept Request',
                          gradient: AppColors.acceptGradient,
                        ),
                        Button(
                          ontap: () {
                            adminStudnetsModel.rejectRequest(  
                              hostelName: students['hostelName'],
                              adminName: students['hostelName'],
                              studentId: students['studentId'],
                            );
                          },
                          width: 160,
                          height: 50,
                          text: 'Reject Request',
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               child: ListTile(
//                 onTap: () {
//                   Get.to(() => const StudentDetailsScreen(data: 'Ahsan Javid'));
//                 },
//                 leading: Image.asset('assets/img1.jpg'),
//                 title: const Text('Ahsan Javid'),
//                 subtitle: const Text('Ahmad hostel'),
//                 trailing: const Icon(Icons.keyboard_arrow_right_rounded),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Button(
//                 width: 170,
//                 text: 'Accept Request',
//                 gradient: AppColors.acceptGradient,
//               ),
//               Button(
//                 width: 170,
//                 text: 'Reject Request',
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
