import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class MyAnalyticsHelper {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> testEventLog(_value) async {
    await analytics
        .logEvent(name: '${_value}_click', parameters: {'Value': _value});
    print('Send Event');
  }

  Future<void> testAllEventTypes() async {
    await analytics.logSignUp(signUpMethod: 'Sign Up');
    await analytics.logLogin(loginMethod: 'Login');
  }
}
