import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:r_calendar/r_calendar.dart';
import 'package:yun_base/log/yun_log.dart';

//
// Created by yun on 2020/4/1.
//

typedef DateTimeChanged = void Function(DateTime dateTime);

class HomeCalendar extends StatefulWidget {
  DateTime dateTime;
  DateTimeChanged dateTimeChanged;

  HomeCalendar(this.dateTime, this.dateTimeChanged, {Key key}) : super(key: key);

  @override
  _HomeCalendarState createState() {
    return _HomeCalendarState(dateTime, dateTimeChanged);
  }
}

class _HomeCalendarState extends State<HomeCalendar> {
  DateTime dateTime;
  DateTimeChanged dateTimeChanged;

  RCalendarController<List<DateTime>> controller;

  _HomeCalendarState(this.dateTime, this.dateTimeChanged);

  @override
  void initState() {
    super.initState();

    controller = RCalendarController.single(
      mode: RCalendarMode.week,
      selectedDate: this.dateTime,
      isAutoSelect: false,
      initialData: [
//        DateTime.now(),
//        DateTime.now().add(Duration(days: 1)),
//        DateTime.now().add(Duration(days: 2)),
      ],
    )..addListener(() {
        // controller.isMultiple

        // single selected
//             controller.isAutoSelect
//        controller.selectedDate;
        if (dateTimeChanged != null) {
          dateTimeChanged(controller.selectedDate);
        }

        // multiple selected
        // controller.selectedDates;
        // controller.isDispersion;
      });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RCalendarWidget(
      controller: controller,
      customWidget: MyRCalendarCustomWidget(),
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(2055, 12, 31),
    );
  }
}

class MyRCalendarCustomWidget extends DefaultRCalendarCustomWidget {
  MyRCalendarCustomWidget() {}

  @override
  Widget buildDateTime(BuildContext context, DateTime time, List<RCalendarType> types) {
    // new
    RCalendarController<List<DateTime>> controller = RCalendarMarker.of(context).notifier;
    // new
    TextStyle childStyle;
    BoxDecoration decoration;
    if (types.contains(RCalendarType.disable) || types.contains(RCalendarType.differentMonth)) {
      childStyle = TextStyle(
        color: Colors.grey[400],
        fontSize: 18,
      );
      decoration = BoxDecoration();
    }
    if (types.contains(RCalendarType.normal)) {
      childStyle = TextStyle(
        color: Colors.black,
        fontSize: 18,
      );
      decoration = BoxDecoration();
    }

    if (types.contains(RCalendarType.today)) {
      childStyle = TextStyle(
        color: Colors.blue,
        fontSize: 18,
      );
    }

    if (types.contains(RCalendarType.selected)) {
      childStyle = TextStyle(
        color: Colors.white,
        fontSize: 18,
      );
      decoration = BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      );
    }
    Widget child = Container(
        decoration: decoration,
        alignment: Alignment.center,
        child: Text(
          time.day.toString(),
          style: childStyle,
        ));
    //get mark day
    if (controller.data.where((m) => time.year == m.year && time.month == m.month && time.day == m.day).isNotEmpty) {
      child = Stack(
        children: <Widget>[
          child,
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Icon(
                Icons.star,
                size: 14,
                color: Colors.grey,
              )),
        ],
      );
    }
    return Tooltip(
      message: MaterialLocalizations.of(context).formatFullDate(time),
      child: child,
    );
  }

  @override
  List<Widget> buildWeekListWidget(BuildContext context, MaterialLocalizations localizations) {
    return localizations.narrowWeekdays
        .map(
          (d) => Expanded(
            child: ExcludeSemantics(
              child: Container(
                height: 60,
                alignment: Alignment.center,
                child: Text(
                  d,
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  double get childHeight => 40;

  @override
  FutureOr<bool> clickInterceptor(BuildContext context, DateTime dateTime) {
    YunLog.logData(dateTime.toIso8601String());

    return false;
  }

  @override
  bool isUnable(BuildContext context, DateTime time, bool isSameMonth) {
    return isSameMonth;
  }

  @override
  Widget buildTopWidget(BuildContext context, RCalendarController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            controller.previousPage();
          },
        ),
        SizedBox(
          width: 16,
        ),
        Text(
          DateFormat('yyyy-MM').format(controller.displayedMonthDate),
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
        SizedBox(
          width: 16,
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: () {
            controller.nextPage();
          },
        ),
      ],
    );
  }
}
