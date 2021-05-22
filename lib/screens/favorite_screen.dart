import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/widgets/meal_item.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Meal> favoriteMeal =
        Provider.of<MealProvider>(context, listen: true).favoriteMeal;
    if (favoriteMeal.isEmpty) {
      return Center(
        child: Text('You hava no favorite yet! start adding some!'),
      );
    } else {
      return ListView.builder(
        itemCount: favoriteMeal.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeal[index].id,
            imageUrl: favoriteMeal[index].imageUrl,
            title: favoriteMeal[index].title,
            duration: favoriteMeal[index].duration,
            complexity: favoriteMeal[index].complexity,
            affordability: favoriteMeal[index].affordability,
          );
        },
      );
    }
  }
}
