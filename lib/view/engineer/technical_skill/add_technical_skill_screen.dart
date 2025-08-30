import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/model/engineer/personal_details/gender_model.dart';
import 'package:ticky/model/engineer/technical_skill/technical_skills_data.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/master_data_dropdown_widget.dart';
import 'package:ticky/utils/widgets/save_button_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';
import 'package:ticky/view/common_widget.dart';
import 'package:ticky/view/engineer/spoken_languages/utils/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class AddTechnicalSkillScreen extends StatefulWidget {
  final TechnicalSkillData? data;

  const AddTechnicalSkillScreen({Key? key, this.data}) : super(key: key);

  @override
  State<AddTechnicalSkillScreen> createState() => _AddTechnicalSkillScreenState();
}

class _AddTechnicalSkillScreenState extends State<AddTechnicalSkillScreen> {
  bool isUpdate = false;
  List<AppModel> getList = getExperienceLevel();
  Future<MasterDataResponse>? technicalListFuture;
  Future<MasterDataResponse>? technicalSkillsLevelListFuture;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    isUpdate = widget.data != null;

    if (isUpdate) {
      technicalSkillStore.setSkillName(MasterData(value: widget.data!.name.validate()));
      technicalSkillStore.setExperienceLevel(MasterData(value: widget.data!.level.validate()));
    } else {
      technicalListFuture = MasterDataController.getTechnicalListApi();
      technicalSkillsLevelListFuture = MasterDataController.getTechnicalSkillsLevelListApi();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    technicalSkillStore.setSkillName(null);
    technicalSkillStore.setExperienceLevel(null);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget((isUpdate ? "Update" : "Add") + " Technical Skills"),
      body: Observer(builder: (context) {
        return AppScaffoldWithLoader(
          isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.addTechnicalSkillApiState].validate(),
          child: Form(
            key: technicalSkillStore.technicalSkillFormState,
            child: SaveButtonWidget(
              buttonName: isUpdate ? "Update Skills" : "Save Skills",
              onSubmit: () {
                if (isUpdate) {
                  technicalSkillStore.onUpdate(id: widget.data!.id.validate());
                } else {
                  technicalSkillStore.onSubmit();
                }
              },
              children: [
                ScreenTitleWidget(
                  isUpdate ? "Update Your Technical Skills" : "Add Your Technical Skills",
                ),
                ScreenSubTitleWidget(
                  isUpdate ? "Modify or add new technical skills to keep your profile up-to-date" : "Provide details about your technical skills to showcase your expertise and capabilities.",
                ),
                16.height,
                TitleFormComponent(
                  text: 'Which skill would you like to add to your profile?',
                  child: MasterDataDropdownWidget(
                    future: technicalListFuture,
                    initialData: technicalSkillStore.skillNameInitialData,
                    initialValue: technicalSkillStore.skillName,
                    isSearch: true,
                    searchName: "Technical Skills",
                    onChanged: technicalSkillStore.setSkillName,
                  ),
                ),
                16.height,
                TitleFormComponent(
                  text: 'Experience level in this area?',
                  child: MasterDataDropdownWidget(
                    future: technicalSkillsLevelListFuture,
                    initialData: technicalSkillStore.experienceLevelInitialData,
                    initialValue: technicalSkillStore.experienceLevel,
                    onChanged: technicalSkillStore.setExperienceLevel,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
