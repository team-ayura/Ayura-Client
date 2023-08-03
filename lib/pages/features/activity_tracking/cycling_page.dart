import 'package:ayura/constants/colors.dart';
import 'package:ayura/pages/features/activity_tracking/activity.dart';
import 'package:ayura/pages/features/activity_tracking/cycling_on_ride.dart';
import 'package:ayura/provider/activityProviders/cyclingOnRideProvider.dart';
import 'package:ayura/provider/activityProviders/cyclingProvider.dart';
import 'package:ayura/utils/router.dart';
// import 'package:ayura/provider/activityProviders/walkAndRunningProvider.dart';
import 'package:ayura/widgets/features/activity_tracking/activity_stat_box.dart';
import 'package:ayura/widgets/features/activity_tracking/chart.dart';
import 'package:ayura/widgets/features/activity_tracking/cycle_ride_box.dart';
import 'package:ayura/widgets/features/activity_tracking/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CyclingPage extends StatefulWidget {
  const CyclingPage({Key? key}) : super(key: key);

  @override
  State<CyclingPage> createState() => _CyclingPageState();
}

class _CyclingPageState extends State<CyclingPage> {
  int activeIndex = 0; // -1 means no active index

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat('#,###');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cycling'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // the time navigation
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    Colors.grey.shade200, // Set your desired button color here
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildCustomButton('D', 0),
                  _buildCustomButton('W', 1),
                  _buildCustomButton('M', 2),
                  _buildCustomButton('Y', 3),
                ],
              ),
            ),
            // the chart
            Container(
              height: 200,
              padding: const EdgeInsets.all(10),
              child: Consumer<CyclingProvider>(
                  builder: (context, cyclingProvider, _) {
                return BarChartWeekly(
                    yAxisLabel: 'Steps',
                    filter: cyclingProvider.selectedFilter,
                    data: cyclingProvider.steps);
              }),
            ),
            // distance
            Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor
                      .withOpacity(0.3), // Set your desired button color here
                  borderRadius: BorderRadius.circular(8.0),
                  // border: Border.all(
                  //   color: AppColors.primaryColor,
                  //   width: 2,
                  // ),
                ),
                child: Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 200,
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                          left: 10,
                          right: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors
                              .white, // Set your desired button color here
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              // bottomRight: Radius.circular(35),
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Distance',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Consumer<CyclingProvider>(builder:
                                    (context, walkingAndRunningProvider, _) {
                                  final String stepCount =
                                      walkingAndRunningProvider.distance
                                          .toString();
                                  return Text(
                                    stepCount,
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'Km',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(),
                    ],
                  ),
                )),

            // row of duration calories & improvement
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                color: Colors.white
                    .withOpacity(0.3), // Set your desired button color here
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Consumer<CyclingProvider>(
                        builder: (context, cyclingProvider, _) {
                      final String duration = cyclingProvider.duration;
                      return ActivityStatBox(
                        svgName: 'clock.svg',
                        value: duration,
                        label: 'Duration',
                      );
                    }),
                    const SizedBox(
                      width: 10,
                    ),
                    Consumer<CyclingProvider>(
                        builder: (context, cyclingProvider, _) {
                      final String calorieCount = numberFormat
                          .format(cyclingProvider.calorieCount)
                          .toString();
                      return ActivityStatBox(
                        svgName: 'heart.svg',
                        value: calorieCount,
                        label: 'Calories',
                      );
                    }),
                    const SizedBox(
                      width: 10,
                    ),
                    Consumer<CyclingProvider>(
                        builder: (context, cyclingProvider, _) {
                      final String improvement =
                          cyclingProvider.improvement.toString();
                      return ActivityStatBox(
                        svgName: 'chart.svg',
                        value: improvement,
                        label: 'Improvement',
                        isPercentageValue: true,
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // start cycling button
            Consumer<CyclingOnRideProvider>(
                builder: (context, cyclingOnRideProvider, _) {
              return GestureDetector(
                onTap: () {
                  cyclingOnRideProvider.startTimer();
                  PageNavigator(context: context).nextPage(CyclingOnRidePage());
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Start Cycling',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }),
            // about section
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ride History',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      CyclingTripWidget(
                        date: 'June 10',
                        startTime: '6:00 AM',
                        distance: '5.6 Km',
                        duration: '1:30:00',
                        rideName: 'Cycling at Bellanwila park',
                      ),
                      CyclingTripWidget(
                        date: 'June 07',
                        startTime: '6:13 AM',
                        distance: '4.2 Km',
                        duration: '00:59:00',
                        rideName: 'Cycling at Galle Face',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // previouse trips

            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Cycling',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors
                          .grey.shade200, // Set your desired button color here
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Cycle your way to better health and fitness. Ayura encourages and tracks your cycling rides, helping you stay active and enjoy the journey towards a healthier lifestyle.',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textColor.withOpacity(0.4)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Consumer<CyclingProvider> _buildCustomButton(String buttonText, int index) {
    return Consumer<CyclingProvider>(
        builder: (context, walkingAndRunningProvider, _) {
      bool isActive = walkingAndRunningProvider.selectedFilter == buttonText;
      return Expanded(
        child: GestureDetector(
          onTap: () => walkingAndRunningProvider.updateFilter(buttonText),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryColor : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isActive ? 1.0 : 0.7,
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: isActive ? Colors.white : AppColors.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}