import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:ticky/model/dashboard/dashboard_response.dart';

part 'dashboard_store.g.dart';

class DashboardStore = DashboardStoreBase with _$DashboardStore;

abstract class DashboardStoreBase with Store {
  @observable
  int bottomNavigationCurrentIndex = 0;

  @observable
  DashboardResponse? dashboardResponseInitialData;

  @observable
  late TabController tabController;

  @action
  void setBottomNavigationCurrentIndex(int value) {
    bottomNavigationCurrentIndex = value;
  }

  @action
  void initializeTabController({required TickerProvider vsync}) {
    tabController = TabController(length: 4, vsync: vsync);
  }

  @action
  Future<void> dispose() async {
    // Enter the dispose methods
  }
}
