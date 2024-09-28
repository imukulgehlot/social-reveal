

import 'BaseConfig.dart';
import 'Environment.dart';

class DevConfig implements BaseConfig {
  @override
  String get apiHost => "";

  @override
  String get environment => Environment.DEV;

  @override
  String get browsDomain => "https://dev.appserver.ie";
}

class StagingConfig implements BaseConfig {
  @override
  String get apiHost => "";

  @override
  String get environment => Environment.STAGING;

  @override
  String get browsDomain => "https://payment-staging.appserver.ie";
}

class ProdConfig implements BaseConfig {
  @override
  String get apiHost => "https://api.appserver.ie/";

  @override
  String get environment => Environment.PROD;

  @override
  String get browsDomain => "https://payment.appserver.ie";
}
