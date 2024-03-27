import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/screen/screens.dart';
import 'package:todo/translation/locale_keys.g.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppCubitInitialState());

  int currentIndex = 0;
  var initDate = DateTime.now();
  var initTime = TimeOfDay.now();
  var timeAndDate = DateTime.now();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static AppCubit get(context) => BlocProvider.of(context);

  var titlesList = [
    LocaleKeys.all_todos,
    LocaleKeys.done,
    LocaleKeys.archive,
  ];

  var screensList = const [
    AllTasks(),
    DoneTask(),
    ArchivesTask(),
  ];

  void setBottomNavBarIndex(var index) {
    currentIndex = index;
    emit(ChangeNavBarItemState());
  }

  pickDate(BuildContext context) {
    showDatePicker(
            context: context,
            currentDate: initDate,
            firstDate: DateTime.now(),
            lastDate: DateTime(2030),
            initialDate: DateTime.now())
        .then((value) {
      if (value != null) {
        initDate = value;
      }
      emit(SetDateState());
      pickTime(context);
    });
  }

  pickTime(BuildContext context) {
    showTimePicker(context: context, initialTime: initTime).then((value) {
      if (value != null) {
        initTime = value;
        timeAndDate = DateTime(initDate.year, initDate.month, initDate.day,
            initTime.hour, initTime.minute);
      }

      emit(SetDateState());
    });
  }

  List<TodoModel>? todoList = [];
  List<int>? keys = [];
  getBox() async {
    var box = await Hive.openBox<TodoModel>('todos');
    keys = [];
    keys = box.keys.cast<int>().toList();
    todoList = [];
    for (var key in keys!) {
      todoList!.add(box.get(key)!);
    }
    box.close();
    emit(GetBoxState());
  }

  addTodo(TodoModel todoModel) async {
    await Hive.openBox<TodoModel>('todos')
        .then((value) => value.add(todoModel))
        .then(
          (value) => getBox(),
        );
    emit(AddTodotoListSatte());
  }

  updateTodo(TodoModel todoModel) async {
    await Hive.openBox<TodoModel>('todos').then((value) {
      final Map<dynamic, TodoModel> todoMap = value.toMap();
      dynamic desiredKey;
      todoMap.forEach((key, value) {
        if (value.title == todoModel.title) {
          desiredKey = key;
        }
      });
      //To Update the List
      return value.put(desiredKey, todoModel);
    }).then((value) => getBox());
    emit(AddTodotoListSatte());
  }

  deleteTodo(TodoModel todoModel) async {
    await Hive.openBox<TodoModel>('todos').then((value) {
      final Map<dynamic, TodoModel> todoMap = value.toMap();
      dynamic desiredKey;
      todoMap.forEach((key, value) {
        if (todoModel.title == value.title) {
          desiredKey = key;
        }
      });
      //To Update the List
      return value.delete(desiredKey);
    }).then((value) => getBox());
    emit(AddTodotoListSatte());
  }
}
