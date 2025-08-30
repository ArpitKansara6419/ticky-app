import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/controller/engineer/travel_details/travel_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/model/engineer/personal_details/gender_model.dart';
import 'package:ticky/model/engineer/travel_details/travel_details_data.dart';
import 'package:ticky/model/engineer/travel_details/travel_details_response.dart';

part 'travel_details_store.g.dart';

class TravelDetailsStore = TravelDetailsStoreBase with _$TravelDetailsStore;

abstract class TravelDetailsStoreBase with Store {
  @observable
  TravelDetailsResponse? cachedTravelDetailResponse;

  @observable
  MasterDataResponse? vehicleListMetaData;

  @observable
  AppModel? isDrivingLicense;

  @observable
  TravelDetailsData? travelDetailsData;

  @observable
  AppModel? isOwnVehicles;

  @observable
  ObservableList<MasterData>? typesOfVehicles = ObservableList();

  @observable
  ObservableList<AppModel> haveDrivingLicenseList = ObservableList.of(getYesNoList());

  @observable
  ObservableList<AppModel> haveOwnVehicleList = ObservableList.of(getYesNoList());

  @observable
  TextEditingController workingRadiusCont = TextEditingController();

  @observable
  FocusNode workingRadiusFocusNode = FocusNode();

  Future<void> init() async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.travelDetailApiState, value: true);
    MasterDataResponse vehicleList = await MasterDataController.getVehicleListApi();

    await TravelController.getTravelDetailListApi().then((data) {
      travelDetailsData = data!.data;

      if (travelDetailsData != null) {
        if (travelDetailsData!.workingRadius != null) {
          workingRadiusCont.text = travelDetailsData!.workingRadius.validate().toString();
        }

        if (travelDetailsData!.drivingLicense != null) {
          setDrivingLicense(haveDrivingLicenseList.firstWhere((e) => e.value.toInt() == travelDetailsData!.drivingLicense.validate()));
        }

        if (travelDetailsData!.ownVehicle != null) {
          setIsOwnVehicles(haveOwnVehicleList.firstWhere((e) => e.value.toInt() == travelDetailsData!.ownVehicle.validate()));
        }

        if (travelDetailsData!.typeOfVehicle.validate().isNotEmpty) {
          travelDetailsData!.typeOfVehicle!.forEachIndexed(
            (e, index) {
              MasterData res = vehicleList.masterDataList!.firstWhere((element) => element.value == e.validate());
              setTypeOfVehicle(res);
            },
          );
        }
      }

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.travelDetailApiState, value: false);
    });
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.travelDetailApiState, value: false);
  }

  @action
  void setDrivingLicense(AppModel value) {
    isDrivingLicense = value;
  }

  @action
  void setIsOwnVehicles(AppModel value) {
    isOwnVehicles = value;
  }

  @action
  void setTypeOfVehicle(MasterData value) {
    if (typesOfVehicles!.any((e) => e.value.validate() == value.value.validate())) {
      typesOfVehicles?.removeWhere((e) => e.value.validate() == value.value.validate());
    } else {
      typesOfVehicles?.add(value);
    }
  }

  @observable
  GlobalKey<FormState> travelFormState = GlobalKey();

  @action
  Future<void> onSubmit() async {
    if (travelFormState.currentState!.validate()) {
      travelFormState.currentState!.save();

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.travelDetailApiState, value: true);
      print(isDrivingLicense?.value);
      Map<String, dynamic> request = {
        "user_id": userStore.userId,
        "driving_license": isDrivingLicense?.value,
        "own_vehicle": isOwnVehicles?.value,
        "working_radius": workingRadiusCont.text.validate().toInt(),
        "type_of_vehicle": isOwnVehicles?.value == "0" ? [] : typesOfVehicles.validate().map((element) => element.value.validate()).toList(),
      };

      log(request);

      await TravelController.addTravelDetailApi(request: request).then((res) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.travelDetailApiState, value: false);
        toast(res.message.validate());

        finish(getContext);
      }).catchError((e) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
        toast(e.toString(), print: true);
      });

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
    }
  }
}
