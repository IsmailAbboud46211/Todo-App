import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:todo/logic/app_cubit.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/screen/screens.dart';
import 'package:todo/service/notify_service.dart';
import 'package:todo/shared/validation_functions.dart';
import 'package:todo/widgets/custom_text_form_field.dart';
import 'package:todo/widgets/custom_drawer.dart';
import 'package:todo/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    PageController controller = PageController(initialPage: 0);
    TextEditingController titleTextEditingController = TextEditingController();
    TextEditingController descriptionTextEditingController =
        TextEditingController();
    final formKey = GlobalKey<FormState>();
    var navBarItems = [
      GButton(
        icon: Icons.home,
        text: LocaleKeys.home.tr(),
      ),
      GButton(
        icon: Icons.done,
        text: LocaleKeys.done.tr(),
      ),
      GButton(
        icon: Icons.archive,
        text: LocaleKeys.archive.tr(),
      ),
    ];
    //#Gnerate unifue id for each notification
    int generateUniqueId() {
      Random random = Random();
      return random.nextInt(1000000); // You can adjust the range as needed
    }

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: const CustomDrawer(),
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.secondryColor,
            ),
            backgroundColor: Colors.transparent,
            title: Text(
              cubit.titlesList[cubit.currentIndex].tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: 'IndieFlower',
              ),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: AppColors.secondryColor,
            ),
          ),
          body: PageView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {},
            children: cubit.screensList,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 15,
            ),
            child: GNav(
                gap: 8,
                color: Colors.grey.shade600,
                tabBackgroundColor: AppColors.primaryColor,
                activeColor: Colors.white,
                onTabChange: (index) {
                  cubit.setBottomNavBarIndex(index);
                  controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                padding: const EdgeInsets.all(16),
                tabs: navBarItems),
          ),
          floatingActionButton: Padding(
            padding: context.locale == const Locale('ar')
                ? EdgeInsets.only(right: width * 0.09)
                : EdgeInsets.only(right: width * 0.001),
            child: Align(
              alignment: Alignment.bottomRight,
              widthFactor: width * 0.05,
              child: FloatingActionButton(
                backgroundColor: AppColors.secondryColor,
                tooltip: LocaleKeys.add_new_todo.tr(),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.secondryColor,
                      title: Center(
                        child: Text(
                          LocaleKeys.add_new_todo.tr(),
                          style: TextStyle(
                            color: AppColors.lightGreen,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'IndieFlower',
                          ),
                        ),
                      ),
                      content: BlocBuilder<AppCubit, AppState>(
                        builder: (context, state) {
                          return Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomTextFormField(
                                    controller: titleTextEditingController,
                                    labekText: LocaleKeys.title.tr(),
                                    hintText: LocaleKeys.title_hint.tr(),
                                    prefixIcon: const Icon(Icons.title),
                                    validator: titleValidation,
                                  ),
                                  SizedBox(
                                    height: height * 0.025,
                                  ),
                                  CustomTextFormField(
                                    controller:
                                        descriptionTextEditingController,
                                    labekText: LocaleKeys.description.tr(),
                                    hintText: LocaleKeys.description_hint.tr(),
                                    prefixIcon:
                                        const Icon(Icons.description_outlined),
                                    validator: discreptionValidation,
                                  ),
                                  SizedBox(
                                    height: height * 0.025,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      maximumSize: Size.infinite,
                                    ),
                                    onPressed: () {
                                      cubit.pickDate(context);
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                            Icons.calendar_month_outlined,
                                            color: Colors.white),
                                        Text(
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          DateFormat.yMMMEd().format(
                                            cubit.initDate,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        const Icon(Icons.timer,
                                            color: Colors.white),
                                        Text(
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          " ${cubit.initTime.hour}:${cubit.initTime.minute}",
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.025,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton.icon(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                            (states) => Colors.white,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.cancel,
                                          color: AppColors.primaryColor,
                                        ),
                                        label: Text(
                                          LocaleKeys.cancel.tr(),
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                      TextButton.icon(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                            (states) => AppColors.primaryColor,
                                          ),
                                        ),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            var notificationID =
                                                generateUniqueId();
                                            cubit.addTodo(
                                              TodoModel(
                                                title:
                                                    titleTextEditingController
                                                        .text,
                                                description:
                                                    descriptionTextEditingController
                                                        .text,
                                                date: cubit.timeAndDate,
                                                isArchived: false,
                                                isDone: false,
                                                notificationID: notificationID,
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    "${titleTextEditingController.text} ${LocaleKeys.add_message.tr()}"),
                                                backgroundColor:
                                                    AppColors.green,
                                              ),
                                            );
                                            NotificationService()
                                                .schduleNotification(
                                              title: titleTextEditingController
                                                  .text,
                                              body:
                                                  descriptionTextEditingController
                                                      .text,
                                              scheduleNotificationDateTime:
                                                  cubit.timeAndDate,
                                              id: notificationID,
                                            );
                                            titleTextEditingController.clear();
                                            descriptionTextEditingController
                                                .clear();
                                            Navigator.pop(context);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          LocaleKeys.add.tr(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
