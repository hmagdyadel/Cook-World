import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = 'category_Meals';

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayMeals;

  //
  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displayMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals =
        Provider.of<MealProvider>(context, listen: true).availableMeal;
    final routeArg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title'];
    displayMeals = availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> availableMeals =
        Provider.of<MealProvider>(context, listen: true).availableMeal;
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemCount: displayMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeals[index].id,
            imageUrl: displayMeals[index].imageUrl,
            title: displayMeals[index].title,
            duration: displayMeals[index].duration,
            complexity: displayMeals[index].complexity,
            affordability: displayMeals[index].affordability,
          );
        },
      ),
    );
  }
}
