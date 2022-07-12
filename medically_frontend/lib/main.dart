import 'package:flutter/material.dart';
import 'package:medically_frontend/consts/theme_data.dart';
import 'package:medically_frontend/doctor_screens/doctor_bottom_bar.dart';
import 'package:medically_frontend/providers/calls_provider.dart';
import 'package:medically_frontend/providers/dark_theme_provider.dart';
import 'package:medically_frontend/providers/doctor_provider.dart';
import 'package:medically_frontend/providers/doctors_provider.dart';
import 'package:medically_frontend/providers/reviews_provider.dart';
import 'package:medically_frontend/providers/token_provider.dart';
import 'package:medically_frontend/providers/user_provider.dart';
import 'package:medically_frontend/screens/balance_screen.dart';
import 'package:medically_frontend/screens/bottom_bar.dart';
import 'package:medically_frontend/screens/doctor_details_screen.dart';
import 'package:medically_frontend/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(create: (ctx) => DoctorsProvider()),
        ChangeNotifierProvider(create: (ctx) => CallsProvider()),
        ChangeNotifierProvider(create: (ctx) => ReviewsProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => DoctorProvider()),
        ChangeNotifierProvider(create: (ctx) => TokenProvider()),
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: LoginScreen(),
          routes: {
            LoginScreen.routeName: (ctx) => LoginScreen(),
            BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
            DoctorDetailsScreen.routeName: (ctx) => DoctorDetailsScreen(),
            DoctorBottomBarScreen.routeName: (ctx) => DoctorBottomBarScreen(),
            BalanceScreen.routeName: (ctx) => BalanceScreen(),
          },
        );
      }),
    );
  }
}
