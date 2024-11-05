import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glossy/glossy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/app/common/app_route.dart';
import 'package:to_do/app/pages/note_manager/controller.dart';
import 'package:to_do/constants.dart';
import 'package:to_do/models/note.dart';

class NoteManagerPage extends GetView<NoteManagerController> {
  const NoteManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Box notesBox = Hive.box('notes');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPinkColor,
      ),
      backgroundColor: kPinkColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(
                width: 180,
                child: Text(
                  'My Notes',
                  style: TextStyle(
                    height: 1.2,
                    color: kBlackColor,
                    fontSize: 60,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: notesBox.listenable(),
                builder: (context, value, child) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                    ),
                    itemCount: value.length,
                    itemBuilder: (BuildContext context, int index) {
                      Note note = value.getAt(index);
                      controller.colorIdChange();
                      int colorId = controller.colorId.value;
                      return GestureDetector(
                        onTap: () => Get.toNamed(
                          AppRoute.NOTEEDITOR,
                          arguments: [
                            colorId,
                            note,
                            index,
                          ],
                        ),
                        onLongPress: () {
                          Get.bottomSheet(
                            GlossyContainer(
                              height: 200,
                              color: Colors.white,
                              width: Get.width,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Are you sure you want to delete this note?',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Material(
                                        color: Colors.red,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            notesBox.deleteAt(index);
                                            Get.back();
                                            Get.snackbar(
                                              'Note Deleted',
                                              '${note.title} has been deleted',
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
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          child: SizedBox(
                                            height: 50,
                                            width: Get.width * 0.45,
                                            child: Center(
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: kBlackColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          child: SizedBox(
                                            height: 50,
                                            width: Get.width * 0.45,
                                            child: Center(
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: kBlackColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: colors[controller.colorId.value],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    note.title,
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black38,
                                  ),
                                  const Divider(
                                    color: Colors.black38,
                                  ),
                                  const Divider(
                                    color: Colors.black38,
                                  ),
                                  const Divider(
                                    color: Colors.black38,
                                  ),
                                  const Divider(
                                    color: Colors.black38,
                                  ),
                                  const Divider(
                                    color: Colors.black38,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Material(
        color: Colors.black,
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
                          controller: controller.noteController,
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
                            hintText: 'Enter Title',
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () {
                            controller.addNote();
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
    );
  }
}
