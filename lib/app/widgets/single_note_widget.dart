import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/common/app_route.dart';
import 'package:to_do/app/pages/home/controller.dart';

import '../../constants.dart';

class SingleNoteWidget extends GetView<HomeController> {
  const SingleNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoute.NOTEMANAGER),
      child: Container(
        width: Get.width,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          color: kPinkColor,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30,
              width: Get.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: Get.width * 0.42,
                    right: Get.width * 0.42,
                    child: SizedBox(
                      width: 30,
                      child: Divider(
                        color: kBlackColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    left: Get.width * 0.46,
                    right: Get.width * 0.46,
                    child: Divider(
                      color: kBlackColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: kWhiteColor,
                    child: const Center(
                      child: Text(
                        '🤔',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          '${controller.notes.length} Notes',
                          style: const TextStyle(
                            color: Colors.black38,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Text(
                        'My Notes',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black12,
                    child: Center(
                      child: Icon(
                        Icons.notes,
                        color: kBlackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
