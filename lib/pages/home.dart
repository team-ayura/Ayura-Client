import 'package:ayura/constants/colors.dart';
import 'package:ayura/pages/features/settings/settings.dart';
import 'package:ayura/pages/features/sleep_tracking/page1.dart';
import 'package:ayura/utils/router.dart';
import 'package:ayura/widgets/features/home/activity_card.dart';
import 'package:ayura/widgets/features/home/tips_card.dart';
import 'package:ayura/widgets/global/bottom_navigation.dart';
import 'package:ayura/widgets/features/community/challenge_card.dart'; // Challenge Card Widget

import 'package:flutter/material.dart';

import 'features/sleep_tracking/page2.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController birthdayController = TextEditingController();
   String getGreeting() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String greeting = getGreeting();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(110.0), // Set the preferred size here.
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 110.0,
          title: Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.07, width * 0.05, height * 0.04),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        greeting,
                        style: const TextStyle(
                            fontFamily: "Inter",
                            color: AppColors.textColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        'Namadee Shakya',
                        style: TextStyle(
                            fontFamily: "Inter",
                            color: AppColors.textColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.notifications_outlined,
                        color: AppColors.textColor,
                        size: 35,
                      ),
                      SizedBox(width: width * 0.02),
                      GestureDetector(
                        onTap: (){
                          PageNavigator(context: context)
                              .nextPage(const SettingsPage());
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/profileIcon.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: height * 0.35,
              child: Column(
                children: [
                  SizedBox(height: height * 0.01),
                  tipsCard(
                    height: height * 0.15,
                    title: 'Health tips',
                    descritpion:
                        'Aim to drink at least 8 glasses (about 2 liters) of water daily!',
                    cta: ' ',
                    icon: Icons.lightbulb,
                  ),
                  SizedBox(height: height * 0.02),
                  Expanded(
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: false,
                        children: [
                          activityCard(
                              text: 'Step Count',
                              number: 2548,
                              image: 'assets/icons/step_icon.png'),
                          SizedBox(width: width * 0.04),
                          activityCard(
                              text: 'Heart Rate',
                              number: 100,
                              image: 'assets/icons/heart.png'),
                          SizedBox(width: width * 0.04),
                          activityCard(
                              text: 'Calories',
                              number: 243,
                              image: 'assets/icons/fire.png'),
                        ]),
                  ),
                  SizedBox(height: height * 0.02)
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: height * 0.02),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(69, 158, 158, 158),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.mode_night_outlined,
                            size: 24.0,
                            color: AppColors.yellowColor,
                          ),
                          const SizedBox(width: 10),
                          const Flexible(
                            child: Text(
                              'How many hours did you sleep? ',
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 16,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              PageNavigator(context: context)
                                  .nextPage(const SleepHistory());
                            },
                            icon: const Icon(
                              Icons.arrow_forward_rounded,
                              size: 20,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        // Challenge Container
                        child: Text(
                          "Establish a consistent Sleep Schedule",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(69, 158, 158, 158),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.bar_chart_rounded,
                            size: 24.0,
                            color: AppColors.yellowColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Featured challenge',
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 16,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.arrow_forward_rounded,
                              size: 20,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        // Challenge Container
                        child: ChallengeCard(
                          //Must Pass other data also, such as challenge data
                          margin: 0,
                          padding: 5,
                          communityName: 'Positivity Pathway',
                          challengeName: 'Morning Walking Routine',
                          challengeType: 'Walking',
                          remainingTime: '5 Days',
                          completedCount: '1.1',
                          totalCount: '4 km',
                          startingDate: '2021-09-01',
                          endingDate: '2021-09-07',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
      bottomNavigationBar: const AppNavigation(),
    );
  }
}
