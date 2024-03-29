import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ayura/provider/models/community_model.dart';

import 'package:ayura/provider/communityProviders/community_provider.dart';
// Constants
import 'package:ayura/constants/colors.dart';
import 'package:ayura/constants/styles.dart';
// Feature Widgets
import 'package:ayura/widgets/features/community/search_box.dart'; // SearchBox Widget
import 'package:ayura/widgets/features/community/chat_card2.dart'; // Chat Card Widget

class CommunityList extends StatefulWidget {
  const CommunityList({super.key});

  @override
  State<CommunityList> createState() => _CommunityListState();
}

class _CommunityListState extends State<CommunityList> {
  @override
  void initState() {
    super.initState();
    Provider.of<CommunityProvider>(context, listen: false)
        .getCommunitiesList(); //Initializing the community list
  }

  void openConfirmationBox(communityId) {
    print("called here");
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SizedBox(
        height: 150,
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Are you sure you want to join?",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<CommunityProvider>(context, listen: false)
                    .joinMember(communityId);
                Navigator.of(ctx).pop();
              },
              child: const Text(
                "Yes",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
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
                  'Explore New Communities',
                  style: AppStyles.subheadingTextStyle2,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            //Search Box
            const SearchBox(),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Consumer<CommunityProvider>(
                builder: (context, communityProvider, _) {
                  List<CommunityModel> communities =
                      communityProvider.communityList; // Getter

                  // Check for loading
                  if (communityProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: communities.length,
                      itemBuilder: (context, index) {
                        CommunityModel community = communities[index];
                        return ChatCardTwo(
                            onTapCallback: () {
                              openConfirmationBox(community.id);
                            },
                            communityId: community.id,
                            communityName: community.communityName,
                            visibiity:
                                community.isPublic ? 'Public' : 'Private',
                            memberCount: community.members.length.toString());
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
