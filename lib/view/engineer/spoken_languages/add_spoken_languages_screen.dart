import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/model/engineer/personal_details/gender_model.dart';
import 'package:ticky/model/engineer/spoken_languages/spoken_language_data.dart';
import 'package:ticky/utils/colors.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/custom_check_box_widget.dart';
import 'package:ticky/utils/widgets/master_data_dropdown_widget.dart';
import 'package:ticky/utils/widgets/save_button_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';
import 'package:ticky/view/common_widget.dart';
import 'package:ticky/view/engineer/spoken_languages/utils/data_provider.dart';

import '../../../utils/widgets/app_scaffold_with_loader.dart';

class AddSpokenLanguagesScreen extends StatefulWidget {
  final SpokenLanguageData? data;

  const AddSpokenLanguagesScreen({Key? key, this.data}) : super(key: key);

  @override
  State<AddSpokenLanguagesScreen> createState() => _AddSpokenLanguagesScreenState();
}

class _AddSpokenLanguagesScreenState extends State<AddSpokenLanguagesScreen> {
  List<AppModel> getList = getExperienceLevel();
  Future<MasterDataResponse>? spokenLanguageListFuture;
  Future<MasterDataResponse>? spokenLanguageLevelListFuture;
  Future<MasterDataResponse>? spokenLanguageProficiencyListFuture;

  bool isUpdate = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    isUpdate = widget.data != null;

    if (isUpdate) {
      spokenLanguageStore.setSpokenLanguages(MasterData(value: widget.data!.languageName.validate()));
      spokenLanguageStore.setSpokenLanguageLevel(MasterData(value: widget.data!.proficiencyLevel.validate()));

      MasterData? read = widget.data!.read.validate() == 1 ? MasterData(value: "read") : null;
      MasterData? write = widget.data!.write.validate() == 1 ? MasterData(value: "write") : null;
      MasterData? speak = widget.data!.speak.validate() == 1 ? MasterData(value: "speak") : null;

      List<MasterData?> list = [read, write, speak];

      await Future.forEach(list, (e) {
        if (e != null) {
          spokenLanguageStore.setSelectedSpokenLanguageProficiency(e);
        }
      });
    } else {
      spokenLanguageListFuture = MasterDataController.getSpokenLanguagesListApi();
      spokenLanguageLevelListFuture = MasterDataController.getSpokenLanguageLevelListApi();
      spokenLanguageProficiencyListFuture = MasterDataController.getSpokenLanguageProficiencyListApi();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    spokenLanguageStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget((isUpdate ? "Update" : "Add") + " Language"),
      body: Observer(builder: (context) {
        return AppScaffoldWithLoader(
          isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.addSpokenLanguageApiState].validate(),
          child: Form(
            key: spokenLanguageStore.spokenLanguageFormState,
            child: SaveButtonWidget(
              buttonName: isUpdate ? "Update Language" : "Save Language",
              onSubmit: () {
                if (isUpdate) {
                  spokenLanguageStore.onUpdate(id: widget.data!.id.validate());
                } else {
                  spokenLanguageStore.onSubmit();
                }
              },
              children: [
                ScreenTitleWidget(
                  isUpdate ? "Update Your Language Information" : "Add Your Language Information",
                ),
                ScreenSubTitleWidget(
                  isUpdate ? "Modify or add new languages to keep your profile current." : "Provide details about the languages you speak to showcase your communication skills.",
                ),
                16.height,
                TitleFormComponent(
                  text: 'Which language can you speak?',
                  child: MasterDataDropdownWidget(
                    future: spokenLanguageListFuture,
                    initialData: spokenLanguageStore.spokenLanguageInitialData,
                    initialValue: spokenLanguageStore.spokenLanguages,
                    searchName: "Spoken Languages",
                    isSearch: true,
                    onChanged: spokenLanguageStore.setSpokenLanguages,
                  ),
                ),
                16.height,
                TitleFormComponent(
                  text: 'How well do you speak ${spokenLanguageStore.spokenLanguages == null ? "" : spokenLanguageStore.spokenLanguages?.label.validate()}?',
                  child: MasterDataDropdownWidget(
                    future: spokenLanguageLevelListFuture,
                    initialData: spokenLanguageStore.spokenLanguageLevelInitialData,
                    initialValue: spokenLanguageStore.spokenLanguageLevel,
                    onChanged: spokenLanguageStore.setSpokenLanguageLevel,
                  ),
                ),
                16.height,
                FutureBuilder<MasterDataResponse>(
                  initialData: spokenLanguageStore.spokenLanguageProficiencyInitialData,
                  future: spokenLanguageProficiencyListFuture,
                  builder: (context, snap) {
                    return TitleFormComponent(
                      text: 'Most Proficiency in',
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: radius()),
                        child: snap.hasData
                            ? Wrap(
                                children: List.generate(
                                  snap.data!.masterDataList.validate().length,
                                  (index) {
                                    MasterData data = snap.data!.masterDataList.validate()[index];
                                    return InkWell(
                                      onTap: () {
                                        spokenLanguageStore.setSelectedSpokenLanguageProficiency(data);
                                      },
                                      child: Container(
                                        width: context.width() / 3 - 12,
                                        padding: EdgeInsets.all(16),
                                        child: Row(
                                          children: [
                                            Observer(
                                              builder: (context) => CustomCheckBoxWidget(
                                                  isChecked: spokenLanguageStore.selectedSpokenLanguageProficiency.validate().any((MasterData element) => element.value == data.value)),
                                            ),
                                            8.width,
                                            Text(data.label.validate(), style: primaryTextStyle()),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : snapWidgetHelper(snap, loadingWidget: aimLoader(context, size: 24)),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
