import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo/logic/app_cubit.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/screen/screens.dart';
import 'package:todo/screen/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo/translation/codegen_loader.g.dart';

const String todoBoxName = "todos";
const String themeBoxName = "settings";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await EasyLocalization.ensureInitialized();
  final documents = await getApplicationDocumentsDirectory();
  Hive.init(documents.path);
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.initFlutter();
  await Hive.openBox<TodoModel>(todoBoxName);
  await Hive.openBox("settings");
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      assetLoader: const CodegenLoader(),
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => AppCubit()..getBox(),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: Hive.box("settings").listenable(),
        builder: (BuildContext context, Box box, Widget? child) {
          final isDarkMode = box.get(
            "isDarkMode",
            defaultValue: false,
          );
          final isArabic = box.get(
            "isArabic",
            defaultValue: false,
          );
          return MaterialApp(
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: isArabic ? const Locale('ar') : const Locale('en'),
            title: 'Todo App',
            theme: isDarkMode
                ? ThemeData.dark(useMaterial3: true).copyWith(
                    colorScheme: ColorScheme.dark(
                      primary: AppColors.primaryColor,
                    ),
                  )
                : ThemeData.light(useMaterial3: true).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.primaryColor,
                    ),
                  ),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
