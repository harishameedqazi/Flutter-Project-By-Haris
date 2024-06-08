import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              width: 120,
              height: 100,
              decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(.3),
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.green,
                ),
              ),
            ),
          ),
          centerTitle: true,
          title: const Text('BookMark '),
        ),
        body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: AppColors.white.withOpacity(.99),
                child: ListTile(
                  onTap: () {
                   
                  },
                  leading: Image.asset('assets/room.jpeg'),
                  title: Text('Ahmad Hostel'),
                  subtitle: Text('2 rooms availble'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            );
          },
        ));
  }

