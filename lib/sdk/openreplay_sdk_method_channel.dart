import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'openreplay_sdk_platform_interface.dart';

/// An implementation of [OpenreplaySdkPlatform] that uses method channels.
class MethodChannelOpenreplaySdk extends OpenreplaySdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('openreplay_sdk');

  @override
  Future<void> initialize(String projectKey) async {
    await methodChannel.invokeMethod<void>('initialize', {
      'projectKey': projectKey,
    });
  }

  @override
  Future<void> startSession() async {
    await methodChannel.invokeMethod<void>('startSession');
  }

  @override
  Future<void> stopSession() async {
    await methodChannel.invokeMethod<void>('stopSession');
  }

  @override
  Future<void> setMetadata(String key, String value) async {
    await methodChannel.invokeMethod<void>('setMetadata', {
      'key': key,
      'value': value,
    });
  }

  @override
  Future<void> logEvent(String eventName, Map<String, dynamic> payload) async {
    await methodChannel.invokeMethod<void>('logEvent', {
      'eventName': eventName,
      'payload': payload,
    });
  }
}
