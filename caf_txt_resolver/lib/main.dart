import 'package:caf_txt_resolver/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAF TXT Resolver',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        //scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.greenAccent,
          tertiary: Color.fromRGBO(225, 225, 225, 1),
          primaryContainer: Color.fromRGBO(215, 239, 254, 1),
          background: Colors.white,
        ),
        textTheme: const TextTheme(
          labelSmall: TextStyle(color: Colors.black, fontSize: 12),
          bodySmall: TextStyle(color: Colors.black, fontSize: 12),
        ),
        //backgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarContrastEnforced: false,
            statusBarColor: Colors.white,//Colors.transparent.withOpacity(0.0),
            systemNavigationBarColor: Colors.white,//.withOpacity(0.0),
            statusBarIconBrightness: Brightness.dark,
          ),
          color: Colors.white,//.withOpacity(0.9),
          //backgroundColor: Colors.transparent.withOpacity(0.0),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
          toolbarTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
        ),
      ),
      //------------------------------------------------------------------------------------------------------------------------ dark
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent.shade400,
        colorScheme: const ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.black,
          tertiary: Colors.white12,
          primaryContainer: Color.fromRGBO(23, 23, 23, 1),
          background: Colors.black,
        ),
        textTheme: const TextTheme(
          labelSmall: TextStyle(color: Colors.white, fontSize: 12),
          bodySmall: TextStyle(color: Colors.black, fontSize: 12),
          //displaySmall: TextStyle(color: Colors.pink, fontSize: 12),
          //bodyLarge: TextStyle(color: Colors.pink, fontSize: 12),


        ),
        //backgroundColor: Colors.black,
        dialogBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent.withOpacity(0.1),
            systemNavigationBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light,
          ),
          backgroundColor: Colors.black.withOpacity(0.2),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          toolbarTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          //selectedIconTheme: const IconThemeData(color: Colors.red),
          backgroundColor: Colors.black,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const HomeScreen();
  }
}
