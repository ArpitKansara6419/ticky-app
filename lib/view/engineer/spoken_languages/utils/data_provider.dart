import 'package:ticky/model/engineer/personal_details/gender_model.dart';

List<String> languageList = [
  "Mandarin",
  "Spanish",
  "English",
  "Hindi",
  "Arabic",
  "Bengali",
  "Portuguese",
  "Russian",
  "Japanese",
  "Punjabi",
  "German",
  "Javanese",
  "Korean",
  "French",
  "Turkish",
];

List<AppModel> getExperienceLevel() {
  List<AppModel> list = [];

  list.add(AppModel(title: "Beginner", value: "beginner"));
  list.add(AppModel(title: "Intermediate", value: "intermediate"));
  list.add(AppModel(title: "Good", value: "good"));
  list.add(AppModel(title: "Expert", value: "expert"));
  list.add(AppModel(title: "Native", value: "native"));

  return list;
}
