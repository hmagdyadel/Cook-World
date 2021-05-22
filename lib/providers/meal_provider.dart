import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dummy_data.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'Lactose': false,
    'Vegan': false,
    'Vegetarian': false,
  };
  List<Meal> availableMeal = DUMMY_MEALS;
  List<Meal> favoriteMeal = [];
  List<String> prefsMealId = [];

  void setFilters() async {
    availableMeal = DUMMY_MEALS.where((meal) {
      if (filters['gluten'] && !meal.isGlutenFree) {
        return false;
      }
      if (filters['Lactose'] && !meal.isLactoseFree) {
        return false;
      }
      if (filters['Vegan'] && !meal.isVegan) {
        return false;
      }
      if (filters['Vegetarian'] && !meal.isVegetarian) {}
      return true;
    }).toList();
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten', filters['gluten']);
    prefs.setBool('Lactose', filters['Lactose']);
    prefs.setBool('Vegan', filters['Vegan']);
    prefs.setBool('Vegetarian', filters['Vegetarian']);
  }

  void setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['Lactose'] = prefs.getBool('Lactose') ?? false;
    filters['Vegan'] = prefs.getBool('Vegan') ?? false;
    filters['Vegetarian'] = prefs.getBool('Vegetarian') ?? false;
     prefsMealId = prefs.getStringList('prefsMealId');
    for (var mealId in prefsMealId) {
      isMealFavorite = favoriteMeal.any((meal) => meal.id == mealId);
    }

    notifyListeners();
  }

  bool isMealFavorite = false;

  void toggleFavorite(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingIndex = favoriteMeal.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      favoriteMeal.removeAt(existingIndex);
    } else {
      favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }
    isMealFavorite = favoriteMeal.any((meal) => meal.id == mealId);
    notifyListeners();
    prefs.setStringList('prefsMealId', prefsMealId);
  }
}
