import 'package:flutter/material.dart';

class HomeState {
  final GlobalKey scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey appBarKey = GlobalKey();
  final GlobalKey calendarWidgetKey = GlobalKey();

  late DraggableScrollableController controller;

  late bool isCalendarExpanded;

  late double countDownViewMaxChildSize;
  late double countDownViewMinChildSize;

  HomeState() {
    this
      ..isCalendarExpanded = false
      ..countDownViewMaxChildSize = 0.8
      ..countDownViewMinChildSize = 0.5
      ..controller = DraggableScrollableController();
  }
}
