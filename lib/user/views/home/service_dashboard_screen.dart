import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_mangement/res/colors.dart';
import 'package:hostel_mangement/user/views_models/home/bottom_navbar.dart';

class ServiceDashboardNavBar extends StatelessWidget {
  const ServiceDashboardNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MyHomePageController controller = Get.put(MyHomePageController());
    return Scaffold(
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            controller.servicePages.length,
            (index) => controller.servicePages[index],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: (controller.servicePages.length <=
                controller.serviceMAx)
            ? AnimatedNotchBottomBar(
                notchBottomBarController: controller.notchBottomBarController,
                color: Colors.white,
                showLabel: false,
                notchColor: AppColors.green,
                removeMargins: false,
                bottomBarWidth: 500,
                durationInMilliSeconds: 300,
                bottomBarItems: [
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.dashboard,
                      color: AppColors.bluegrey,
                    ),
                    activeItem: const Icon(
                      Icons.dashboard,
                      color: AppColors.white,
                    ),
                    itemLabel: 'Dashboard',
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.home_repair_service_rounded,
                      color: AppColors.bluegrey,
                    ),
                    activeItem: const Icon(
                      Icons.home_repair_service_rounded,
                      color: AppColors.white,
                    ),
                    itemLabel: 'services',
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.person,
                      color: AppColors.bluegrey,
                    ),
                    activeItem: const Icon(
                      Icons.person,
                      color: AppColors.white,
                    ),
                    itemLabel: 'Profile',
                  ),
                ],
                onTap: (index) {
                  controller.onTabChange(index);
                },
              )
            : null);
  }
}
