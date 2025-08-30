import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/model/engineer/personal_details/gender_model.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/custom_check_box_widget.dart';
import 'package:ticky/utils/widgets/save_button_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';

import '../../../utils/imports.dart';

class TravelDetailsScreen extends StatefulWidget {
  const TravelDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TravelDetailsScreen> createState() => _TravelDetailsScreenState();
}

class _TravelDetailsScreenState extends State<TravelDetailsScreen> {
  Future<MasterDataResponse>? vehicleMasterDataFuture;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    vehicleMasterDataFuture = MasterDataController.getVehicleListApi();
    travelDetailsStore.init();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    travelDetailsStore.typesOfVehicles!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBarWidget("Travel Details"),
        body: Observer(builder: (context) {
          return AppScaffoldWithLoader(
            isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.travelDetailApiState].validate(),
            child: Form(
              key: travelDetailsStore.travelFormState,
              child: SaveButtonWidget(
                onSubmit: () {
                  travelDetailsStore.onSubmit();
                },
                children: [
                  TitleFormComponent(
                    text: 'Working Radius',
                    child: AppTextField(
                      textFieldType: TextFieldType.NUMBER,
                      controller: travelDetailsStore.workingRadiusCont,
                      focus: travelDetailsStore.workingRadiusFocusNode,
                      minLines: 1,
                      isValidationRequired: false,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail),
                    ),
                  ),
                  16.height,
                  TitleFormComponent(
                    text: 'Do you have a driving license?',
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: radius()),
                      child: Wrap(
                        children: List.generate(
                          travelDetailsStore.haveDrivingLicenseList.length,
                          (index) {
                            AppModel data = travelDetailsStore.haveDrivingLicenseList[index];
                            return InkWell(
                              onTap: () {
                                travelDetailsStore.setDrivingLicense(data);
                              },
                              borderRadius: radius(),
                              child: Container(
                                width: context.width() / 2 - 17,
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Observer(
                                      builder: (context) => CustomCheckBoxWidget(isChecked: travelDetailsStore.isDrivingLicense?.value == data.value),
                                    ),
                                    8.width,
                                    Text(data.title.validate(), style: primaryTextStyle()),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  16.height,
                  TitleFormComponent(
                    text: 'Do you have access to your own vehicles(s)?',
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: radius()),
                      child: Wrap(
                        children: List.generate(
                          travelDetailsStore.haveOwnVehicleList.length,
                          (index) {
                            AppModel data = travelDetailsStore.haveOwnVehicleList[index];
                            return InkWell(
                              onTap: () {
                                travelDetailsStore.setIsOwnVehicles(data);
                              },
                              borderRadius: radius(),
                              child: Container(
                                width: context.width() / 2 - 17,
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Observer(
                                      builder: (context) => CustomCheckBoxWidget(isChecked: travelDetailsStore.isOwnVehicles?.value == data.value),
                                    ),
                                    8.width,
                                    Text(data.title.validate(), style: primaryTextStyle()),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  16.height,
                  FutureBuilder<MasterDataResponse>(
                    initialData: travelDetailsStore.vehicleListMetaData,
                    future: vehicleMasterDataFuture,
                    builder: (context, snap) {
                      return TitleFormComponent(
                        text: 'Which type(s) of vehicle?',
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
                                          if (travelDetailsStore.isOwnVehicles == null || travelDetailsStore.isOwnVehicles?.value == "0") {
                                            return;
                                          }
                                          travelDetailsStore.setTypeOfVehicle(data);
                                        },
                                        child: Container(
                                          width: context.width() / 2 - 17,
                                          padding: EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              Observer(
                                                builder: (context) => CustomCheckBoxWidget(
                                                    isChecked: (travelDetailsStore.isOwnVehicles == null || travelDetailsStore.isOwnVehicles?.value == "0")
                                                        ? false
                                                        : travelDetailsStore.typesOfVehicles!.any((MasterData element) => element.value == data.value)),
                                              ),
                                              8.width,
                                              Observer(builder: (context) {
                                                return Text(data.label.validate(),
                                                    style: primaryTextStyle(color: (travelDetailsStore.isOwnVehicles == null || travelDetailsStore.isOwnVehicles?.value == "0") ? Colors.grey : null));
                                              }),
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
        }));
  }
}
