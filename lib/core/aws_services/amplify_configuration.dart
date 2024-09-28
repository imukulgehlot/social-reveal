import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../utils/logger_util.dart';

class CognitoHelpingHand {
  static final _amplifyConfig = jsonEncode({
    "UserAgent": "aws-amplify-cli/1.6.0",
    "Version": "1.0",
    "auth": {
      "plugins": {
        "awsCognitoAuthPlugin": {
          "IdentityManager": {"Default": {}},
          "CredentialsProvider": {
            "CognitoIdentity": {
              "Default": {
                "PoolId": "",
                "Region": ""
              }
            }
          },
          "CognitoUserPool": {
            "Default": {
              "PoolId": "",
              "AppClientId": "",
              "Region": ""
            }
          },
          "Auth": {
            "Default": {
              "authenticationFlowType": "USER_SRP_AUTH",
              "OAuth": {
                "WebDomain": "",
                "AppClientId": "",
                "SignInRedirectURI":
                    "[CUSTOM REDIRECT SCHEME AFTER SIGN IN, e.g. myapp://]",
                "SignOutRedirectURI":
                    "[CUSTOM REDIRECT SCHEME AFTER SIGN OUT, e.g. myapp://]",
                "Scopes": [
                  "phone",
                  "email",
                  "openid",
                  "profile",
                  "aws.cognito.signin.user.admin"
                ]
              }
            }
          }
        }
      }
    }
  });

  static Future<void> configureAmplify() async {
    Amplify.addPlugins([AmplifyAuthCognito()]);

    try {
      await Amplify.configure(_amplifyConfig);
      logger.i('Amplify configured successfully');
    } catch (e) {
      logger.e('Error configuring Amplify: $e');
    }
  }
}
