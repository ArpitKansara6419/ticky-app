import 'package:ag_widgets/ag_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/common.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/view/calendar/my_calendar_screen.dart';
import 'package:ticky/view/home/home_screen.dart';
import 'package:ticky/view/setting/setting_screen.dart';
import 'package:ticky/view/tickets/tickets_screen.dart';
import 'package:upgrader/upgrader.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await checkGdprConsent();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget bottomIcon({required String? image, required Color? color}) {
    return (image ?? "").agLoadImage(width: 24, height: 24, color: color ?? Colors.black);
  }

  Widget buildNavigationBarWidget() {
    return Observer(
      builder: (context) {
        return Blur(
          blur: 30,
          borderRadius: radius(0),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: context.primaryColor.withOpacity(0.02),
              indicatorColor: context.primaryColor,
              labelTextStyle: WidgetStateProperty.all(secondaryTextStyle(size: 10, color: context.primaryColor)),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: NavigationBar(
              selectedIndex: dashboardStore.bottomNavigationCurrentIndex,
              onDestinationSelected: (value) {
                dashboardStore.setBottomNavigationCurrentIndex(value);
              },
              animationDuration: 1.seconds,
              destinations: [
                NavigationDestination(
                  icon: bottomIcon(image: AppSvgIcons.icDashboard, color: context.primaryColor),
                  selectedIcon: bottomIcon(image: AppSvgIcons.icDashboard, color: Colors.white),
                  label: MenuName.dashboard,
                ),
                NavigationDestination(
                  icon: bottomIcon(image: AppSvgIcons.icTickets, color: context.primaryColor),
                  selectedIcon: bottomIcon(image: AppSvgIcons.icTickets, color: Colors.white),
                  label: MenuName.tickets,
                ),
                NavigationDestination(
                  icon: bottomIcon(image: AppSvgIcons.icCalendar, color: context.primaryColor),
                  selectedIcon: bottomIcon(image: AppSvgIcons.icCalendar, color: Colors.white),
                  label: MenuName.calendar,
                ),
                NavigationDestination(
                  icon: bottomIcon(image: AppSvgIcons.icSettings, color: context.primaryColor),
                  selectedIcon: bottomIcon(image: AppSvgIcons.icSettings, color: Colors.white),
                  label: MenuName.settings,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      child: Scaffold(
        body: UpgradeAlert(
          showIgnore: true,
          showLater: true,
          showReleaseNotes: true,
          child: Observer(
            builder: (context) {
              return [
                HomeScreen(),
                TicketScreen(),
                MyCalendarScreen(),
                SettingScreen(),
              ][dashboardStore.bottomNavigationCurrentIndex];
            },
          ),
        ),
        bottomNavigationBar: buildNavigationBarWidget(),
      ),
    );
  }
}
