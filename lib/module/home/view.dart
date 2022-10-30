import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:keep_focus/module/settings/view.dart';
import 'package:keep_focus/universal_widget/calendar_widget.dart';

import 'component/count_down_view.dart';
import 'logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(
      init: logic,
      builder: (logic) {
        return Scaffold(
          key: state.scaffoldState,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          appBar: AppBar(
            key: state.appBarKey,
            scrolledUnderElevation: 0,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context).title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              IconButton(
                onPressed: () => Get.to(SettingsPage()),
                icon: const Icon(Icons.settings_outlined),
              ),
            ],
          ),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: CalendarWidget(
                    key: state.calendarWidgetKey,
                    monthDate: DateTime.now(),
                    calendarState: state.calendarState,
                    onSetCalendar: () => logic.adjustCountDownView(),
                  ),
                ),
              ),
              Obx(
                () => CountDownView(
                  controller: state.controller,
                  maxChildSize: state.countDownViewMaxChildSize.value,
                  minChildSize: state.countDownViewMinChildSize.value,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
