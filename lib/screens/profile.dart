import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sports_iiitd/common/CustomAppbar.dart';
import 'package:sports_iiitd/services/auth.dart';

import '../common/colors.dart';

class MyProfile extends StatelessWidget {
  MyProfile({Key? key}) : super(key: key);
  final User? user = getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          customAppBar("Profile", context),

          // Profile Picture
          Container(
            height: 120,
            width: 120,
            margin: EdgeInsets.fromLTRB(0, 40, 0, 20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(user!.photoURL!),
                fit: BoxFit.fill,
              ),
              border: Border.all(
                color: CustomColors.white,
                width: 3,
              ),
            ),
          ),

          // Name
          Text(
            user!.displayName!.toUpperCase(),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: CustomColors.white,
            ),
          ),
          Text(
            '@${user!.email!.split('@')[0]}',
            style: TextStyle(
              fontSize: 16,
              color: CustomColors.white.withOpacity(0.7),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              profileButtons(
                title: 'Events',
                icon: IconlyBold.ticket_star,
                onTap: () {},
                subtitle: 'Your past events',
                context: context,
              ),
              profileButtons(
                title: 'History',
                icon: IconlyBold.time_square,
                onTap: () {
                  Navigator.pushNamed(context, '/history');
                },
                subtitle: 'Your equipment records',
                context: context,
              ),
              profileButtons(
                title: 'Fines',
                icon: IconlyBold.paper,
                onTap: () {
                  Navigator.pushNamed(context, '/fines');
                },
                subtitle: 'Your fines history',
                context: context,
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          TextButton(
            onPressed: () {
              signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/sign_in', (route) => false);
            },
            style: TextButton.styleFrom(
              backgroundColor: CustomColors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: CustomColors.red),
              ),
            ),
            child: Text(
              'Logout',
              style: TextStyle(color: CustomColors.white),
            ),
          )
        ],
      ),
    );
  }
}

InkWell profileButtons(
    {required String title,
    required IconData icon,
    required Function() onTap,
    required String subtitle,
    required BuildContext context}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: MediaQuery.of(context).size.width / 3 - 20,
      height: 140,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.red),
        borderRadius: BorderRadius.circular(12),
        color: CustomColors.red.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: CustomColors.red,
            size: 40,
          ),
          Text(
            title,
            style: TextStyle(
              color: CustomColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: CustomColors.white.withOpacity(0.7),
              fontSize: 10,
            ),
          ),
        ],
      ),
    ),
  );
}
