import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/app/common/app_route.dart';
import 'package:to_do/app/pages/home/controller.dart';
import 'package:to_do/models/task.dart';

import '../../constants.dart';

class DailyNoteWidget extends GetView<HomeController> {
  const DailyNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Box tasksBox = Hive.box('tasks');
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoute.TASKMANAGER, arguments: [
                kRedColor,
                'Plan For The Day',
                'day',
                controller.dailyTasks,
              ]);
            },
            child: Container(
              height: 300,
              width: Get.width * 0.475,
              decoration: BoxDecoration(
                color: kRedColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                      width: Get.width,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: Get.width * 0.12,
                            right: Get.width * 0.12,
                            child: SizedBox(
                              width: 30,
                              child: Divider(
                                color: kBlackColor,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            left: Get.width * 0.16,
                            right: Get.width * 0.16,
                            child: Divider(
                              color: kBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.22,
                          child: Text(
                            'Plan for The Day',
                            style: TextStyle(
                                color: kBlackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.2),
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black12,
                          child: Center(
                            child: Icon(
                              Icons.today_outlined,
                              color: kBlackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (controller.dailyTasks.isNotEmpty) ...[
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: tasksBox.listenable(),
                          builder: (context, value, child) {
                            return ListView.separated(
                              itemCount: tasksBox.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                Task task = value.getAt(index);
                                controller.setTextDirection(task.text[0]);
                                return task.topic == 'day'
                                    ? Dismissible(
                                        key: Key(task.text),
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (direction) {
                                          tasksBox.deleteAt(index);
                                          controller.getInformation();
                                          Get.snackbar(
                                            'Task Deleted',
                                            '${task.text} has been deleted',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.black,
                                            borderRadius: 10,
                                            margin: const EdgeInsets.all(10),
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                            ),
                                            duration:
                                                const Duration(seconds: 3),
                                            isDismissible: true,
                                            forwardAnimationCurve:
                                                Curves.easeOutBack,
                                          );
                                        },
                                        background: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        child: Material(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          color: Colors.black12,
                                          child: InkWell(
                                            onTap: () {
                                              controller.onTaskClick(
                                                  task, index);
                                            },
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            child: IntrinsicHeight(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    task.isDone
                                                        ? const Icon(
                                                            CupertinoIcons
                                                                .check_mark_circled_solid,
                                                            color:
                                                                Colors.black54,
                                                          )
                                                        : const Icon(
                                                            CupertinoIcons
                                                                .circle,
                                                            color: Colors.black,
                                                          ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        task.text,
                                                        textDirection:
                                                            controller
                                                                .textDirection
                                                                .value,
                                                        style: task.isDone
                                                            ? const TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                              )
                                                            : const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container();
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                Task task = value.getAt(index);
                                return task.topic == 'day'
                                    ? const SizedBox(
                                        height: 5,
                                      )
                                    : Container();
                              },
                            );
                          },
                        ),
                      ),
                    ] //
                    else ...[
                      const Center(
                        child: Text('No task'),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoute.TASKMANAGER, arguments: [
                kYellowColor,
                'Plan For The Week',
                'week',
                controller.weeklyTasks,
              ]);
            },
            child: Container(
              height: 300,
              width: Get.width * 0.475,
              decoration: BoxDecoration(
                color: kYellowColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                  topLeft: Radius.circular(60),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                      width: Get.width,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: Get.width * 0.12,
                            right: Get.width * 0.12,
                            child: SizedBox(
                              width: 30,
                              child: Divider(
                                color: kBlackColor,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            left: Get.width * 0.16,
                            right: Get.width * 0.16,
                            child: Divider(
                              color: kBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.22,
                          child: Text(
                            'Plan for The Week',
                            style: TextStyle(
                                color: kBlackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.2),
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black12,
                          child: Center(
                            child: Icon(
                              Icons.calendar_month_outlined,
                              color: kBlackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (controller.weeklyTasks.isNotEmpty) ...[
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: tasksBox.listenable(),
                          builder: (context, value, child) {
                            return ListView.separated(
                              itemCount: tasksBox.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                Task task = value.getAt(index);
                                controller.setTextDirection(task.text[0]);
                                return task.topic == 'week'
                                    ? Dismissible(
                                        key: Key(task.text),
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (direction) {
                                          tasksBox.deleteAt(index);
                                          controller.getInformation();
                                          Get.snackbar(
                                            'Task Deleted',
                                            '${task.text} has been deleted',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.black,
                                            borderRadius: 10,
                                            margin: const EdgeInsets.all(10),
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                            ),
                                            duration:
                                                const Duration(seconds: 3),
                                            isDismissible: true,
                                            forwardAnimationCurve:
                                                Curves.easeOutBack,
                                          );
                                        },
                                        background: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        child: Material(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          color: Colors.black12,
                                          child: InkWell(
                                            onTap: () {
                                              controller.onTaskClick(
                                                  task, index);
                                            },
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            child: IntrinsicHeight(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    task.isDone
                                                        ? const Icon(
                                                            CupertinoIcons
                                                                .check_mark_circled_solid,
                                                            color:
                                                                Colors.black54,
                                                          )
                                                        : const Icon(
                                                            CupertinoIcons
                                                                .circle,
                                                            color: Colors.black,
                                                          ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        textDirection:
                                                            controller
                                                                .textDirection
                                                                .value,
                                                        task.text,
                                                        style: task.isDone
                                                            ? const TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                              )
                                                            : const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container();
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                Task task = value.getAt(index);
                                return task.topic == 'week'
                                    ? const SizedBox(
                                        height: 5,
                                      )
                                    : Container();
                              },
                            );
                          },
                        ),
                      ),
                    ] //
                    else ...[
                      const Center(
                        child: Text('No task'),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}