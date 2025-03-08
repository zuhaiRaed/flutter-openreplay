import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'openreplay_sdk_method_channel.dart';

abstract class OpenreplaySdkPlatform extends PlatformInterface {
  OpenreplaySdkPlatform() : super(token: _token);

  static final Object _token = Object();
  static OpenreplaySdkPlatform _instance = MethodChannelOpenreplaySdk();

  static OpenreplaySdkPlatform get instance => _instance;

  static set instance(OpenreplaySdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initialize(String projectKey) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<void> startSession() {
    throw UnimplementedError('startSession() has not been implemented.');
  }

  Future<void> stopSession() {
    throw UnimplementedError('stopSession() has not been implemented.');
  }

  Future<void> setMetadata(String key, String value) {
    throw UnimplementedError('setMetadata() has not been implemented.');
  }

  Future<void> logEvent(String eventName, Map<String, dynamic> payload) {
    throw UnimplementedError('logEvent() has not been implemented.');
  }
}
