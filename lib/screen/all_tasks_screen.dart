import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/logic/app_cubit.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/screen/screens.dart';
import 'package:todo/translation/locale_keys.g.dart';
import 'package:todo/widgets/todo_tail.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        List<TodoModel>? todoList = [];
        var width = MediaQuery.sizeOf(context).width;
        var height = MediaQuery.sizeOf(context).height;
        for (var item in cubit.todoList!) {
          if (!item.isArchived && !item.isDone) {
            todoList.add(item);
          }
        }
        return todoList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/warning.svg',
                    width: width * 0.125,
                    height: height * 0.125,
                  ),
                  Text(
                    LocaleKeys.no_todo_yet.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IndieFlower',
                    ),
                  )
                ],
              )
            : ListView.separated(
                itemBuilder: (context, index) => TodoTail(
                  todoModel: todoList[index],
                ),
                itemCount: todoList.length,
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: AppColors.secondryColor,
                ),
              );
      },
    );
  }
}
