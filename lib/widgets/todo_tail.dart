import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/logic/app_cubit.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/screen/screens.dart';
import 'package:todo/service/notify_service.dart';
import 'package:todo/translation/locale_keys.g.dart';
import 'dart:ui' as ui;

class TodoTail extends StatelessWidget {
  final TodoModel todoModel;
  const TodoTail({required this.todoModel, super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                todoModel.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todoModel.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(
                    height * 0.002,
                  ),
                  child: Text(
                    context.locale == const Locale('en')
                        ? DateFormat.yMMMEd('en').format(
                            todoModel.date,
                          )
                        : DateFormat.yMMMEd('ar').format(
                            todoModel.date,
                          ),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.all(
                    height * 0.002,
                  ),
                  child: Directionality(
                    textDirection: context.locale == const Locale('en')
                        ? ui.TextDirection.ltr
                        : ui.TextDirection.rtl,
                    child: Text(
                      context.locale == const Locale('en')
                          ? DateFormat.jm('en').format(
                              todoModel.date,
                            )
                          : DateFormat.jm('ar').format(
                              todoModel.date,
                            ),
                    ),
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: !todoModel.isDone,
                  child: IconButton(
                    onPressed: () {
                      cubit.updateTodo(
                        TodoModel(
                          title: todoModel.title,
                          description: todoModel.description,
                          date: todoModel.date,
                          isDone: true,
                          isArchived: false,
                          notificationID: todoModel.notificationID,
                        ),
                      );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${todoModel.title}  ${LocaleKeys.done_message.tr()}",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: AppColors.green,
                          ),
                        );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.green,
                      ),
                    ),
                    icon: const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  ),
                ),
                Visibility(
                  visible: todoModel.isArchived,
                  child: IconButton(
                    onPressed: () {
                      cubit.updateTodo(
                        TodoModel(
                          title: todoModel.title,
                          description: todoModel.description,
                          date: todoModel.date,
                          isDone: false,
                          isArchived: false,
                          notificationID: todoModel.notificationID,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            " ${todoModel.title} ${LocaleKeys.remove_from_archive_message.tr()}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: AppColors.grey,
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.grey,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Visibility(
                  visible: !todoModel.isArchived,
                  child: IconButton(
                    onPressed: () {
                      cubit.updateTodo(
                        TodoModel(
                          title: todoModel.title,
                          description: todoModel.description,
                          date: todoModel.date,
                          isDone: false,
                          isArchived: true,
                          notificationID: todoModel.notificationID,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${todoModel.title}  ${LocaleKeys.archive_message.tr()}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.grey,
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.lightGrey,
                      ),
                    ),
                    icon: const Icon(
                      Icons.archive,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      btnCancelText: LocaleKeys.cancel.tr(),
                      btnOkText: LocaleKeys.ok.tr(),
                      animType: AnimType.scale,
                      btnCancelColor: AppColors.green,
                      btnOkColor: AppColors.red,
                      title: LocaleKeys.warning_message.tr(),
                      desc: LocaleKeys.warning_message_content.tr(),
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        cubit.deleteTodo(todoModel);
                        NotificationService().cancelNotification(
                          notificationId: todoModel.notificationID,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${todoModel.title} ${LocaleKeys.delete_message.tr()}",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: AppColors.red,
                          ),
                        );
                      },
                    ).show();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                      (states) => AppColors.red,
                    ),
                  ),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
