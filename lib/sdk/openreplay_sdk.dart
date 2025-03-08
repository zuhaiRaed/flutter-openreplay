import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '/models/models.dart';

class OpenReplayFlutter {
  static const MethodChannel _channel = MethodChannel('openreplay_flutter');
  static bool _isInitialized = false;

  static bool get isInitialized => _isInitialized;

  /// Initialize OpenReplay with the provided project key and options.
  ///
  /// This must be called before any other methods.
  static Future<bool> initialize({
    required String projectKey,
    OpenReplayOptions? options,
  }) async {
    if (_isInitialized) {
      return true;
    }

    try {
      final bool result = await _channel.invokeMethod('initialize', {
        'projectKey': projectKey,
        'options': options?.toMap() ?? {},
      });

      _isInitialized = result;
      return result;
    } catch (e) {
      debugPrint('Error initializing OpenReplay: $e');
      return false;
    }
  }

  /// Start a new recording session.
  static Future<bool> startSession() async {
    if (!_isInitialized) {
      debugPrint(
          'startSession: OpenReplay not initialized. Call initialize() first.');
      return false;
    }

    try {
      return await _channel.invokeMethod('startSession');
    } catch (e) {
      debugPrint('startSession: Error starting OpenReplay session: $e');
      return false;
    }
  }

  /// Stop the current recording session.
  static Future<bool> stopSession() async {
    if (!_isInitialized) {
      debugPrint(
          'stopSession: OpenReplay not initialized. Call initialize() first.');
      return false;
    }

    try {
      return await _channel.invokeMethod('stopSession');
    } catch (e) {
      debugPrint('Error stopping OpenReplay session: $e');
      return false;
    }
  }

  /// Set the user ID for the current session.
  static Future<bool> setUserID(String userID) async {
    if (!_isInitialized) {
      debugPrint(
          'setUserID: OpenReplay not initialized. Call initialize() first.');
      return false;
    }

    try {
      return await _channel.invokeMethod('setUserID', {
        'userID': userID,
      });
    } catch (e) {
      debugPrint('Error setting OpenReplay user ID: $e');
      return false;
    }
  }

  /// Track a custom event with the provided name and payload.
  static Future<bool> trackEvent(
      String name, Map<String, dynamic> payload) async {
    if (!_isInitialized) {
      debugPrint(
          'trackEvent: OpenReplay not initialized. Call initialize() first.');
      return false;
    }

    try {
      final track = await _channel.invokeMethod('trackEvent', {
        'name': name,
        'payload': payload,
      });
      debugPrint('Tracking event: $name, payload: $payload');
      return track;
    } catch (e) {
      debugPrint('Error tracking OpenReplay event: $e');
      return false;
    }
  }

  /// Add custom metadata to the current session.
  static Future<bool> addMetadata(String key, String value) async {
    if (!_isInitialized) {
      debugPrint(
          'addMetadata: OpenReplay not initialized. Call initialize() first.');
      return false;
    }

    try {
      return await _channel.invokeMethod('addMetadata', {
        'key': key,
        'value': value,
      });
    } catch (e) {
      debugPrint('Error adding OpenReplay metadata: $e');
      return false;
    }
  }

  /// Log an issue with an optional metadata map.
  static Future<bool> logIssue(String issue,
      {Map<String, dynamic>? metadata}) async {
    if (!_isInitialized) {
      debugPrint(
          'logIssue: OpenReplay not initialized. Call initialize() first.');
      return false;
    }

    try {
      return await _channel.invokeMethod('logIssue', {
        'issue': issue,
        'metadata': metadata ?? {},
      });
    } catch (e) {
      debugPrint('Error logging OpenReplay issue: $e');
      return false;
    }
  }
}
