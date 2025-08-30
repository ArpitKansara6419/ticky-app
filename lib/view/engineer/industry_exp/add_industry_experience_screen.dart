import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/industry_exp/industry_experience_data.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/model/engineer/personal_details/gender_model.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/master_data_dropdown_widget.dart';
import 'package:ticky/utils/widgets/save_button_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';
import 'package:ticky/view/common_widget.dart';
import 'package:ticky/view/engineer/spoken_languages/utils/data_provider.dart';

class AddIndustryExperienceScreen extends StatefulWidget {
  final IndustryExperienceData? data;

  const AddIndustryExperienceScreen({Key? key, this.data}) : super(key: key);

  @override
  State<AddIndustryExperienceScreen> createState() => _AddIndustryExperienceScreenState();
}

class _AddIndustryExperienceScreenState extends State<AddIndustryExperienceScreen> {
  bool isUpdate = false;

  List<AppModel> getList = getExperienceLevel();

  Future<MasterDataResponse>? industryListFuture;
  Future<MasterDataResponse>? industryLevelListFuture;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    isUpdate = widget.data != null;

    if (isUpdate) {
      industryExperienceStore.setIndustryName(MasterData(value: widget.data!.name.validate()));
      industryExperienceStore.setIndustryLevel(MasterData(value: widget.data!.experience.validate()));
    } else {
      industryListFuture = MasterDataController.getIndustryExpListApi();
      industryLevelListFuture = MasterDataController.getIndustryLevelListApi();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    industryExperienceStore.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget((isUpdate ? "Edit" : "Add") + " Industry Experience"),
      body: Observer(builder: (context) {
        return AppScaffoldWithLoader(
          isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.addIndustryExperienceApiState].validate(),
          child: Form(
            key: industryExperienceStore.industryExperienceFormState,
            child: SaveButtonWidget(
              buttonName: isUpdate ? "Update Experience" : "Save Experience",
              onSubmit: () {
                if (isUpdate) {
                  industryExperienceStore.onUpdate(id: widget.data!.id.validate());
                } else {
                  industryExperienceStore.onSubmit();
                }
              },
              children: [
                ScreenTitleWidget(
                  isUpdate ? "Update Your Industry Experience" : "Add Your Industry Experience",
                ),
                ScreenSubTitleWidget(
                  isUpdate ? "Modify or add new industry experience to keep your profile updated" : "Provide details about your professional experience to showcase your expertise.",
                ),
                16.height,
                TitleFormComponent(
                  text: 'Which industry do you have experience in?',
                  child: MasterDataDropdownWidget(
                    future: industryListFuture,
                    isSearch: true,
                    searchName: "Industry",
                    initialData: industryExperienceStore.industryNameInitialData,
                    initialValue: industryExperienceStore.industryName,
                    onChanged: industryExperienceStore.setIndustryName,
                  ),
                ),
                16.height,
                TitleFormComponent(
                  text: 'Experience level in this area?',
                  child: MasterDataDropdownWidget(
                    future: industryLevelListFuture,
                    initialData: industryExperienceStore.industryLevelInitialData,
                    initialValue: industryExperienceStore.industryLevel,
                    onChanged: industryExperienceStore.setIndustryLevel,
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
