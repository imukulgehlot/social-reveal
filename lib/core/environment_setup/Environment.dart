import 'BaseConfig.dart';
import 'BuildConfig.dart';

class Environment {

  static final Environment _instance = Environment._();

  Environment._();

  factory Environment() {
    return _instance;
  }

  static late BaseConfig config;

  initConfig(String environment) {
    config = _configMap[environment] ?? DevConfig();
  }



  static const String DEV = 'DEV';
  static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';

  final Map<String, BaseConfig> _configMap = {
    Environment.PROD: ProdConfig(),
    Environment.STAGING: StagingConfig(),
    Environment.DEV: DevConfig()
  };
}
