// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TravelDetailsStore on TravelDetailsStoreBase, Store {
  late final _$cachedTravelDetailResponseAtom = Atom(
      name: 'TravelDetailsStoreBase.cachedTravelDetailResponse',
      context: context);

  @override
  TravelDetailsResponse? get cachedTravelDetailResponse {
    _$cachedTravelDetailResponseAtom.reportRead();
    return super.cachedTravelDetailResponse;
  }

  @override
  set cachedTravelDetailResponse(TravelDetailsResponse? value) {
    _$cachedTravelDetailResponseAtom
        .reportWrite(value, super.cachedTravelDetailResponse, () {
      super.cachedTravelDetailResponse = value;
    });
  }

  late final _$vehicleListMetaDataAtom = Atom(
      name: 'TravelDetailsStoreBase.vehicleListMetaData', context: context);

  @override
  MasterDataResponse? get vehicleListMetaData {
    _$vehicleListMetaDataAtom.reportRead();
    return super.vehicleListMetaData;
  }

  @override
  set vehicleListMetaData(MasterDataResponse? value) {
    _$vehicleListMetaDataAtom.reportWrite(value, super.vehicleListMetaData, () {
      super.vehicleListMetaData = value;
    });
  }

  late final _$isDrivingLicenseAtom =
      Atom(name: 'TravelDetailsStoreBase.isDrivingLicense', context: context);

  @override
  AppModel? get isDrivingLicense {
    _$isDrivingLicenseAtom.reportRead();
    return super.isDrivingLicense;
  }

  @override
  set isDrivingLicense(AppModel? value) {
    _$isDrivingLicenseAtom.reportWrite(value, super.isDrivingLicense, () {
      super.isDrivingLicense = value;
    });
  }

  late final _$travelDetailsDataAtom =
      Atom(name: 'TravelDetailsStoreBase.travelDetailsData', context: context);

  @override
  TravelDetailsData? get travelDetailsData {
    _$travelDetailsDataAtom.reportRead();
    return super.travelDetailsData;
  }

  @override
  set travelDetailsData(TravelDetailsData? value) {
    _$travelDetailsDataAtom.reportWrite(value, super.travelDetailsData, () {
      super.travelDetailsData = value;
    });
  }

  late final _$isOwnVehiclesAtom =
      Atom(name: 'TravelDetailsStoreBase.isOwnVehicles', context: context);

  @override
  AppModel? get isOwnVehicles {
    _$isOwnVehiclesAtom.reportRead();
    return super.isOwnVehicles;
  }

  @override
  set isOwnVehicles(AppModel? value) {
    _$isOwnVehiclesAtom.reportWrite(value, super.isOwnVehicles, () {
      super.isOwnVehicles = value;
    });
  }

  late final _$typesOfVehiclesAtom =
      Atom(name: 'TravelDetailsStoreBase.typesOfVehicles', context: context);

  @override
  ObservableList<MasterData>? get typesOfVehicles {
    _$typesOfVehiclesAtom.reportRead();
    return super.typesOfVehicles;
  }

  @override
  set typesOfVehicles(ObservableList<MasterData>? value) {
    _$typesOfVehiclesAtom.reportWrite(value, super.typesOfVehicles, () {
      super.typesOfVehicles = value;
    });
  }

  late final _$haveDrivingLicenseListAtom = Atom(
      name: 'TravelDetailsStoreBase.haveDrivingLicenseList', context: context);

  @override
  ObservableList<AppModel> get haveDrivingLicenseList {
    _$haveDrivingLicenseListAtom.reportRead();
    return super.haveDrivingLicenseList;
  }

  @override
  set haveDrivingLicenseList(ObservableList<AppModel> value) {
    _$haveDrivingLicenseListAtom
        .reportWrite(value, super.haveDrivingLicenseList, () {
      super.haveDrivingLicenseList = value;
    });
  }

  late final _$haveOwnVehicleListAtom =
      Atom(name: 'TravelDetailsStoreBase.haveOwnVehicleList', context: context);

  @override
  ObservableList<AppModel> get haveOwnVehicleList {
    _$haveOwnVehicleListAtom.reportRead();
    return super.haveOwnVehicleList;
  }

  @override
  set haveOwnVehicleList(ObservableList<AppModel> value) {
    _$haveOwnVehicleListAtom.reportWrite(value, super.haveOwnVehicleList, () {
      super.haveOwnVehicleList = value;
    });
  }

  late final _$workingRadiusContAtom =
      Atom(name: 'TravelDetailsStoreBase.workingRadiusCont', context: context);

  @override
  TextEditingController get workingRadiusCont {
    _$workingRadiusContAtom.reportRead();
    return super.workingRadiusCont;
  }

  @override
  set workingRadiusCont(TextEditingController value) {
    _$workingRadiusContAtom.reportWrite(value, super.workingRadiusCont, () {
      super.workingRadiusCont = value;
    });
  }

  late final _$workingRadiusFocusNodeAtom = Atom(
      name: 'TravelDetailsStoreBase.workingRadiusFocusNode', context: context);

  @override
  FocusNode get workingRadiusFocusNode {
    _$workingRadiusFocusNodeAtom.reportRead();
    return super.workingRadiusFocusNode;
  }

  @override
  set workingRadiusFocusNode(FocusNode value) {
    _$workingRadiusFocusNodeAtom
        .reportWrite(value, super.workingRadiusFocusNode, () {
      super.workingRadiusFocusNode = value;
    });
  }

  late final _$travelFormStateAtom =
      Atom(name: 'TravelDetailsStoreBase.travelFormState', context: context);

  @override
  GlobalKey<FormState> get travelFormState {
    _$travelFormStateAtom.reportRead();
    return super.travelFormState;
  }

  @override
  set travelFormState(GlobalKey<FormState> value) {
    _$travelFormStateAtom.reportWrite(value, super.travelFormState, () {
      super.travelFormState = value;
    });
  }

  late final _$onSubmitAsyncAction =
      AsyncAction('TravelDetailsStoreBase.onSubmit', context: context);

  @override
  Future<void> onSubmit() {
    return _$onSubmitAsyncAction.run(() => super.onSubmit());
  }

  late final _$TravelDetailsStoreBaseActionController =
      ActionController(name: 'TravelDetailsStoreBase', context: context);

  @override
  void setDrivingLicense(AppModel value) {
    final _$actionInfo = _$TravelDetailsStoreBaseActionController.startAction(
        name: 'TravelDetailsStoreBase.setDrivingLicense');
    try {
      return super.setDrivingLicense(value);
    } finally {
      _$TravelDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsOwnVehicles(AppModel value) {
    final _$actionInfo = _$TravelDetailsStoreBaseActionController.startAction(
        name: 'TravelDetailsStoreBase.setIsOwnVehicles');
    try {
      return super.setIsOwnVehicles(value);
    } finally {
      _$TravelDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTypeOfVehicle(MasterData value) {
    final _$actionInfo = _$TravelDetailsStoreBaseActionController.startAction(
        name: 'TravelDetailsStoreBase.setTypeOfVehicle');
    try {
      return super.setTypeOfVehicle(value);
    } finally {
      _$TravelDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cachedTravelDetailResponse: ${cachedTravelDetailResponse},
vehicleListMetaData: ${vehicleListMetaData},
isDrivingLicense: ${isDrivingLicense},
travelDetailsData: ${travelDetailsData},
isOwnVehicles: ${isOwnVehicles},
typesOfVehicles: ${typesOfVehicles},
haveDrivingLicenseList: ${haveDrivingLicenseList},
haveOwnVehicleList: ${haveOwnVehicleList},
workingRadiusCont: ${workingRadiusCont},
workingRadiusFocusNode: ${workingRadiusFocusNode},
travelFormState: ${travelFormState}
    ''';
  }
}
