// Welcome to OCTI a youtube client that kinda works

// BEFORE RUNNING THE APP MAKE SURE
// In Windows display settings you have the scale set to 125%
// You run the app in fullscreen
// And don't have too many thigns open becasuse Flutter isn't too efficient with a debug app but is a lot better with built apps
// If you run into performance issues, it might be worthwhile to build the app just type "flutter build" in the root of the octi directory and it will spit out an executable ;)
// If you run into any problems, contact Shayan or follow a troubleshoot guide

import 'package:flutter/material.dart';  // <-- Importing Flutter Package for Dart
import 'package:go_router/go_router.dart'; // <-- Importing Go_Router for easier page routing
import 'package:octi/home.dart'; // <-- Home Page that I made needs to be imported for page routing
import 'package:octi/search_screen.dart'; // <-- Same as above
import 'package:octi/video_player_screen.dart'; // <-- This was useless and didn't work :(

void main() { // Main Function
  runApp(const MyApp()); // Running the whole app :O
}

final GoRouter _router = GoRouter(routes: <RouteBase>[ // Go_Routing Setup
  GoRoute( // First Route, the HomePage
    path: '/', // What I wan't to call it
    builder: (BuildContext context, GoRouterState state) { // What I want to happen when I call it
      return HomePage(); // What Happens
    },
    routes: <RouteBase>[ // Another Route
      GoRoute(
        path: 'search', // This is the Search Page which you can find at "search_screen.dart (Took me forever)"
        builder: (BuildContext context, GoRouterState state) { 
          return SearchScreen(); // Calling the search screen
        },
      )
    ],
  ),
]);


Map<int, Color> color = { // Creating a custom colour that I never really used
  50: Color.fromRGBO(37, 40, 61, .1),
  100: Color.fromRGBO(37, 40, 61, .2),
  200: Color.fromRGBO(37, 40, 61, .3),
  300: Color.fromRGBO(37, 40, 61, .4),
  400: Color.fromRGBO(37, 40, 61, .5),
  500: Color.fromRGBO(37, 40, 61, .6),             // <-- Making shades for the colour I never really used
  600: Color.fromRGBO(37, 40, 61, .7),
  700: Color.fromRGBO(37, 40, 61, .8),
  800: Color.fromRGBO(37, 40, 61, .9),
  900: Color.fromRGBO(37, 40, 61, 1),
};

class MyApp extends StatelessWidget { // Flutter's stateless widget which only calls the build method once
  const MyApp({super.key}); // Making the app
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) { // Building the app
    MaterialColor colorCustom = MaterialColor(0x25283D, color); // Hey look it's the colour I never really used

    return MaterialApp.router( // MaterialApp.router allows me to use go_router as a third party routing manager
      title: 'OCTI', // Hey look it's the name of the app
      theme: ThemeData( // Theme Data which I also never use
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke     <-- Flutter's default thing
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: colorCustom, // Hey look it's the colour again
      ),
      routerConfig: _router, // Using the go_router profile we made earlier as a router configurator
    );
  }
}
