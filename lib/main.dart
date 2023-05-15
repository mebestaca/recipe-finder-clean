import 'package:flutter/material.dart';
import 'package:recipe_finder_clean/feature/presentation/pages/recipe_list_main_page.dart';
import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Recipe Finder",
      theme: ThemeData.light(),
      home: const RecipeListMainPage(),
    );
  }
}

