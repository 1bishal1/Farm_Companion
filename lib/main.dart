import 'package:farm/screens/add_animal.dart';
import 'package:farm/screens/add_animal_2.dart';
import 'package:farm/screens/farm_companion_onboarding.dart';
import 'package:farm/screens/farm_companion_onboarding2.dart';
import 'package:farm/screens/farm_companion_onboarding3.dart';
import 'package:farm/screens/login_page.dart';
import 'package:farm/screens/signup_page.dart';
import 'package:farm/screens/single_small_animal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F7D32)),
        scaffoldBackgroundColor: const Color(0xFFE4E7D6),
        useMaterial3: true,
      ),
      initialRoute: FarmCompanionOnboarding.routeName,
      routes: {
        FarmCompanionOnboarding.routeName: (_) => const FarmCompanionOnboarding(),
        FarmCompanionOnboarding2.routeName: (_) => const FarmCompanionOnboarding2(),
        FarmCompanionOnboarding3.routeName: (_) => const FarmCompanionOnboarding3(),
        AddAnimalPage.routeName: (_) => const AddAnimalPage(),
        AddAnimalPage2.routeName: (_) => const AddAnimalPage2(animalType: '',),
        SingleSmallAnimalPage.routeName: (_) => const SingleSmallAnimalPage(animalType: '',),
        LoginPage.routeName: (_) => const LoginPage(),
        SignupPage.routeName: (_) => const SignupPage(),
      },
    );
  }
}
