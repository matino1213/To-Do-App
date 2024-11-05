import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glossy/glossy.dart';
import 'package:to_do/app/pages/home/controller.dart';
import 'package:to_do/app/widgets/double_note_widget.dart';
import 'package:to_do/constants.dart';

import '../../widgets/category_widget.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../../widgets/daily_note_widget.dart';
import '../../widgets/single_note_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  width: 180,
                  child: Text(
                    'My Tasks',
                    style: TextStyle(
                      height: 1.2,
                      color: kWhiteColor,
                      fontSize: 60,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CategoryWidget(),
              const SizedBox(
                height: 20,
              ),
              const DailyNoteWidget(),
              const SizedBox(
                height: 5,
              ),
              const SingleNoteWidget(),
              const SizedBox(
                height: 5,
              ),
              const DoubleNoteWidget(),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.bottomSheet(
            const CustomBottomSheet(),
          );
        },
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        child: const GlossyContainer(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          height: 90,
          width: 90,
          child: Center(
            child: Icon(
              CupertinoIcons.plus,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
