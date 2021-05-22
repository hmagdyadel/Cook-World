import 'package:flutter/material.dart';
import 'package:meal/dummy_data.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meal_detail';

  Widget buildSectionTitle(String text, BuildContext ctx) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle('Ingredients', context),
            buildContainer(ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                      color: Theme.of(ctx).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(selectedMeal.ingredients[index]),
                      ),
                    ))),
            buildSectionTitle('Steps', context),
            buildContainer(ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (ctx, index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                          title: Text(selectedMeal.steps[index]),
                        ),
                        Divider()
                      ],
                    )))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toggleFavorite(mealId),
        child: Icon(Provider.of<MealProvider>(context, listen: true)
                .isMealFavorite
            ? Icons.star
            : Icons.star_border),
      ),
    );
  }
}
