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
    adjustCountDownView();
  }

  void _initCalendar() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      state.controller.addListener(() {
        if (state.controller.size <= state.countDownViewMinChildSize.value) {
          state.calendarState = CalendarState.expanded;
          update();
        } else if (state.controller.size >=
            state.countDownViewMaxChildSize.value) {
          state.calendarState = CalendarState.collapsed;
          update();
        } else {
          state.calendarState = CalendarState.scrolling;
          update();
        }
      });
    });
  }

  void adjustCountDownView() {
    RenderBox? appBarBox =
        state.appBarKey.currentContext?.findRenderObject() as RenderBox?;
    final double bodyHeight =
        (Get.context!.size?.height ?? 0) - (appBarBox?.size.height ?? 0);
    state.countDownViewMaxChildSize = ((bodyHeight - 116) / bodyHeight).obs;
    RenderBox? calendarBox = state.calendarWidgetKey.currentContext
        ?.findRenderObject() as RenderBox?;
    state.countDownViewMinChildSize =
        ((bodyHeight - ((calendarBox?.size.height ?? 0) + 46)) / bodyHeight)
            .obs;
  }
}
