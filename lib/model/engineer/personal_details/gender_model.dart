import 'package:ticky/utils/enums.dart';

class AppModel {
  String? title;
  int? index;
  String? value;
  String? agLoadImage;

  AppModel({this.title, this.agLoadImage, this.index, this.value});
}

List<AppModel> getGenderList() {
  List<AppModel> list = [];

  list.add(AppModel(title: "Male", value: "male", index: genderType.MALE.index));
  list.add(AppModel(title: "Female", value: "female", index: genderType.FEMALE.index));

  return list;
}

List<AppModel> getJobList() {
  List<AppModel> list = [];

  list.add(AppModel(title: "Part Time", value: "part_time", index: jobType.PART_TIME.index));
  list.add(AppModel(title: "Full Time", value: "full_time", index: jobType.FULL_TIME.index));

  return list;
}

List<AppModel> getYesNoList() {
  List<AppModel> list = [];

  list.add(AppModel(title: "Yes", value: "1", index: answerType.YES.index));
  list.add(AppModel(title: "No", value: "0", index: answerType.NO.index));

  return list;
}

List<AppModel> getAccountType() {
  List<AppModel> list = [];

  list.add(AppModel(title: "Personal", value: "personal", index: accountType.PERSONAL.index));
  list.add(AppModel(title: "Business", value: "business", index: accountType.BUSINESS.index));

  return list;
}
