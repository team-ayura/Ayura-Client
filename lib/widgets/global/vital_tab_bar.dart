import 'package:ayura/constants/colors.dart';
import 'package:ayura/pages/features/mood_tracking/page1.dart';
import 'package:ayura/pages/features/symptom_tracking/welcome.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';


class VitalsTabBarView extends StatelessWidget {
  const VitalsTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //tabbar part
      length: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
        child: Column(
          children: [
            ButtonsTabBar(
              contentPadding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
              backgroundColor: AppColors.primaryColor,
              borderColor: Colors.transparent,
              unselectedBorderColor: AppColors.disabledColor,
              borderWidth: 1,
              unselectedBackgroundColor: Colors.white,
              unselectedLabelStyle:
                  const TextStyle(color: AppColors.disabledColor),
              labelStyle: const TextStyle(
                color: Colors.white,
                fontFamily: "Inter",
                fontSize: 15,
              ),
              tabs: const [
                Tab(
                  text: "Symptom Tracker",
                ),
                Tab(
                  text: "Mood Tracker",
                ),
              ],
            ),

            //tab contents
            const Expanded(
              child: TabBarView(
                children: <Widget>[
                  //symptom tab
                  WelcomePage(),
                  //mood tab
                  SelectMood()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
