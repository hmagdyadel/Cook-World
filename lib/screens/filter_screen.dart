import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      value: currentValue,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilter =
        Provider.of<MealProvider>(context, listen: true).filters;
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals',
                  currentFilter['gluten'],
                  (newValue) {
                    setState(() {
                      currentFilter['gluten'] = newValue;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                buildSwitchListTile(
                  'Lactose-free',
                  'Only include Lactose-free meals',
                  currentFilter['Lactose'],
                  (newValue) {
                    setState(() {
                      currentFilter['Lactose'] = newValue;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                buildSwitchListTile(
                  'Vegetarian',
                  'Only include Vegetarian meals',
                  currentFilter['Vegetarian'],
                  (newValue) {
                    setState(() {
                      currentFilter['Vegetarian'] = newValue;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                buildSwitchListTile(
                  'Vegan',
                  'Only include Vegan meals',
                  currentFilter['Vegan'],
                  (newValue) {
                    setState(() {
                      currentFilter['Vegan'] = newValue;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
              ],
            ))
          ],
        ));
  }
}
