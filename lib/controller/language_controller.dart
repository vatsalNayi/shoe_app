import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_app/core/utils/app_constants.dart';
import 'package:shoes_app/models/language_model.dart';

class LanguageController extends GetxController {
  final SharedPreferences? sharedPreferences;
  LanguageController({this.sharedPreferences});

  int _selectIndex = 0;
  int get selectIndex => _selectIndex;

  void setSelectIndex(int index) {
    _selectIndex = index;
    update();
  }

  List<LanguageModel?> _languages = [];
  List<LanguageModel?> get languages => _languages;

  void searchLanguage(String query, BuildContext context) {
    if (query.isEmpty) {
      _languages.clear();
      _languages = AppConstants.languages;
      update();
    } else {
      _selectIndex = -1;
      _languages = [];
      AppConstants.languages.forEach((product) async {
        if (product!.languageName!
            .toLowerCase()
            .contains(query.toLowerCase())) {
          _languages.add(product);
        }
      });
      update();
    }
  }

  void initializeAllLanguages(BuildContext context) {
    if (_languages.length == 0) {
      _languages.clear();
      _languages = AppConstants.languages;
    }
  }
}
