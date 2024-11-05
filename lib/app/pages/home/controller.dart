import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:to_do/models/note.dart';
import 'package:to_do/models/task.dart';

class HomeController extends GetxController {
  RxString category = 'day'.obs;
  RxInt tasksLength = 0.obs;
  TextEditingController taskController = TextEditingController();
  RxList<Task> tasks = <Task>[].obs;
  RxList<Note> notes = <Note>[].obs;
  RxList<Task> dailyTasks = <Task>[].obs;
  RxList<Task> weeklyTasks = <Task>[].obs;
  RxList<Task> workTasks = <Task>[].obs;
  RxList<Task> otherTasks = <Task>[].obs;
  var textDirection = TextDirection.ltr.obs;

  addTask(String topic) async {
    Box box = await Hive.openBox('tasks');
    if (taskController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a task');
    } //
    else {
      Task newTask = Task(
        text: taskController.text,
        isDone: false,
        topic: topic
      );
      box.add(newTask);
      taskController.clear();
      getInformation();
      Get.back();
    }
  }

  void setTextDirection(String firstCharacter) {
    final isRtl = RegExp(r'^[\u0600-\u06FF\s]+$');
    textDirection.value =
    isRtl.hasMatch(firstCharacter) ? TextDirection.rtl : TextDirection.ltr;
  }

  getInformation() async{
    tasks.clear();
    notes.clear();
    dailyTasks.clear();
    weeklyTasks.clear();
    workTasks.clear();
    otherTasks.clear();
    Box box = await Hive.openBox('tasks');
    for(Task item in box.values){
      tasks.add(item);
      if(item.topic == 'day'){
        dailyTasks.add(item);
      }//
      else if(item.topic == 'week'){
        weeklyTasks.add(item);
      }
      else if(item.topic == 'work'){
        workTasks.add(item);
      }
      else{
        otherTasks.add(item);
      }
    }
    Box notesBox = await Hive.openBox('notes');
    for(var item in notesBox.values){
      notes.add(item);
    }
    tasksLength.value = tasks.length;
  }

  onTaskClick(Task task, int index) {
    Box box = Hive.box('tasks');
    task.isDone = !task.isDone;
    box.putAt(index, task);
  }

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getInformation();
  }
}
