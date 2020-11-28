import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_technical_test/features/sub_reddit/presentation/pages/reddit_post_page.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'subreddit',
      routes: {
        'subreddit': (context) => SubRedditPage(),
      },
    );
  }
}
