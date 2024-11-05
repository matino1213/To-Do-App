import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/note_editor/controller.dart';

class NoteEditorPage extends GetView<NoteEditorController> {
  const NoteEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.bgColor,
      appBar: AppBar(
        backgroundColor: controller.bgColor,
        title: Text(
          controller.note.title,
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => TextField(
            onChanged: (value) {
              controller.updateNote();
              if (value.isEmpty) {
                controller.resetTextDirection();
              } else if (!controller.isDirectionSet.value) {
                controller.setTextDirection(value[0]);
              }
            },
            autofocus: true,
            controller: controller.textController,
            textDirection: controller.textDirection.value,
            maxLines: null,
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black, fontSize: 18),
            decoration: const InputDecoration(
              hintText: 'Write your note here...',
              hintStyle: TextStyle(color: Colors.black54),
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.multiline,
          ),
        ),
      ),
    );
  }
}
