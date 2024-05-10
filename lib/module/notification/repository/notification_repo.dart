import 'dart:io';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_app/core/utils/app_constants.dart';
import 'package:shoes_app/data/services/api_client.dart';

class NotificationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  NotificationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getNotificationList(String offset, String type) async {
    final token = sharedPreferences.getString(AppConstants.TOKEN);
    return await apiClient.getData(
        '${AppConstants.NOTIFICATION_URI}$offset&type=$type',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        apiVersion: WooApiVersion.noWooApi);
  }

  void saveSeenNotificationCount(int count) {
    sharedPreferences.setInt(AppConstants.NOTIFICATION_COUNT, count);
  }

  int? getSeenNotificationCount() {
    return sharedPreferences.getInt(AppConstants.NOTIFICATION_COUNT);
  }
}
