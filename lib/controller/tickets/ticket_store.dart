import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/controller/tickets/ticket_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:ticky/utils/enums.dart';

part 'ticket_store.g.dart';

class TicketStore = TicketStoreBase with _$TicketStore;

abstract class TicketStoreBase with Store {
  @observable
  GlobalKey<FormState> declineFromState = GlobalKey();

  @observable
  TextEditingController declineCont = TextEditingController();

  @observable
  String? ticketCode;

  @observable
  String? ticketID;

  @action
  void assignTicketCodeAndID({
    required String? ticketCodeTemp,
    required String? ticketIDTemp,
  }) {
    ticketCode = ticketCodeTemp;
    ticketID = ticketIDTemp;
    mainLog(message: 'ticketCode => $ticketCode\nticketID => $ticketID');
  }

  @action
  void setCurrentStatusIndex(int value) {
    dashboardStore.tabController.index = value;
  }

  @action
  Future<void> updateTicketStatus({required int ticketId, required String? status}) async {
    Map<String, dynamic> req = {
      "engineer_status": status ?? "accept",
      "ticket_id": ticketId,
    };

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.ticketAcceptedStatusApiState, value: true);

    await TicketController.ticketStatusApi(req: req);

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.ticketAcceptedStatusApiState, value: false);
  }

  @action
  Future<void> dispose() async {
    // Enter the dispose methods
  }
}
