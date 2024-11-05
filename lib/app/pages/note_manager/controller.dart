import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:to_do/models/note.dart';

class NoteManagerController extends GetxController {
  TextEditingController noteController = TextEditingController();
  RxInt colorId = 0.obs;

  colorIdChange() {
    if (colorId.value < 3) {
      colorId.value++;
    } //
    else {
      colorId.value = 0;
    }
  }

  addNote() {
    if (noteController.text.isNotEmpty) {
      Box box = Hive.box('notes');
      Note note = Note(text: '', title: noteController.text);
      box.add(note);
      noteController.clear();
      Get.back();
    } else {
      Get.snackbar('Error', 'Please enter note title');
    }
  }
}
