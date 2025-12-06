import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/recipe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RecipeScreen(),
    );
  }
}

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    final jsonString = await rootBundle.loadString('assets/recipes.json');
    final jsonData = jsonDecode(jsonString);

    setState(() {
      recipes = (jsonData['recipes'] as List)
          .map((item) => Recipe.fromJson(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Food Recipes"),
      backgroundColor: Colors.blueAccent,),
      body: recipes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.restaurant_menu),
            title: Text(
              recipes[index].title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(recipes[index].description),
          );
        },
      ),
    );
  }
}
