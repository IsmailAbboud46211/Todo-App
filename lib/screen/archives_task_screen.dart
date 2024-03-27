import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/logic/app_cubit.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/shared/colors.dart';
import 'package:todo/widgets/todo_tail.dart';
import 'package:todo/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ArchivesTask extends StatelessWidget {
  const ArchivesTask({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        List<TodoModel>? todoList = [];
        for (var item in cubit.todoList!) {
          if (item.isArchived) {
            todoList.add(item);
          }
        }
        return todoList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/archive-3.svg',
                    width: width * 0.125,
                    height: height * 0.125,
                  ),
                  Text(
                    LocaleKeys.no_archived_todo.tr(),
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
