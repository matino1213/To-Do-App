import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/home/controller.dart';

import '../../constants.dart';

class CategoryWidget extends GetView<HomeController> {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          onTap: () {},
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              border: Border.all(
                width: 1.5,
                color: kWhiteColor,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Row(
                children: [
                  Text(
                    'All',
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Obx(
                    () => CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white24,
                      child: Text(
                        (controller.tasksLength.value + controller.notes.length)
                            .toString(),
                        style: TextStyle(
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
