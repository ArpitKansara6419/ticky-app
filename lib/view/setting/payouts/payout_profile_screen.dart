import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/view/setting/payouts/payment_terms_screen.dart';
import 'package:ticky/view/setting/payouts/payout_details_screen.dart';

import '../../../utils/imports.dart';

class PayoutProfileScreen extends StatefulWidget {
  const PayoutProfileScreen({Key? key}) : super(key: key);

  @override
  State<PayoutProfileScreen> createState() => _PayoutProfileScreenState();
}

class _PayoutProfileScreenState extends State<PayoutProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("Payment & Payout Details"),
      body: AnimatedScrollView(
        listAnimationType: ListAnimationType.None,
        children: [
          SettingItemWidget(
            leading: buildLeadingWidget(context, image: AppSvgIcons.icPersonal),
            // subTitle: "Name, contact information, address, and birthdate.",
            subTitleTextStyle: secondaryTextStyle(size: 10),
            title: "Payment Terms",
            trailing: buildTrailingWidget(context),
            onTap: () {
              PaymentTermsScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
            },
          ),
          buildDividerWidget(),
          SettingItemWidget(
            leading: buildLeadingWidget(context, image: AppSvgIcons.icDocument),
            // subTitle: "Copies of IDs, passport, and legal documents.",
            subTitleTextStyle: secondaryTextStyle(size: 10),
            title: "Payouts",
            trailing: buildTrailingWidget(context),
            onTap: () {
              PayoutDetailsScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
            },
          ),
          /*  buildDividerWidget(),
          SettingItemWidget(
            leading: buildLeadingWidget(context, image: AppSvgIcons.icEducation),
            title: "Statements",
            // subTitle: "Degrees, institutions, years, and specializations listed.",
            subTitleMaxLine: 1,
            subTitleTextStyle: secondaryTextStyle(size: 10),
            trailing: buildTrailingWidget(context),
            onTap: () {
              StatementScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null: PageRouteAnimation.Slide);
            },
          ),*/
        ],
      ),
    );
  }
}
