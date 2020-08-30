import 'package:flutter/material.dart';
import 'package:short_note_app/short_note/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final routes = {
    './home':(context)=>MyHomePage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(),
      initialRoute: './home',
      // ignore: missing_return
      onGenerateRoute: (RouteSettings settings){
        final String name = settings.name;
        final Function pageContentBuilder = this.routes[name];

        if(pageContentBuilder!=null){
          if(settings.arguments!=null){
            final Route route = MaterialPageRoute(
                builder: (context)=>pageContentBuilder(context,arguments:settings.arguments)
            );
            return route;
          }
          else{
            final Route route = MaterialPageRoute(
                builder:(context)=>pageContentBuilder(context)
            );
            return route;
          }
        }
      },
    );
  }
}

