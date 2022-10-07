import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  @override
  void onReady() {
    super.onReady();
    _initCalendar();
    _initCountDownView();
  }

  void _initCalendar() {
    state.controller.addListener(() {
      if (state.controller.size <= state.countDownViewMinChildSize + 0.05) {
        state.isCalendarExpanded = true;
        update();
      } else if (state.isCalendarExpanded) {
        state.isCalendarExpanded = false;
        update();
      }
    });
  }

  void _initCountDownView() {
    RenderBox? appBarBox =
        state.appBarKey.currentContext?.findRenderObject() as RenderBox?;
    final double bodyHeight =
        (Get.context!.size?.height ?? 0) - (appBarBox?.size.height ?? 0);
    state.countDownViewMaxChildSize = (bodyHeight - 116) / bodyHeight;
    RenderBox? calendarBox = state.calendarWidgetKey.currentContext
        ?.findRenderObject() as RenderBox?;
    state.countDownViewMinChildSize =
        (bodyHeight - ((calendarBox?.size.height ?? 0) + 46)) / bodyHeight;
    update();
  }
}
