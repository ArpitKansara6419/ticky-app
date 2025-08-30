import 'package:ticky/flavors/flavor_config.dart';
import 'package:ticky/initialization.dart';

class Config {
  static String url = flavors == Flavors.development
      ? "https://ticky-dev.firmeza.co.in"
      : flavors == Flavors.staging
          ? "https://ticky-dev.firmeza.co.in"
          : flavors == Flavors.production
              ? "https://ticky-uat.firmeza.co.in"
              : "";
  static String baseUrl = "$url/api/";
  static String imageUrl = "$url/storage/";
  static String tokenStream = 'tokenStream';
  static String googleMapKey = "AIzaSyDDVz2pXtvfL3kvQ6m5kNjDYRzuoIwSZTI";
  static String googleFonts = "DM Sans";
  static int allowedWorkRange = 3000;
}

//
class MenuName {
  static const dashboard = "Dashboard";
  static const tickets = "Tickets";
  static const calendar = "Calendar";
  static const settings = "Settings";
  static const permissions = "Permissions";
}

class ShowDateFormat {
  static const ddMmmYyyy = "dd MMM, yyyy";
  static const ddMmmYyyyEeee = "EEEE, dd MMM, yyyy";
  static const ddMmmYyyyEe = "EE, dd MMM, yyyy";
  static const apiCallingDate = "yyyy-MM-dd";

  /// Example: 04/18/2025
  static const mmDdYyyySlash = "MM/dd/yyyy";

  /// Example: 18/04/2025
  static const ddMmYyyySlash = "dd/MM/yyyy";

  /// Example: 2025.04.18
  static const yyyyMmDdDot = "yyyy.MM.dd";

  /// Example: 2025-04-18
  static const yyyyMmDdDash = "yyyy-MM-dd";

  /// Example: 18.04.2025
  static const ddMmYyyyDot = "dd.MM.yyyy";

  // --- Time Formats ---
  /// Example: 14:30 (24-hour)
  static const hhMm = "HH:mm";

  /// Example: 14:30:45 (24-hour)
  static const hhMmSs = "HH:mm:ss";

  /// Example: 02:30 PM (12-hour with AM/PM)
  static const hhMm12 = "hh:mm a";

  /// Example: 02:30:45 PM (12-hour with AM/PM)
  static const hhMmSs12 = "hh:mm:ss a";

  /// Example: 14:30:45 (Common for API time parts)
  static const apiCallingTime = "HH:mm:ss";

  // --- Combined Date and Time Formats ---
  /// Example: 2025-04-18T14:30:45Z (ISO 8601 UTC)
  static const dateTimeIso = "yyyy-MM-ddTHH:mm:ssZ";

  /// Example: 2025-04-18T14:30:45 (ISO 8601 Local or without explicit offset)
  static const dateTimeIsoLocal = "yyyy-MM-ddTHH:mm:ss";

  /// Example: 18 Apr, 2025 02:30 PM (Human-readable)
  static const dateTimeReadable = "dd MMM, yyyy hh:mm a";

  /// Example: 2025-04-18 14:30:45 (Common for API full datetime)
  static const dateTimeApi = "yyyy-MM-dd HH:mm:ss";

  /// Example: 04/18/2025 14:30:45
  static const mmDdYyyySlashHhMmSs = "MM/dd/yyyy HH:mm:ss";

  /// Example: 18/04/2025 14:30:45
  static const ddMmYyyySlashHhMmSs = "dd/MM/yyyy HH:mm:ss";

  /// Example: 2025.04.18 14:30:45
  static const yyyyMmDdDotHhMmSs = "yyyy.MM.dd HH:mm:ss";

  /// Example: 18.04.2025 14:30:45
  static const ddMmYyyyDotHhMmSs = "dd.MM.yyyy HH:mm:ss";
}

class NotificationEndPoints {
  static const notificationApiUrl = "engineer-notifications";
  static const taskReminderUpdateUrl = "task-reminder/update/";
}

class AuthApiEndpoints {
  static const loginApiUrl = "login";
  static const logoutApiUrl = "logout";
  static const signUpUrl = "register";
  static const forgotPasswordUrl = "forgot-password";
  static const resetPasswordUrl = "reset-password";
  static const changePasswordUrl = "change-password";
  static const getUserUrl = "get-profile";
  static const updateUserUrl = "update-profile";

  static const updateProfileUrl = "update-profile-image-verification";
  static const verifyOtp = "verify-otp";
  static const deleteAccount = "engineer/delete-account";
  static const sendEmailOtp = "resend-otp";

  static const getProfileStatus = "engineer/profile-status";
  static const timezone = "timezones";
  static const updateDeviceToken = "update-device-token";
}

class EducationEndPoints {
  static const educationListUrl = "engineer/educations/";
  static const saveEducationUrl = "engineer/education";
  static const deleteEducationURl = "engineer/education/delete/";
}

class SpokenLanguageEndPoints {
  static const spokenLanguageListUrl = "engineer/language/list";
  static const saveSpokenLanguageUrl = "engineer/language";
  static const deleteSpokenLanguageURl = "engineer/language/delete";
}

class TechnicalSkillEndPoints {
  static const technicalSkillListUrl = "engineer/skills/list";
  static const saveTechnicalSkillUrl = "engineer/skills";
  static const deleteTechnicalSkillURl = "engineer/skills/delete";
}

class TechnicalCertificationEndPoints {
  static const technicalCertificationListUrl = "engineer/certifications";
  static const saveTechnicalCertificationUrl = "engineer/certification";
  static const deleteTechnicalCertificationURl = "engineer/certification/delete";
}

class IndustryExperienceEndPoints {
  static const industryExperienceListUrl = "engineer/industry-experience/list";
  static const saveIndustryExperienceUrl = "engineer/industry-experience";
  static const deleteIndustryExperienceURl = "engineer/industry-experience/delete";
}

class TravelDetailsEndPoints {
  static const travelDetailsListUrl = "engineer/travel-detail";
  static const saveTravelDetailsUrl = "engineer/travel-detail";
  static const deleteTravelDetailsURl = "engineer/travel-detail/delete";
}

class MasterDataEndPoints {
  static const vehicleType = "get-options/vehicle_type";
  static const technicalCertificationSkills = "get-options/technical_certification";
  static const technicalSkills = "get-options/technical_skills";
  static const technicalSkillsLevel = "get-options/technical_skills_level";
  static const spokenLanguages = "get-options/spoken_languages";
  static const spokenLanguageLevel = "get-options/spoken_language_level";
  static const spokenLanguageProficiency = "get-options/spoken_language_proficiency";
  static const industryType = "get-options/industry_experience";
  static const industryTypeLevel = "get-options/industry_experience_level";
  static const gender = "get-options/gender";
  static const rightToWork = "get-options/right_to_work";
}

class PaymentDetailEndPoints {
  static const getPaymentDetailsUrl = "engineer/payment-detail";
  static const savePaymentDetailsUrl = "engineer/payment-detail";
}

class AttendanceEndPoints {
  static const getAttendanceUrl = "engineer/attendance";
}

class LeavesEndPoints {
  static const getLeavesListUrl = "engineer/leaves";
  static const saveLeavesUrl = "engineer/leave/save";
}

class HolidayEndPoints {
  static const getHolidayListUrl = "engineer/holidays";
}

class DashboardEndPoints {
  static const getDashboardUrl = "dashboard";
}

class DocumentEndPoints {
  static const documentListUrl = "engineer/documents";
  static const saveDocumentUrl = "engineer/document";
  static const deleteDocumentURl = "engineer/document/delete";
}

class RightToWorkEndPoints {
  static const rightToWorkListUrl = "engineer/right-to-work";
  static const saveRightToWorkUrl = "engineer/right-to-work";
  static const deleteRightToWorkURl = "engineer/right-to-work/reset";
}

class TicketsEndPoints {
  static const ticketsListUrl = "engineer-ticket/list";
  static const calendarTicketsListUrl = "engineer/calendar";
  static const updateTicketStatusApi = "engineer-ticket/status-update";
  static const ticketDetailStatusApi = "engineer-ticket/detail";
  static const ticketWorkStatus = "work-status";
  static const startWork = "engineer-ticket/start-work";
  static const endWork = "engineer-ticket/end-work";
  static const addTicketBreak = "engineer/ticket-break/start";
  static const endTicketBreak = "engineer/ticket-break/end";
  static const addNote = "engineer/work-note";
  static const deleteNote = "engineer/work-note-remove/";
  static const foodExpense = "engineer/daily-work-expense";
  static const deleteFoodExpense = "engineer/daily-work-expense/";
}

String getCalculatedDistance(int distance) {
  if (distance < 1000) {
    return "${distance.round()} meters";
  } else {
    return "${(distance / 1000).toStringAsFixed(2)} KM";
  }
}
