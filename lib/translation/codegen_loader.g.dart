// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> ar = {
    "home": "الرئيسية",
    "done": "تم",
    "archive": "الأرشيف",
    "all_todos": "كل المهام",
    "no_todo_yet": " ليس لديك أي مهام بعد !",
    "no_done_todo": " لم تقم بإتمام أي مهمة بعد !",
    "no_archived_todo": " الأرشيف فارغ !",
    "settings": "الإعدادات",
    "dark_mode": "الوضع المظلم",
    "arabic_language": "لغة عربية",
    "add_new_todo": "أضف عمل جديد",
    "title": "العنوان",
    "description": "الوصف",
    "add": "إضافة",
    "cancel": "إلغاء",
    "title_validation": "من فضلك أدخل عنوان العمل",
    "description_validation": "من فضلك أدخل وصف المهمة",
    "done_message": "عظيم!! لقد قمت بإنهاء هذه المهمة",
    "archive_message": "تمت أرشفتها",
    "delete_message": "تم حذفها",
    "add_message": "تمت إضافة",
    "warning_message": "هل أنت متأكد من حذف هذه المهمة؟",
    "warning_message_content": "لايمكنك إستعادتها !",
    "manage_notifications": "إدارة الإشعارات",
    "title_hint": "أدخل العنوان",
    "description_hint": "أدخل الوصف",
    "remove_from_archive_message": "تمت إزالتها من الأرشيف",
    "ok": "موافق",
    "contact_with_me": "تواصل معي",
    "could_not_lunch": "لايمكن تحميل ",
    "notification_alert": " درجة أولوية إشعارات التذكير بالمهام (قوة التنبيه):",
    "note":
        " ملاحظة: يتم معاملة جميع الإشعارات بالأولوية ذاتها ، وذلك لضمان  العمل الفعال للتطبيق.\nأولوية تنبيه الأشعارات الإفتراضية هي العظمى.",
    "max": "عظمى",
    "high": "مرتفعة",
    "low": "منخفضة",
    "max_subtitle": "تنبيه مرتفع جداً (موصى به)",
    "high_subtitle": "تنبيه مرتفع",
    "low_subtitle": "تنبيه منخفص",
    "min_subtitle": " إشعار فقط دون تنبيه(غير موصى به)",
    "change_notification_settings": "تم تعديل أولوية الإشعارات",
    "min": "صغرى"
  };
  static const Map<String, dynamic> en = {
    "home": "Home",
    "done": "Done",
    "archive": "Archive",
    "all_todos": "All Todos",
    "no_todo_yet": "You don't  have any tasks yet !",
    "no_done_todo": " You haven't completed any tasks yet !",
    "no_archived_todo": "The archive is empty !",
    "settings": "Settings",
    "dark_mode": "Dark Mode",
    "arabic_language": "Arabic Language",
    "add_new_todo": "Add a new todo",
    "title": "Title",
    "description": "Description",
    "add": "add",
    "cancel": "cancel",
    "title_validation": "Please Enter the title of the task",
    "description_validation": "Please Enter the description of the task",
    "done_message": "Great!! You have completed this task",
    "archive_message": "Archived",
    "delete_message": "Deleted",
    "add_message": "Added",
    "warning_message": "Are you sure you want to delete this task?",
    "warning_message_content": "You can't restore it !",
    "manage_notifications": "Manage notifications",
    "title_hint": "Enter the title",
    "description_hint": "Enter the description",
    "remove_from_archive_message": "Removed from archive",
    "ok": "Ok",
    "contact_with_me": "Contact with me",
    "could_not_lunch": "Could not lunch",
    "notification_alert":
        "Priority of task reminder notifications (alert strength):",
    "note":
        "Note: All notifications are treated with the same priority, to ensure the effective working of the application.\nThe default notification alert priority is Max.",
    "max": "Max",
    "high": "High",
    "low": "low",
    "max_subtitle": "Mobile vibration, very loud alarm (recommended).",
    "high_subtitle": "High alert",
    "low_subtitle": "Low alert",
    "min_subtitle": "A notification without alert (not recommended).",
    "change_notification_settings":
        "The priority of notifications has been modified",
    "min": "min",
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": ar,
    "en": en
  };
}
