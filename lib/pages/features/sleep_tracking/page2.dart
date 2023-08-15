import 'package:ayura/pages/features/sleep_tracking/page3.dart';
import 'package:ayura/utils/router.dart';
import 'package:flutter/material.dart';

import '../../../widgets/features/sleep_tracking/sleeptabbarview.dart';
import '../../../widgets/global/bottom_navigation.dart';
import '../../../widgets/global/custom_app_bar.dart';

class SleepHistory extends StatelessWidget {
  const SleepHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(Icons.arrow_back_outlined,
          Icons.lightbulb, "Sleep History",
          leftCallback: () => Navigator.of(context).pop(),
          // rightCallback: ()=>PageNavigator(context: context).nextPage( )
          ),
      body:SleepTabBarView(),
      bottomNavigationBar: const AppNavigation(),
    );
  }
}