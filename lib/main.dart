import 'package:ayura/auth/auth_screen.dart';
import 'package:ayura/auth/login.dart';
import 'package:ayura/auth/onboarding_screen.dart';
import 'package:ayura/constants/enums.dart';
import 'package:ayura/pages/features/Diary/diary_list.dart';
import 'package:ayura/pages/splash_screen.dart';
// import 'package:ayura/auth/signup.dart';
import 'package:ayura/pages/home.dart';
import 'package:ayura/provider/activityProviders/cyclingOnRideProvider.dart';
import 'package:ayura/provider/activityProviders/cyclingProvider.dart';
import 'package:ayura/provider/activityProviders/googleAuthProvider.dart';
import 'package:ayura/provider/activityProviders/sportsProvider.dart';
import 'package:ayura/provider/activityProviders/stairsProvider.dart';
import 'package:ayura/provider/activityProviders/walkAndRunningProvider.dart';
import 'package:ayura/provider/activityProviders/workoutsProvider.dart';
// import 'package:ayura/provider/autProvider/auth_provider.dart';
import 'package:ayura/provider/autProvider/authentication_provider.dart';
import 'package:ayura/provider/functions/init.dart';
import 'package:ayura/provider/moodProviders/selectedmood.dart';
import 'package:ayura/provider/navigationProvider/navigation_provider.dart';
import 'package:ayura/provider/symptomProviders/symptomlist.dart';
import 'package:ayura/provider/communityProviders/community_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
bool? isLoggedIn;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt("isViewed");
  print(prefs.getString(BasicUserData.token.label));
  isLoggedIn = prefs.getString(BasicUserData.token.label) != null && prefs.getString(BasicUserData.token.label) != "";
  await prefs.setInt("isViewed", 1);
  runApp(MyApp());
}

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future _initFuture = Init.initialize();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider2()),
        ChangeNotifierProvider(create: (_) => AppNavigationProvider()),
        ChangeNotifierProvider(create: (_) => WalkingAndRunningProvider()),
        ChangeNotifierProvider(create: (_) => StairsProvider()),
        ChangeNotifierProvider(create: (_) => CyclingProvider()),
        ChangeNotifierProvider(create: (_) => CyclingOnRideProvider()),
        ChangeNotifierProvider(create: (_) => MoodProvider()),
        ChangeNotifierProvider(create: (_) => SportsProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutsProvider()),
        ChangeNotifierProvider(create: (_) => SymptomsProvider()),
        ChangeNotifierProvider(create: (_) => CommunityProvider()),
        ChangeNotifierProvider(create: (_) => GoogleAuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ayura',
        home: FutureBuilder(
          future: _initFuture,
          builder: (context, snapshot) {
            if(isLoggedIn != null && isLoggedIn == true){
              return const Home();
            }else if (snapshot.connectionState == ConnectionState.done) {
              return isViewed != 0 ? const OnboardingScreen() : const Login();
            } else {
              return const SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
