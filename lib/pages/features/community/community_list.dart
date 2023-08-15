import 'package:flutter/material.dart';
// Constants
import 'package:ayura/constants/colors.dart';
import 'package:ayura/constants/styles.dart';
// Feature Widgets
import 'package:ayura/widgets/features/community/chat_card.dart'; // Chat Card Widget

class CommunityList extends StatelessWidget {
  const CommunityList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.groups,
                  color: AppColors.textColor,
                ),
                SizedBox(width: 8),
                Text(
                  'Community List',
                  style: AppStyles.subheadingTextStyle2,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView(
                children: const [
                  ChatCard(
                      communityName: 'Colombo Positivity Pathway',
                      visibiity: 'Public',
                      memberCount: '184'),
                  ChatCard(
                      communityName: 'Diabetes Control Circle',
                      visibiity: 'Private',
                      memberCount: '72'),
                  ChatCard(
                      communityName: 'CardioBuddy - Colombo',
                      visibiity: 'Public',
                      memberCount: '310'),
                  ChatCard(
                      communityName: 'Wellness Waves Community',
                      visibiity: 'Public',
                      memberCount: '515'),
                  ChatCard(
                      communityName: 'Joyful Wellness Journey',
                      visibiity: 'Private',
                      memberCount: '40'),
                  ChatCard(
                      communityName: 'DiabetesCare',
                      visibiity: 'Private',
                      memberCount: '10'),
                  // Add more ChatCard widgets as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
