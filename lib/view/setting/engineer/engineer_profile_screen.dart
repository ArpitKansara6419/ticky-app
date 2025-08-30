import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/view/engineer/documents/document_screen.dart';
import 'package:ticky/view/engineer/education/education_screen.dart';
import 'package:ticky/view/engineer/industry_exp/industry_experience_screen.dart';
import 'package:ticky/view/engineer/payments/payment_details_screen.dart';
import 'package:ticky/view/engineer/personal_details/personal_details_screen.dart';
import 'package:ticky/view/engineer/right_to_work/right_to_work_screen.dart';
import 'package:ticky/view/engineer/spoken_languages/spoken_language_screen.dart';
import 'package:ticky/view/engineer/technical_skill/technical_skill_screen.dart';
import 'package:ticky/view/engineer/travel_details/travel_details_screen.dart';

import '../../../utils/imports.dart';

class EngineerProfileScreen extends StatefulWidget {
  const EngineerProfileScreen({Key? key}) : super(key: key);

  @override
  State<EngineerProfileScreen> createState() => _EngineerProfileScreenState();
}

class _EngineerProfileScreenState extends State<EngineerProfileScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    MasterDataController.fetchAllData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('My Profile', style: boldTextStyle(color: Colors.white, size: 20)),
      ),
      body: AnimatedScrollView(
        listAnimationType: ListAnimationType.None,
        children: [
          SettingItemWidget(
            leading: buildLeadingWidget(context, image: AppSvgIcons.icPersonal),
            subTitle: "Name, contact information, address, and birthdate.",
            subTitleTextStyle: secondaryTextStyle(size: 10),
            title: "Personal Details",
            trailing: buildTrailingWidget(context),
            onTap: () {
              PersonalDetailsScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
            },
          ),
          buildDividerWidget(),
          SettingItemWidget(
            leading: buildLeadingWidget(context, image: AppSvgIcons.icEducation),
            title: "Education",
            subTitle: "Degrees, institutions, years, and specializations listed.",
            subTitleMaxLine: 1,
            subTitleTextStyle: secondaryTextStyle(size: 10),
            trailing: buildTrailingWidget(context),
            onTap: () {
              EducationScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
            },
          ),
          buildDividerWidget(),
          SettingItemWidget(
            leading: buildLeadingWidget(context, image: AppSvgIcons.icDocument),
            subTitle: "Copies of IDs, passport, and legal documents.",
            subTitleTextStyle: secondaryTextStyle(size: 10),
            title: "ID Documents",
            trailing: buildTrailingWidget(context),
            onTap: () {
              DocumentScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
            },
          ),
          buildDividerWidget(),
          SettingItemWidget(
            leading: buildLeadingWidget(context, image: AppSvgIcons.icRightToWork),
            subTitle: "Eligibility and documents confirming work authorization.",
            subTitleTextStyle: secondaryTextStyle(size: 10),
            title: "Right To Work",
            trailing: buildTrailingWidget(context),
            onTap: () {
              RightToWorkScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
            },
          ),
          buildDividerWidget(),
          SettingItemWidget(
            leading: buildLeadingWidget(context, image: AppSvgIcons.icTravel),
            subTitle: "Travel history, visas, and related information.",
            subTitleTextStyle: secondaryTextStyle(size: 10),
            title: "Travel Details",
            trailing: buildTrailingWidget(context),
            onTap: () {
              TravelDetailsScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
            },
          ),
          buildDividerWidget(),
          SettingItemWidget(
            leading: buildLeadingWidget(context, image: AppSvgIcons.icPayment),
            subTitle: "Bank Account, IBAN Number",
            subTitleTextStyle: secondaryTextStyle(size: 10),
            title: "Payment Details",
            trailing: buildTrailingWidget(context),
            onTap: () {
              PaymentDetailsScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
            },
          ),
          buildDividerWidget(),
          SettingItemWidget(
            leading: buildLeadingWidget(context, image: AppSvgIcons.icTechnicalSkills),
            subTitle: "Coding languages, tools, and technologies proficient in.",
            subTitleTextStyle: secondaryTextStyle(size: 10),
            title: "Technical Skills",
            trailing: buildTrailingWidget(context),
            onTap: () {
              TechnicalSkillScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
            },
          ),
          buildDividerWidget(),
          /*   SettingItemWidget(
            leading: buildLeadingWidget(context, image: AppSvgIcons.icTechnicalSkills),
            subTitle: "Certifications earned in technology-related fields listed.",
            subTitleTextStyle: secondaryTextStyle(size: 10),
            title: "Technical Certifications",
            trailing: buildTrailingWidget(context),
            onTap: () {
              TechnicalCertificationScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
            },
          ),
          buildDividerWidget(),*/
          SettingItemWidget(
            leading: buildLeadingWidget(context, image: AppSvgIcons.icSpokenLanguages),
            subTitle: "Languages spoken fluently or conversationally listed.",
            subTitleTextStyle: secondaryTextStyle(size: 10),
            title: "Spoken Languages",
            trailing: buildTrailingWidget(context),
            onTap: () {
              SpokenLanguageScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
            },
          ),
          buildDividerWidget(),
          SettingItemWidget(
            leading: buildLeadingWidget(context, image: AppSvgIcons.icIndustryExperience),
            subTitle: "Professional experience across various industries and roles.",
            subTitleTextStyle: secondaryTextStyle(size: 10),
            title: "Industry Experience",
            trailing: buildTrailingWidget(context),
            onTap: () {
              IndustryExperienceScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
            },
          ),
        ],
      ),
    );
  }
}
