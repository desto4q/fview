import 'package:flutter/material.dart';
import 'package:fquery/fquery.dart';
import 'package:fview/intro.dart';

var queryclient = QueryClient();

void main() {
  runApp(QueryClientProvider(queryClient:queryclient , child:const  App()));
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    // getBin();
    return  MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme:  ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const Intro(),
    );
  }
}
