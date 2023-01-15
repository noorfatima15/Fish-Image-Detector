import 'package:fish_detector/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class NavigationTab extends StatelessWidget {
  final String tabTitle;
  final IconData tabIcon;
  final VoidCallback? onTap;
  final Color? selectedColor;
  final Color? unselectedColor;

  NavigationTab({Key? key, required this.tabTitle, required this.tabIcon, this.onTap, this.selectedColor, this.unselectedColor}) : super(key: key);
  NavigationController _navigationController = Get.put(NavigationController());
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
