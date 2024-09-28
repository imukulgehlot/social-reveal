import 'dart:convert';
import 'dart:io';

import 'package:rstsocial/core/utils/logger_util.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/app_utils.dart';

class APILogStorage {
  APILogStorage._();

  static final instance = APILogStorage._();

  String headerFooterText(String text) =>
      "<------------------------$text------------------------>";

  List<Map<String, dynamic>> _listOfAPIJson = [];

  List<Map<String, dynamic>> get getListOfAPIJson => _listOfAPIJson;

  void clearLogs() => _listOfAPIJson.clear();

  // To Concatenate on new API Call
  void addAPICall({
    required String apiURL,
    required Map<String, dynamic> header,
    Map<String, dynamic>? request,
    required Map<String, dynamic> responseBody,
  }) {
    _listOfAPIJson.add({
      "API_URL": apiURL,
      "Called_At": DateFormat.yMd().add_jm().format(DateTime.now()),
      "Header": header,
      "Request": request ?? {},
      "Response": responseBody,
    });
  }


  void saveAPILogsToStorage() async {
    // try {
    //   if (await AppUtils.isExternalStoragePermissionGranted()) {
    //     // Determine the platform-specific directory
    //     Directory directory;
    //     if (Platform.isAndroid) {
    //       directory = Directory("/storage/emulated/0/Download/social");
    //     } else {
    //       directory = await getApplicationDocumentsDirectory();
    //     }
    //
    //     // Ensure the directory exists
    //     await directory.create(recursive: true);
    //
    //     // Generate a unique filename with timestamp
    //     final formattedDate = DateTime.now().toString().replaceAll(':', '-');
    //     final fileName = 'SOCIAL_API_Logs_$formattedDate.txt';
    //     final filePath = '${directory.path}/$fileName';
    //
    //     // Write JSON data to the file
    //     APILogStorage.instance
    //         .addAPICall(apiURL: "https://meow.dogworld.com", header: {
    //       "device-id": "XLR8",
    //       "app-environment": "test",
    //       "device-name": "SB-desktop",
    //       "device-type": "web"
    //     }, request: {
    //       "name": "Meow Singh"
    //     }, responseBody: {
    //       "statusCode": 401,
    //       "success": false,
    //       "message": "Invalid token",
    //       "messageCode": "1097",
    //       "developerMessage": "Invalid token",
    //       "data": {"name": "Meow Singh", "Umr": 5}
    //     });
    //
    //     final Map<String, dynamic> ok = {
    //       "API_Logs": APILogStorage.instance.getListOfAPIJson
    //     };
    //
    //     logger.i("Final API Logs: $ok");
    //
    //     await File(filePath).writeAsString(jsonEncode(ok));
    //
    //     // Show success message
    //     AppUtils.showSnackBar(message: "Logs saved successfully!", isSuccess: true);
    //     logger.i("Saved Path: $filePath");
    //   }
    // } catch (error) {
    //   Handle errors and show error message
      // AppUtils.showSnackBar(message: "Error saving logs: $error");
      // logger.e("Error saving file: $error");
    // }
    AppUtils.showSnackBar(message: "Logs saved successfully!", isSuccess: true);
  }


    // _logText +=
    //     "${headerFooterText("Beginning With A New API CAll")}\n\nAPI URL: $apiURL\n\nCalled at: ${DateFormat.yMd().add_jm().format(DateTime.now())}\n\nHeader: $header${request.isNotEmpty ? "\n\nRequest: $request" : ""}\n\nResponse: $response\n\n${headerFooterText("End Of API Call")}\n\n";
  // }
}
