import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/home/controller.dart';
import 'package:to_do/constants.dart';

class CustomBottomSheet extends GetView<HomeController> {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.transparent,
      onClosing: () {},
      builder: (context) {
        return Container(
          height: 600,
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: controller.taskController,
                  cursorColor: kWhiteColor,
                  style: TextStyle(
                    color: kWhiteColor,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kBlueColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kRedColor,
                      ),
                    ),
                    hintText: 'Enter Task',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => DropdownButton(
                    value: controller.category.value,
                    dropdownColor: Colors.black,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    style: TextStyle(
                      color: kWhiteColor,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'day',
                        child: Text('Plan for The Day'),
                      ),
                      DropdownMenuItem(
                        value: 'week',
                        child: Text('Plan for The Week'),
                      ),
                      DropdownMenuItem(
                        value: 'work',
                        child: Text('Work'),
                      ),
                      DropdownMenuItem(
                        value: 'other',
                        child: Text('Other'),
                      ),
                    ],
                    elevation: 4,
                    underline: Container(
                      height: 2,
                      color: kYellowColor,
                    ),
                    onChanged: (String? value) {
                      controller.category.value = value!;
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    controller.addTask(controller.category.value);
                  },
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  child: Container(
                    width: Get.width,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: kYellowColor,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 28,
                          color: kBlueColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
