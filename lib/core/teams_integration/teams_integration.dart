import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../basic_features.dart';

Future<void> initializeTeams() async {
  await Future.delayed(const Duration(seconds: 2));
  FlutterError.onError = (details) {
    PostToTeams post = getPostToTeams(logsToTeams: details.toString());

    FlutterError.presentError(details);
    // if (!kDebugMode) {

    sendLogsToTeams(post.toJson());
    // }
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // if (!kDebugMode) {

    PostToTeams post =
        getPostToTeams(logsToTeams: error.toString() + stack.toString());
    sendLogsToTeams(post.toJson());
    // }
    return true;
  };
}

class PostToTeams {
  String? type;
  String? context;
  String? themeColor;
  String? summary;
  List<Sections>? sections;

  PostToTeams(
      this.type, this.context, this.themeColor, this.summary, this.sections);

  PostToTeams.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    context = json['@context'];
    themeColor = json['themeColor'];
    summary = json['summary'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@type'] = type;
    data['@context'] = context;
    data['themeColor'] = themeColor;
    data['summary'] = summary;
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  String? activityTitle;
  String? activitySubtitle;
  String? activityImage;
  List<Facts>? facts;

  Sections(this.activityTitle, this.activitySubtitle, this.activityImage,
      this.facts);

  Sections.fromJson(Map<String, dynamic> json) {
    activityTitle = json['activityTitle'];
    activitySubtitle = json['activitySubtitle'];
    activityImage = json['activityImage'];
    if (json['facts'] != null) {
      facts = <Facts>[];
      json['facts'].forEach((v) {
        facts!.add(Facts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activityTitle'] = activityTitle;
    data['activitySubtitle'] = activitySubtitle;
    data['activityImage'] = activityImage;
    if (facts != null) {
      data['facts'] = facts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Facts {
  String? name;
  String? value;

  Facts(this.name, this.value);

  Facts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

PostToTeams getPostToTeams({required String logsToTeams, String? subtitle}) {
  String? type;
  String? context;
  String? themeColor;
  String? summary;
  List<Facts>? facts = [];
  List<Sections>? sections = [];
  String? activityTitle;
  String? activitySubtitle = subtitle;
  String? activityImage;

  type = "MessageCard";
  context = "http://schema.org/extensions";
  themeColor = "0076D7";
  summary = "New Crash";
  activityTitle = AppString.appName;
  activitySubtitle = activitySubtitle ?? "Crash Type";
  activityImage =
      "https://teamsnodesample.azurewebsites.net/static/img/image5.png";
  String platform = AppUtils.platform;
  String? deviceManufacturer = AppUtils.androidInfo?.manufacturer;
  String? androidDeviceName = AppUtils.androidInfo?.model;
  String? androidVersion = AppUtils.androidInfo?.version.release;
  String? iOSDeviceName = AppUtils.iosInfo?.utsname.machine;
  String? iOSVersion = AppUtils.iosInfo?.systemVersion;
  // String userEmail = StartupService.getUserEmail();
  // String token = StartupService.getToken();
  facts.add(Facts("Date", DateTime.now().toIso8601String()));
  // facts.add(Facts("Build Version", Const.appVersion?.currentVersion ?? ''));
  facts.add(Facts("Platform", platform));
  if (Platform.isIOS) {
    facts.add(Facts("Model", iOSDeviceName ?? ""));
    facts.add(Facts("iOS version", iOSVersion ?? ""));
  } else {
    facts.add(Facts("Device manufacturer", deviceManufacturer ?? ""));
    facts.add(Facts("Model", androidDeviceName ?? ""));
    facts.add(Facts("Android version", androidVersion));
  }

  // facts.add(Facts("User email", userEmail));
  // facts.add(Facts("Token", token));
  facts.add(Facts("Logs", logsToTeams));

  sections.add(Sections(activityTitle, activitySubtitle, activityImage, facts));

  PostToTeams post = PostToTeams(type, context, themeColor, summary, sections);
  return post;
}

Future<http.Response> sendLogsToTeams(Map<String, dynamic> logsToTeams) async {
  String body = json.encode(logsToTeams);
  if (kDebugMode) {
    print("body$body");
  }

  http.Response response = await http.post(
      Uri.parse(
          'https://imperoitservices.webhook.office.com/webhookb2/e8f8b0d8-4ab5-4d20-969a-4c6a6862b282@6a41ae7d-e3bc-4627-9ef5-d53fd00ee77e/IncomingWebhook/7d032b72a3aa4929829c458967413755/c8caaf76-e84a-4c67-8e9a-fbd1ebf1bc3d'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: body);
  if (kDebugMode) {
    print(response.body.toString());
  }
  return response;
}
