import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ticky/controller/holiday/holiday_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/controller/tickets/ticket_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/tickets/calendar_ticket_response.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/no_data_custom_widget.dart';
import 'package:ticky/view/calendar/widget/my_activity_widget.dart';
import 'package:ticky/view/component/header_component.dart';
import 'package:ticky/view/home/widget/dashboard_ticket_widget.dart';

class MyCalendarScreen extends StatefulWidget {
  const MyCalendarScreen({Key? key}) : super(key: key);

  @override
  State<MyCalendarScreen> createState() => _MyCalendarScreenState();
}

class _MyCalendarScreenState extends State<MyCalendarScreen> {
  Map<DateTime, String> holidays = {};
  late final ValueNotifier<List<DateTickets>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.disabled; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTimeUtils.convertDateTimeToUTC(
    dateTime: DateTime.now(),
  );
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  Future<void> _fetchAppointments({DateTime? dateTime, bool isHolidayListSkipped = false}) async {
    try {
      appLoaderStore.appLoadingState[AppLoaderStateName.calendarApiState] = true;

      if (!isHolidayListSkipped) {
        await _fetchHolidayList();
      }

      final CalendarTicketResponse response = await TicketController.getCalendarTicketListApi(date: dateTime ?? DateTimeUtils.convertDateTimeToUTC(dateTime: DateTime.now()));

      // Clearing old events before adding new ones
      kEvents.clear();

      response.data.forEach((key, DateTickets value) async {
        DateTime parsedDateTime = DateFormat(ShowDateFormat.yyyyMmDdDash).parse(key.trim());
        DateTime eventDate = DateTime.utc(parsedDateTime.year, parsedDateTime.month, parsedDateTime.day);

        if (!kEvents.containsKey(eventDate)) {
          kEvents[eventDate] = [];
        }

        if (value.tickets.validate().isNotEmpty) {
          kEvents[eventDate]!.add(value);
        }

        appLoaderStore.appLoadingState[AppLoaderStateName.calendarApiState] = false;
        setState(() {}); // Update the UI
      });
    } catch (e) {
      appLoaderStore.appLoadingState[AppLoaderStateName.calendarApiState] = false;
      toast("Error fetching appointments: $e");
    }
  }

  Future<void> _fetchHolidayList() async {
    try {
      final response = await HolidayController.getHolidayListApi();

      for (var e in response.holidayData!) {
        holidays[DateTime.parse(e.date.validate())] = e.title.validate();
      }
    } catch (e) {
      toast("Error fetching holidays: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    await _fetchAppointments(
        dateTime: DateTimeUtils.convertDateTimeToUTC(
      dateTime: DateTime.now(),
    ));
    _selectedEvents.value = _getEventsForDay(_selectedDay!);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    calenderGlobalKey.currentState?.dispose();
    super.dispose();
  }

  List<DateTickets> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<DateTickets> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  bool isHoliday(DateTime day) {
    return holidays.keys.any((holiday) => holiday.year == day.year && holiday.month == day.month && holiday.day == day.day);
  }

  Map<DateTime, String> getHolidaysForMonth(DateTime date) {
    int month = date.month;
    int year = date.year;
    return Map.fromEntries(holidays.entries.where((entry) => entry.key.month == month && entry.key.year == year));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: calenderGlobalKey,
      appBar: HeaderComponent(name: MenuName.calendar),
      body: Observer(
        builder: (context) {
          return AppScaffoldWithLoader(
            isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.calendarApiState].validate(),
            child: AnimatedScrollView(
              listAnimationType: ListAnimationType.None,
              children: [
                TableCalendar<DateTickets>(
                  firstDay: DateTime(2025),
                  lastDay: DateTime(2035),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  headerStyle: HeaderStyle(
                    leftChevronMargin: EdgeInsets.symmetric(horizontal: 0),
                    rightChevronMargin: EdgeInsets.symmetric(horizontal: 0),
                    titleCentered: true,
                    formatButtonPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    formatButtonDecoration: BoxDecoration(borderRadius: radius(), border: Border.all(color: borderColor)),
                    formatButtonShowsNext: false,
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: boldTextStyle(size: 14), weekendStyle: secondaryTextStyle(color: context.theme.colorScheme.error)),
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: _getEventsForDay,
                  enabledDayPredicate: (DateTime day) => day.weekday != DateTime.saturday && day.weekday != DateTime.sunday,
                  holidayPredicate: (day) => isHoliday(day),
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  calendarStyle: CalendarStyle(
                    markerSize: 6,
                    canMarkersOverflow: true,
                    markersMaxCount: 1,
                    markerDecoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                    outsideDaysVisible: false,
                    holidayDecoration: BoxDecoration(color: Colors.orange.shade200, shape: BoxShape.circle),
                    holidayTextStyle: boldTextStyle(),
                    isTodayHighlighted: true,
                    disabledTextStyle: secondaryTextStyle(color: context.theme.colorScheme.error),
                    todayDecoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                    selectedDecoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  ),
                  loadEventsForDisabledDays: false,
                  onDaySelected: _onDaySelected,
                  pageAnimationCurve: Curves.easeInOutBack,
                  onRangeSelected: _onRangeSelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) async {
                    _focusedDay = focusedDay;
                    _selectedDay = focusedDay;
                    await _fetchAppointments(dateTime: focusedDay, isHolidayListSkipped: true);
                    if (focusedDay.month ==
                        DateTimeUtils.convertDateTimeToUTC(
                          dateTime: DateTime.now(),
                        ).month) {
                      _selectedEvents.value = _getEventsForDay(DateTimeUtils.convertDateTimeToUTC(
                        dateTime: DateTime.now(),
                      ));
                      _selectedDay = DateTimeUtils.convertDateTimeToUTC(
                        dateTime: DateTime.now(),
                      );
                    } else {
                      _selectedEvents.value = _getEventsForDay(focusedDay);
                    }
                  },
                ),
                16.height,
                Divider(),
                if (getHolidaysForMonth(_focusedDay).isNotEmpty) ...{
                  Wrap(
                    spacing: 32,
                    runSpacing: 16,
                    children: getHolidaysForMonth(_focusedDay).entries.map((entry) {
                      return Container(
                        width: context.width() / 2 - 32,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(color: Colors.orange.shade200, borderRadius: radius()),
                                width: 4,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(formatDate(entry.key.toString(), outputFormat: ShowDateFormat.ddMmmYyyyEe), style: secondaryTextStyle(size: 12)),
                                Text(entry.value, style: primaryTextStyle(size: 12)),
                              ],
                            ).paddingLeft(10), // Display holiday name
                          ],
                        ),
                      );
                    }).toList(),
                  ).paddingSymmetric(horizontal: 16),
                  Divider(),
                },
                ValueListenableBuilder<List<DateTickets>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    if (value.isEmpty) {
                      return NoDataCustomWidget(title: "No Appointments");
                    }
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        DateTickets data = value[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  16.height,
                                  Text("Employee Work Log", style: boldTextStyle(size: 18)),
                                  16.height,
                                  Wrap(
                                    runSpacing: 16,
                                    spacing: 16,
                                    children: [
                                      MyActivityWidget(
                                        icon: Icons.login_outlined,
                                        title: 'Check In',
                                        value: data.checkIn.validate(),
                                      ),
                                      MyActivityWidget(
                                        icon: Icons.logout_outlined,
                                        title: 'Check out',
                                        value: data.checkout.validate(),
                                      ),
                                      MyActivityWidget(
                                        icon: Icons.breakfast_dining_outlined,
                                        title: 'Break Time',
                                        value: data.breakTime.validate() == "00:00:00" ? "- -" : data.breakTime.validate(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            16.height,
                            AnimatedListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.tickets.length,
                              padding: EdgeInsets.only(left: 8, right: 8, bottom: 20),
                              itemBuilder: (p0, index) => DashboardTicketWidget(data: data.tickets[index], focusedDate: _selectedDay),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Event {
  final String title;
  final TicketData? ticketData;
  final DateTickets? attendance;

  const Event(this.title, {this.ticketData, this.attendance});

  @override
  String toString() => title;

  TicketData? toTicketData() => ticketData;

  DateTickets? toDateTickets() => attendance;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<DateTickets>>(
  equals: isSameDay,
  hashCode: getHashCode,
);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}
