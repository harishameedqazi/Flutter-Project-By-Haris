// controllers/attraction_controller.dart
import 'package:get/get.dart';
import 'package:hostel_mangement/model/explore_model.dart';

class AttractionController extends GetxController {
  final attractions = <Attraction>[
    Attraction(
      name: 'Restaurants and Cafes',
      description: 'Nice cafe',
      imagePath: 'assets/rest.jpeg',
    ),
    // Add more attractions as needed
  ].obs;
}
