import 'package:mobx/mobx.dart';
import 'package:ticky/controller/attendance/attendance_controller.dart';
import 'package:ticky/model/attendance/attendance_response.dart';

part 'attendance_store.g.dart';

class AttendanceStore = AttendanceStoreBase with _$AttendanceStore;

abstract class AttendanceStoreBase with Store {
  @observable
  ObservableFuture<AttendanceResponse>? future;

  /// Method to fetch attendance data for a given date
  @action
  Future<void> fetchAttendance(DateTime date) async {
    try {
      // Set the `future` to an observable future from an API call
      future = ObservableFuture(_fetchAttendanceFromApi(date));

      // Wait for the result (optional, for additional actions or debugging)
      await future;
    } catch (error) {
      // Handle errors (e.g., logging or setting an error state)
      print("Error fetching attendance: $error");
    }
  }

  /// Mocked API call (replace with your actual API integration)
  Future<AttendanceResponse> _fetchAttendanceFromApi(DateTime date) async {
    return await AttendanceController.getAttendanceApi(date: date);
  }
}
