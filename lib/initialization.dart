// import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ticky/controller/app/app_store.dart';
import 'package:ticky/controller/app/biometric_auth_store.dart';
import 'package:ticky/controller/attendance/attendance_store.dart';
import 'package:ticky/controller/auth/auth_store.dart';
import 'package:ticky/controller/auth/signup_store.dart';
import 'package:ticky/controller/dashboard/dashboard_store.dart';
import 'package:ticky/controller/engineer/documents/document_store.dart';
import 'package:ticky/controller/engineer/education/education_store.dart';
import 'package:ticky/controller/engineer/industry_exp/industry_experience_store.dart';
import 'package:ticky/controller/engineer/payments/payment_details_store.dart';
import 'package:ticky/controller/engineer/personal_details/personal_details_store.dart';
import 'package:ticky/controller/engineer/right_to_work/right_to_work_store.dart';
import 'package:ticky/controller/engineer/spoken_languages/spoken_language_store.dart';
import 'package:ticky/controller/engineer/technical_certification/technical_certification_store.dart';
import 'package:ticky/controller/engineer/technical_skill/technical_skill_store.dart';
import 'package:ticky/controller/engineer/travel_details/travel_details_store.dart';
import 'package:ticky/controller/leaves/leave_store.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/controller/store/user_store.dart';
import 'package:ticky/controller/tickets/ticket_start_work_store.dart';
import 'package:ticky/controller/tickets/ticket_store.dart';
import 'package:ticky/flavors/flavor_config.dart';
import 'package:ticky/utils/enums.dart';
import 'package:ticky/utils/firebase_notification_service.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/view/splash_screen.dart';
import 'package:ticky/view/tickets/background_location_service.dart' show backgroundLocationService;

import 'controller/store/permission_store.dart';

AppStore appStore = AppStore();
DashboardStore dashboardStore = DashboardStore();
AuthStore authStore = AuthStore();
SignupStore signupStore = SignupStore();
AppLoaderStore appLoaderStore = AppLoaderStore();
UserStore userStore = UserStore();
TicketStore ticketStore = TicketStore();
RightToWorkStore rightToWorkStore = RightToWorkStore();
TicketStartWorkStore ticketStartWorkStore = TicketStartWorkStore();
AttendanceStore attendanceStore = AttendanceStore();
PersonalDetailsStore personalDetailsStore = PersonalDetailsStore();
EducationStore educationStore = EducationStore();
SpokenLanguageStore spokenLanguageStore = SpokenLanguageStore();
TechnicalSkillStore technicalSkillStore = TechnicalSkillStore();
IndustryExperienceStore industryExperienceStore = IndustryExperienceStore();
TravelDetailsStore travelDetailsStore = TravelDetailsStore();
PaymentDetailsStore paymentDetailsStore = PaymentDetailsStore();
LeaveStore leaveStore = LeaveStore();
DocumentStore documentStore = DocumentStore();
TechnicalCertificationStore technicalCertificationStore = TechnicalCertificationStore();
BiometricAuthStore biometricAuthStore = BiometricAuthStore();
PermissionStore permissionStore = PermissionStore();
final FlutterLocalNotificationsPlugin localNotifications = FlutterLocalNotificationsPlugin();

String sentTime = '';
PackageInfo? packageInfo;
Flavors flavors = Flavors.production;
PushNotificationService pushNotificationService = PushNotificationService();
final GlobalKey dashboardGlobalKey = GlobalKey(debugLabel: "Dashboard Global Key");
final GlobalKey ticketListGlobalKey = GlobalKey(debugLabel: "Ticket List Global Key");
final GlobalKey calenderGlobalKey = GlobalKey(debugLabel: "Calender Global Key");
final GlobalKey settingGlobalKey = GlobalKey(debugLabel: "Setting Global Key");

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.flavors});

  final Flavors flavors;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        packageInfo = await PackageInfo.fromPlatform();
        mainLog(message: 'buildNumber => ${packageInfo?.buildNumber} & version => ${packageInfo?.version}');
      },
    );
    init();
  }

  void init() async {
    pushNotificationService.initialise();
    await pushNotificationService.onKillRedirection();
    await backgroundLocationService.initLocationService();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, Config.googleFonts, Config.googleFonts);
    MaterialTheme theme = MaterialTheme(textTheme);
    return Observer(
      builder: (context) {
        return MaterialApp(
          title: APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: theme.light(),
          darkTheme: theme.dark(),
          navigatorKey: navigatorKey,
          themeMode: appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: SplashScreen(),
        );
      },
    );
  }
}
