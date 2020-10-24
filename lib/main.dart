import 'package:flutter/material.dart';
import 'package:porfolio_movies_app/src/pages/actorPage.dart';


import 'package:porfolio_movies_app/src/pages/homePage.dart';
import 'package:porfolio_movies_app/src/pages/infoMoviePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movies App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (BuildContext context) => HomePage(),
          InfoMovie.id: (BuildContext context ) => InfoMovie(),
          ActorPage.id: (BuildContext context ) => ActorPage(),
        });
  }
}
