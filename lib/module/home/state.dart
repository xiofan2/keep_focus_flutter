import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CalendarState { expanded, scrolling, collapsed }

class HomeState {
  final GlobalKey scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey appBarKey = GlobalKey();
  final GlobalKey calendarWidgetKey = GlobalKey();

  late DraggableScrollableController controller;

  late CalendarState calendarState;

  late RxDouble countDownViewMaxChildSize;
  late RxDouble countDownViewMinChildSize;

  double? previousCountDownViewSize;
  double? currentCountDownViewSize;

  HomeState() {
    this
      ..calendarState = CalendarState.collapsed
      ..countDownViewMaxChildSize = 0.8.obs
      ..countDownViewMinChildSize = 0.5.obs
      ..controller = DraggableScrollableController();
  }
}
