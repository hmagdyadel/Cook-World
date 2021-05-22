import 'package:flutter/material.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/screens/categories_meal_screen.dart';
import 'package:meal/screens/filter_screen.dart';
import 'package:meal/screens/meal_detail_screen.dart';
import 'package:meal/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(ChangeNotifierProvider(
    create: (ctx) => MealProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 224, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold))),
      routes: {
        '/': (context) => TabsScreen(),
        CategoryMealScreen.routeName: (context) =>
            CategoryMealScreen(),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(),
        FilterScreen.routeName: (context) => FilterScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meal App'),
        ),
        body: null);
  }
}
