// main.dart
import 'package:flutter/material.dart';
import 'package:openreplay_sdk/openreplay_flutter.dart';

void main() async {
  // Initialize OpenReplay
  WidgetsFlutterBinding.ensureInitialized();
  await OpenReplayService().initialize('rGElsCaJ71nXaml8HsHu');
  // Set up error handling
  FlutterError.onError = (FlutterErrorDetails details) {
    OpenReplayFlutter.logIssue(
      'Unhandled Flutter Error',
      metadata: {
        'error': details.exception.toString(),
        'stack': details.stack?.toString() ?? 'No stack trace',
      },
    );

    FlutterError.presentError(details);
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenReplayWrapper(
      child: MaterialApp(
        title: 'OpenReplay Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        navigatorObservers: [
          OpenReplayNavigatorObserver(),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    // Access the tracking service to log the event
    final tracking = TrackingProvider.of(context);
    tracking.trackButtonPress('increment_button', {
      'counter_value': _counter,
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Track screen view when the page loads
    final tracking = TrackingProvider.of(context);
    tracking.trackScreenView('home_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenReplay Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Use tracking directly for this button press

                context.trackButtonPress('report_issue_button');

                // Show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Issue reported to OpenReplay')),
                );
              },
              child: const Text('Report Issue'),
            ),

            // Example of tracking a more complex user action
            TextButton(
              onPressed: () {
                context.trackUserAction('settings_access', {
                  'from_screen': 'home',
                  'user_level': 'standard',
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get access to tracking service
    final tracking = TrackingProvider.of(context);

    // Track this screen view
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tracking.trackScreenView('settings_page');
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              tracking.trackButtonPress('profile_settings', {
                'section': 'profile',
              });
            },
          ),
          ListTile(
            title: const Text('Notifications'),
            onTap: () {
              tracking.trackButtonPress('notification_settings', {
                'section': 'notifications',
              });
            },
          ),
          ListTile(
            title: const Text('Privacy'),
            onTap: () {
              tracking.trackButtonPress('privacy_settings', {
                'section': 'privacy',
              });
            },
          ),
        ],
      ),
    );
  }
}
