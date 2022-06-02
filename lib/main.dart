import 'package:flutter/material.dart';
import 'package:futawesome/core/contants/app_colors.dart';
import 'package:futawesome/core/routes/root.dart';
import 'package:futawesome/core/routes/routes.dart';
import 'package:futawesome/screens/team_selection/team_selection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fut Awesome',
      theme: ThemeData(
        fontFamily: "Oswald",
        primaryColor: AppColors.primary,
        snackBarTheme: const SnackBarThemeData(
          actionTextColor: AppColors.tertiary,
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
      ),
      initialRoute: "selection",
      routes: {
        "root": (context) => const Root(),
        "selection": (context) => TeamSelection(
              onSelectTeams: () {
                Navigator.of(context).pushNamed("root");
              },
            ),
      },
    );
  }
}
