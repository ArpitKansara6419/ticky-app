// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardStore on DashboardStoreBase, Store {
  late final _$bottomNavigationCurrentIndexAtom = Atom(
      name: 'DashboardStoreBase.bottomNavigationCurrentIndex',
      context: context);

  @override
  int get bottomNavigationCurrentIndex {
    _$bottomNavigationCurrentIndexAtom.reportRead();
    return super.bottomNavigationCurrentIndex;
  }

  @override
  set bottomNavigationCurrentIndex(int value) {
    _$bottomNavigationCurrentIndexAtom
        .reportWrite(value, super.bottomNavigationCurrentIndex, () {
      super.bottomNavigationCurrentIndex = value;
    });
  }

  late final _$dashboardResponseInitialDataAtom = Atom(
      name: 'DashboardStoreBase.dashboardResponseInitialData',
      context: context);

  @override
  DashboardResponse? get dashboardResponseInitialData {
    _$dashboardResponseInitialDataAtom.reportRead();
    return super.dashboardResponseInitialData;
  }

  @override
  set dashboardResponseInitialData(DashboardResponse? value) {
    _$dashboardResponseInitialDataAtom
        .reportWrite(value, super.dashboardResponseInitialData, () {
      super.dashboardResponseInitialData = value;
    });
  }

  late final _$tabControllerAtom =
      Atom(name: 'DashboardStoreBase.tabController', context: context);

  @override
  TabController get tabController {
    _$tabControllerAtom.reportRead();
    return super.tabController;
  }

  bool _tabControllerIsInitialized = false;

  @override
  set tabController(TabController value) {
    _$tabControllerAtom.reportWrite(
        value, _tabControllerIsInitialized ? super.tabController : null, () {
      super.tabController = value;
      _tabControllerIsInitialized = true;
    });
  }

  late final _$disposeAsyncAction =
      AsyncAction('DashboardStoreBase.dispose', context: context);

  @override
  Future<void> dispose() {
    return _$disposeAsyncAction.run(() => super.dispose());
  }

  late final _$DashboardStoreBaseActionController =
      ActionController(name: 'DashboardStoreBase', context: context);

  @override
  void setBottomNavigationCurrentIndex(int value) {
    final _$actionInfo = _$DashboardStoreBaseActionController.startAction(
        name: 'DashboardStoreBase.setBottomNavigationCurrentIndex');
    try {
      return super.setBottomNavigationCurrentIndex(value);
    } finally {
      _$DashboardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initializeTabController({required TickerProvider vsync}) {
    final _$actionInfo = _$DashboardStoreBaseActionController.startAction(
        name: 'DashboardStoreBase.initializeTabController');
    try {
      return super.initializeTabController(vsync: vsync);
    } finally {
      _$DashboardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bottomNavigationCurrentIndex: ${bottomNavigationCurrentIndex},
dashboardResponseInitialData: ${dashboardResponseInitialData},
tabController: ${tabController}
    ''';
  }
}
