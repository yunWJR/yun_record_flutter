import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:r_calendar/r_calendar.dart';

//
// Created by yun on 2020/4/1.
//

typedef DateTimeChanged = void Function(DateTime dateTime);

class HomeCalendar extends StatefulWidget {
  final DateTime dateTime;
  final DateTimeChanged dateTimeChanged;

  HomeCalendar(this.dateTime, this.dateTimeChanged, {Key key}) : super(key: key);

  @override
  _HomeCalendarState createState() {
    return _HomeCalendarState(dateTime, dateTimeChanged);
  }
}

class _HomeCalendarState extends State<HomeCalendar> {
  DateTime dateTime;
  DateTimeChanged dateTimeChanged;

  int startYear = 2000;
  int endYear = 2055;

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
    ThemeData tD = Theme.of(context);
    return RCalendarWidget(
      controller: controller,
      customWidget: MyRCalendarCustomWidget(tD),
      firstDate: DateTime(startYear, 1, 1),
      lastDate: DateTime(endYear, 12, 31),
    );
  }
}

class MyRCalendarCustomWidget extends DefaultRCalendarCustomWidget {
  int startYear;
  int endYear;

  ThemeData tD;
  TextStyle tStyle;

  MyRCalendarCustomWidget(this.tD, {this.startYear = 2000, this.endYear = 2055}) {
    this.tStyle = tD.textTheme.title;
  }

  @override
  Widget buildDateTime(BuildContext context, DateTime time, List<RCalendarType> types) {
    RCalendarController<List<DateTime>> controller = RCalendarMarker.of(context).notifier;

    TextStyle childStyle;
    BoxDecoration decoration;
    if (types.contains(RCalendarType.disable) || types.contains(RCalendarType.differentMonth)) {
      childStyle = TextStyle(
        color: Colors.grey[400],
        fontSize: tStyle.fontSize,
      );
      decoration = BoxDecoration();
    }

    if (types.contains(RCalendarType.normal)) {
      childStyle = TextStyle(
//        color: Colors.black,
        fontSize: tStyle.fontSize - 2,
      );
      decoration = BoxDecoration();
    }

    if (types.contains(RCalendarType.today)) {
      childStyle = TextStyle(
        color: tD.primaryColor,
        fontSize: tStyle.fontSize,
      );
    }

    if (types.contains(RCalendarType.selected)) {
      childStyle = TextStyle(
        color: tD.textSelectionColor,
        fontSize: tStyle.fontSize,
      );
      decoration = BoxDecoration(
        shape: BoxShape.circle,
        color: tD.primaryColor,
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
    List<Widget> weeks = List();

    int wI = localizations.firstDayOfWeekIndex;
    for (int i = 0; i < 7; i++) {
      String d = "";
      if (wI == 0) {
        d = "日";
      } else if (wI == 1) {
        d = "一";
      } else if (wI == 2) {
        d = "二";
      } else if (wI == 3) {
        d = "三";
      } else if (wI == 4) {
        d = "四";
      } else if (wI == 5) {
        d = "五";
      } else if (wI == 6) {
        d = "六";
      }

      Color dC = (wI == 0 || wI == 6) ? tStyle.color.withOpacity(0.3) : tStyle.color;

      var item = Expanded(
        child: ExcludeSemantics(
          child: Container(
            height: tStyle.fontSize + 8,
            alignment: Alignment.center,
            child: Text(
              d,
              style: TextStyle(color: dC, fontSize: tStyle.fontSize),
            ),
          ),
        ),
      );

      weeks.add(item);

      wI++;
      if (wI > 6) {
        wI = 0;
      }
    }

    return weeks;

    return localizations.narrowWeekdays
        .map(
          (d) => Expanded(
            child: ExcludeSemantics(
              child: Container(
                height: 20,
                alignment: Alignment.center,
                child: Text(
                  d,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  double get childHeight => tStyle == null ? 50 : tStyle.fontSize + 18;

  @override
  FutureOr<bool> clickInterceptor(BuildContext context, DateTime dateTime) {
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
          icon: Icon(Icons.title),
          onPressed: () {
            controller.updateSelected(DateTime.now());
//            controller.selectedDate = DateTime.now();
          },
        ),
        SizedBox(
          width: 8,
        ),
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            controller.previousPage();
          },
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          DateFormat('yyyy-MM').format(controller.displayedMonthDate),
          //          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
        SizedBox(
          width: 4,
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: () {
            controller.nextPage();
          },
        ),
        SizedBox(
          width: 8,
        ),
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            _onDate(context, controller);
          },
        ),
      ],
    );
  }

  _onDate(BuildContext context, RCalendarController controller) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(startYear, 1, 1),
        maxTime: DateTime(endYear, 12, 31),
        onChanged: (date) {}, onConfirm: (date) {
      controller.updateSelected(date);
    }, currentTime: controller.selectedDate ?? DateTime.now(), locale: LocaleType.zh);
  }
}
