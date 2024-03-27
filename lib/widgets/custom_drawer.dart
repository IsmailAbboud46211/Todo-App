import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/screen/home_screen.dart';
import 'package:todo/shared/colors.dart';
import 'package:todo/translation/locale_keys.g.dart';
import 'package:todo/logic/app_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    final height = MediaQuery.sizeOf(context).height;
    var values = [
      LocaleKeys.max.tr(),
      LocaleKeys.high.tr(),
      LocaleKeys.low.tr(),
      LocaleKeys.min.tr(),
    ];
    Map<String, String> subtitles = {
      'Max': LocaleKeys.max_subtitle.tr(),
      'High': LocaleKeys.high_subtitle.tr(),
      'low': LocaleKeys.low_subtitle.tr(),
      'min': LocaleKeys.min_subtitle.tr(),
      'عظمى': LocaleKeys.max_subtitle.tr(),
      'مرتفعة': LocaleKeys.high_subtitle.tr(),
      'منخفضة': LocaleKeys.low_subtitle.tr(),
      'صغرى': LocaleKeys.min_subtitle.tr(),
    };
    Map<String, String> englishValue = {
      'Max': "Max",
      'High': "High",
      'low': "low",
      'min': "min",
      'عظمى': "Max",
      'مرتفعة': "High",
      'منخفضة': "low",
      'صغرى': "min",
    };
    Map<String, String> arabicValue = {
      'Max': "عظمى",
      'High': "مرتفعة",
      'low': "منخفضة",
      'min': "صغرى",
      'عظمى': "عظمى",
      'مرتفعة': "مرتفعة",
      'منخفضة': "منخفضة",
      'صغرى': "صغرى",
    };
    return Drawer(
      child: ListView(
        children: [
          AppBar(
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            toolbarHeight: height * 0.09,
            automaticallyImplyLeading: false,
            title: Text(
              LocaleKeys.settings.tr(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontFamily: 'IndieFlower',
              ),
            ),
            backgroundColor: AppColors.secondryColor,
          ),
          ValueListenableBuilder(
            valueListenable: Hive.box("settings").listenable(),
            builder: (BuildContext context, Box box, Widget? child) {
              final isDarkMode = box.get("isDarkMode", defaultValue: false);
              return SwitchListTile(
                value: isDarkMode,
                secondary: CircleAvatar(
                  backgroundColor: AppColors.lightGrey,
                  child: const Icon(
                    Icons.nightlight,
                    color: Colors.white,
                  ),
                ),
                activeColor: AppColors.primaryColor,
                title: Text(
                  LocaleKeys.dark_mode.tr(),
                ),
                onChanged: (value) {
                  box.put("isDarkMode", value);
                },
              );
            },
          ),
          Divider(
            color: AppColors.secondryColor,
          ),
          ValueListenableBuilder(
            valueListenable: Hive.box("settings").listenable(),
            builder: (BuildContext context, Box box, Widget? child) {
              final isArabic = box.get("isArabic", defaultValue: false);
              return SwitchListTile(
                value: isArabic,
                secondary: CircleAvatar(
                  backgroundColor: AppColors.lightBlue,
                  child: const Icon(
                    Icons.translate_outlined,
                    color: Colors.white,
                  ),
                ),
                activeColor: AppColors.primaryColor,
                title: Text(
                  LocaleKeys.arabic_language.tr(),
                  maxLines: 1,
                ),
                onChanged: (value) {
                  if (value) {
                    context.setLocale(const Locale('ar'));
                    box.put("isArabic", value);
                  } else {
                    context.setLocale(const Locale('en'));
                    box.put("isArabic", value);
                  }
                  cubit.setBottomNavBarIndex(0);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
              );
            },
          ),
          Divider(
            color: AppColors.secondryColor,
          ),
          ListTile(
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppColors.secondryColor,
                  title: Text(
                    LocaleKeys.manage_notifications.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: 'IndieFlower',
                      color: AppColors.lightGreen,
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          LocaleKeys.notification_alert.tr(),
                          style: TextStyle(
                            color: AppColors.lightGreen,
                          ),
                        ),
                        Divider(
                          color: AppColors.lightGreen,
                        ),
                        ValueListenableBuilder(
                          valueListenable: Hive.box("settings").listenable(),
                          builder:
                              (BuildContext context, Box box, Widget? child) {
                            var notificationMode = box.get("notificationMode",
                                defaultValue:
                                    context.locale == const Locale('ar')
                                        ? 'Max'
                                        : 'عظمى');
                            return Column(
                              children: values
                                  .map(
                                    (value) => RadioListTile(
                                      value:
                                          context.locale == const Locale('ar')
                                              ? arabicValue[value]
                                              : englishValue[value],
                                      subtitle: Text(
                                        subtitles[value]!,
                                        style: TextStyle(
                                          color: AppColors.grey,
                                        ),
                                      ),
                                      groupValue:
                                          context.locale == const Locale('ar')
                                              ? arabicValue[notificationMode]
                                              : englishValue[notificationMode],
                                      title: Text(
                                        value,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'IndieFlower',
                                          color: AppColors.lightGreen,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            notificationMode = context.locale ==
                                                    const Locale('ar')
                                                ? arabicValue[value]
                                                : englishValue[value];
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  LocaleKeys
                                                      .change_notification_settings
                                                      .tr(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                backgroundColor: AppColors.grey,
                                              ),
                                            );
                                          },
                                        );
                                        box.put("notificationMode",
                                            englishValue[value]);
                                      },
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                        Divider(
                          color: AppColors.lightGreen,
                        ),
                        Container(
                          padding: EdgeInsets.all(
                            height * 0.01,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              height * 0.01,
                            ),
                            color: AppColors.primaryColor,
                          ),
                          child: Text(
                            LocaleKeys.note.tr(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            LocaleKeys.ok.tr(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundColor: AppColors.yellow,
              child: const Icon(
                Icons.notifications_active,
                color: Colors.white,
              ),
            ),
            title: Text(
              LocaleKeys.manage_notifications.tr(),
            ),
          ),
          Divider(
            color: AppColors.secondryColor,
          ),
          ExpansionTile(
            title: Text(
              LocaleKeys.contact_with_me.tr(),
            ),
            leading: CircleAvatar(
              backgroundColor: AppColors.orange,
              child: const Icon(
                Icons.mail,
                color: Colors.white,
              ),
            ),
            children: [
              ListTile(
                onTap: () async {
                  String? encodeQueryParameters(Map<String, String> params) {
                    return params.entries
                        .map((MapEntry<String, String> e) =>
                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                        .join('&');
                  }

                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: 'ismailtodoapp@gmail.com',
                    query: encodeQueryParameters(
                      <String, String>{
                        'subject': 'Hello from Todo app',
                        'body': "I'am using the app and it's very Good !"
                      },
                    ),
                  );
                  if (await canLaunchUrl(emailUri)) {
                    launchUrl(emailUri);
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${LocaleKeys.could_not_lunch.tr()}$emailUri",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: AppColors.lightGrey,
                      ),
                    );
                  }
                },
                leading: CircleAvatar(
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  child: Image.asset(
                    'assets/google-logo.png',
                    height: height * 0.9,
                    width: height * 0.9,
                  ),
                ),
                title: const InkWell(
                  child: Text(
                    "E-mail",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: 'IndieFlower',
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () async {
                  final url =
                      Uri.parse('https://www.instagram.com/ismailabboud0');
                  if (await canLaunchUrl(url)) {
                    launchUrl(url);
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${LocaleKeys.could_not_lunch.tr()}$url",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: AppColors.lightGrey,
                      ),
                    );
                  }
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    'assets/instagram-logo.png',
                    height: height * 0.1,
                  ),
                ),
                title: const InkWell(
                  child: Text(
                    "Instagram",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: 'IndieFlower',
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: height * 0.4,
          ),
          const Center(
            child: Text(
              "Todo app version 1.0 \n by : eng.Ismail Abboud ",
              style: TextStyle(
                fontFamily: 'IndieFlower',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
