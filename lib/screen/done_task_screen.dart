import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/logic/app_cubit.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/shared/colors.dart';
import 'package:todo/widgets/todo_tail.dart';
import 'package:todo/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class DoneTask extends StatelessWidget {
  const DoneTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var width = MediaQuery.sizeOf(context).width;
        var height = MediaQuery.sizeOf(context).height;
        var cubit = AppCubit.get(context);
        List<TodoModel>? todoList = [];
        for (var item in cubit.todoList!) {
          if (item.isDone) {
            todoList.add(item);
          }
        }
        return todoList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/done.svg',
                    width: width * 0.125,
                    height: height * 0.125,
                  ),
                  Text(
                    LocaleKeys.no_done_todo.tr(),
                    style: const TextStyle(
                      fontFamily: 'IndieFlower',
                      fontWeight: FontWeight.bold,
                      //  fontSize: width * 0.05,
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
                    ));
      },
    );
  }
}
