import 'package:flutter/material.dart';
import 'package:ayura/widgets/global/custom_button.dart';
import 'package:ayura/widgets/global/custom_grey_btn.dart';
import 'package:ayura/utils/router.dart';

// Constants
import 'package:ayura/constants/colors.dart';
import 'package:ayura/constants/styles.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard(
      {required this.challengeName,
      required this.challengeType,
      required this.communityName,
      required this.remainingTime,
      required this.completedCount,
      required this.totalCount,
      super.key});

  //Challenge Name, Challenge Type, Community Name
  final String challengeName;
  final String challengeType;
  final String communityName;
  final String remainingTime;
  final String completedCount;
  final String totalCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.group_outlined,
                color: Color.fromRGBO(11, 183, 80, 1),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                communityName,
                style: const TextStyle(
                  color: Color.fromRGBO(11, 183, 80, 1),
                  fontFamily: 'Inter',
                ),
              ),
              const Expanded(child: SizedBox()),
              Text(
                remainingTime,
                style: const TextStyle(
                    color: AppColors.textColor, fontFamily: 'Inter'),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    challengeName,
                    style: const TextStyle(
                      color: AppColors.textColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    challengeType,
                    style: const TextStyle(
                        color: AppColors.textColor, fontFamily: 'Inter'),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Text(
                '$completedCount/',
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              Text(
                totalCount,
                style: const TextStyle(
                  color: AppColors.alternateGreyColor,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(
                8.0), // Adjust the radius to control the curve ending

            child: const LinearProgressIndicator(
              value: 0.5,
              backgroundColor: AppColors
                  .alternateGreyColor, // Background color of the progress bar
              valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryColor), // Color of the progress indicator
              minHeight: 10, // Minimum height of the progress bar
            ),
          ),
        ],
      ),
    );
  }
}