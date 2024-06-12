import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/intro.dart';
import 'package:fview/screens/Infopage.dart';
import 'package:media_kit/media_kit.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform; // Import to check platform

var queryclient = QueryClient();
late Box box;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();

  if (Platform.isAndroid || Platform.isIOS) {
    // Request storage permissions for Android and iOS
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      // Handle the case when permission is not granted
      return;
    }
  }

  // Get the application documents directory
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path); // Initialize Hive with the correct path

  // Open the Hive box asynchronously
  box = await Hive.openBox("test box");
  var Favbox = await Hive.openBox("favorites");
  box.put("name", "asake");
  printer();
  runApp(QueryClientProvider(queryClient: queryclient, child: const App()));
  // await Hive.close();

}

var dez = json.encode([
  {"lol": 'sda'}
]);
void printer() {
  print(dez);
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
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
