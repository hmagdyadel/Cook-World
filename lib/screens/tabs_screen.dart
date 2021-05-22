import 'package:flutter/material.dart';

import 'package:meal/providers/meal_provider.dart';
import 'package:meal/screens/categouries_screen.dart';
import 'package:meal/screens/favorite_screen.dart';
import 'package:meal/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  @override
  void initState() {
    Provider.of<MealProvider>(context, listen: false).setData();
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavouriteScreen(), 'title': 'Your Favorites'}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
      drawer: MainDrawer(),
    );
  }

  int _selectedPageIndex = 0;

  void _selectPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }
}
