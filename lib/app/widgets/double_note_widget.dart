import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/common/app_route.dart';
import 'package:to_do/app/pages/home/controller.dart';

import '../../constants.dart';

class DoubleNoteWidget extends GetView<HomeController> {
  const DoubleNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoute.TASKMANAGER, arguments: [
              kGreenColor,
              'Work',
              'work',
              controller.workTasks,
            ]);
          },
          child: Container(
            width: Get.width * 0.475,
            height: 130,
            decoration: BoxDecoration(
              color: kGreenColor,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(50),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            '${controller.workTasks.length} Tasks',
                            style: const TextStyle(
                              color: Colors.black38,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Text(
                          'Work',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black12,
                      child: Center(
                        child: Icon(
                          Icons.work_history_outlined,
                          color: kBlackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoute.TASKMANAGER, arguments: [
              kBlueColor,
              'Other Tasks',
              'other',
              controller.otherTasks,
            ]);
          },
          child: Container(
            width: Get.width * 0.475,
            height: 130,
            decoration: BoxDecoration(
              color: kBlueColor,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(50),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            '${controller.otherTasks.length} Tasks',
                            style: const TextStyle(
                              color: Colors.black38,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Text(
                          'Other',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black12,
                      child: Center(
                        child: Icon( Icons.other_houses_outlined,
                          color: kBlackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
