// import 'package:flutter_test/flutter_test.dart';
// import 'package:openreplay_sdk/openreplay_sdk.dart';
// import 'package:openreplay_sdk/openreplay_sdk_platform_interface.dart';
// import 'package:openreplay_sdk/openreplay_sdk_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockOpenreplaySdkPlatform
//     with MockPlatformInterfaceMixin
//     implements OpenreplaySdkPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final OpenreplaySdkPlatform initialPlatform = OpenreplaySdkPlatform.instance;

//   test('$MethodChannelOpenreplaySdk is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelOpenreplaySdk>());
//   });

//   test('getPlatformVersion', () async {
//     OpenreplaySdk openreplaySdkPlugin = OpenreplaySdk();
//     MockOpenreplaySdkPlatform fakePlatform = MockOpenreplaySdkPlatform();
//     OpenreplaySdkPlatform.instance = fakePlatform;

//     expect(await openreplaySdkPlugin.getPlatformVersion(), '42');
//   });
// }
