import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:to_do/constants.dart';
import 'package:to_do/models/note.dart';

class NoteEditorController extends GetxController {
  Color bgColor = colors[Get.arguments[0]];
  Note note = Get.arguments[1];
  int index = Get.arguments[2];
  TextEditingController textController = TextEditingController();
  var textDirection = TextDirection.ltr.obs;
  var isDirectionSet = false.obs;

  updateNote() {
    Box box = Hive.box('notes');
    Note newNote = note;
    note.text = textController.text;
    box.putAt(index, newNote);
  }

  void setTextDirection(String firstCharacter) {
    final isRtl = RegExp(r'^[\u0600-\u06FF\s]+$');
    textDirection.value =
        isRtl.hasMatch(firstCharacter) ? TextDirection.rtl : TextDirection.ltr;
  }

  void resetTextDirection() {
    textDirection.value = TextDirection.ltr;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    textController.text = note.text;
    if (note.text.isNotEmpty) {
      setTextDirection(note.text[0]);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    textController.dispose();
  }
}
