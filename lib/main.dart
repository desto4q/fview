import 'package:flutter/material.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/components/videoapp.dart';
import 'package:fview/intro.dart';
import 'package:fview/screens/Infopage.dart';
import 'package:fview/screens/videopage.dart';
import 'package:media_kit/media_kit.dart';

var queryclient = QueryClient();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();
  runApp(QueryClientProvider(queryClient: queryclient, child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    // getBin();
    return MaterialApp(
      routes: {
        '/info': (context) =>
            InfoPage(id: ModalRoute.of(context)!.settings.arguments as String),
      },
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const Intro(),
    );
  }
}
