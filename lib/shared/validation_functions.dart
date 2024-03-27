import 'package:easy_localization/easy_localization.dart';
import 'package:todo/translation/locale_keys.g.dart';

String? titleValidation(String? value) {
  if (value!.isEmpty) {
    return LocaleKeys.title_validation.tr();
  }
  return null;
}

String? discreptionValidation(value) {
  if (value!.isEmpty) {
    return LocaleKeys.description_validation.tr();
  }
  return null;
}
