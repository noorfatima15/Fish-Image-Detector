import 'package:fish_detector/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationTab extends StatelessWidget {
  final String tabTitle;
  final IconData tabIcon;
  final VoidCallback? onTap;
  final Color? selectedColor;
  final Color? unselectedColor;

  NavigationTab({Key? key, required this.tabTitle, required this.tabIcon, this.onTap, this.selectedColor, this.unselectedColor}) : super(key: key);
  final NavigationController _navigationController = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
            height: 50,
            width: 80,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Icon(
                  tabIcon,
                  color: _navigationController.isTabSelected.value ? selectedColor : unselectedColor,
                ),
                Text(
                  tabTitle,
                  style: TextStyle(
                    color: _navigationController.isTabSelected.value ? selectedColor : unselectedColor,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
