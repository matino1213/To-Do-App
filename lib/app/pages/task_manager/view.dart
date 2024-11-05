import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/app/pages/home/controller.dart';

import '../../../constants.dart';
import '../../../models/task.dart';

class TaskManagerPage extends GetView<HomeController> {
  TaskManagerPage({super.key});

  final Color color = Get.arguments[0];
  final String title = Get.arguments[1];
  final String topic = Get.arguments[2];
  final List<Task> tasks = Get.arguments[3];

  @override
  Widget build(BuildContext context) {
    Box tasksBox = Hive.box('tasks');
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        elevation: 0,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              if (tasks.isNotEmpty) ...[
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
                          return task.topic == topic
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
                                      duration: const Duration(seconds: 3),
                                      isDismissible: true,
                                      forwardAnimationCurve: Curves.easeOutBack,
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
                                        controller.onTaskClick(task, index);
                                      },
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      child: IntrinsicHeight(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
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
                                                      color: Colors.black54,
                                                    )
                                                  : const Icon(
                                                      CupertinoIcons.circle,
                                                      color: Colors.black,
                                                    ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  textDirection: controller
                                                      .textDirection.value,
                                                  task.text,
                                                  style: task.isDone
                                                      ? const TextStyle(
                                                          color: Colors.black54,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        )
                                                      : const TextStyle(
                                                          color: Colors.black,
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
                        separatorBuilder: (BuildContext context, int index) {
                          Task task = value.getAt(index);
                          return task.topic == topic
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
      floatingActionButton: Material(
        color: kBlackColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        child: InkWell(
          onTap: () {
            Get.bottomSheet(BottomSheet(
              backgroundColor: Colors.transparent,
              onClosing: () {},
              builder: (context) {
                return Container(
                  height: 400,
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
                          height: 50,
                        ),
                        InkWell(
                          onTap: () {
                            controller.addTask(topic);
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
            ));
          },
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          child: const SizedBox(
            height: 90,
            width: 90,
            child: Center(
              child: Icon(
                CupertinoIcons.plus,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
