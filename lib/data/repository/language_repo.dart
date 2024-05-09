import 'package:flutter/material.dart';
import 'package:shoes_app/core/utils/app_constants.dart';
import 'package:shoes_app/models/language_model.dart';

class LanguageRepo {
  List<LanguageModel?> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }
}
