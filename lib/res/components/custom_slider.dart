import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  // final Stream<List<Map<String, dynamic>>>? hostelStream;
  // final Stream<List<Map<String, dynamic>>>? serviceStream;
  final List<String>? hostelList;
  const CustomSlider({
    Key? key,
    this.hostelList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return
    //     final List<Map<String, dynamic>> data = snapshot.data ?? [];
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2,
        viewportFraction: 0.98,
        // autoPlay: true,
        enlargeFactor: 0.5,
        enlargeCenterPage: true,
      ),
      items: hostelList!.map((item) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
