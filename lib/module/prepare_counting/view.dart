import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_focus/module/prepare_counting/widget/flutter_wave_loading.dart';

import 'logic.dart';

class PrepareCountingPage extends StatelessWidget {
  final logic = Get.put(PrepareCountingLogic());
  final state = Get.find<PrepareCountingLogic>().state;

  PrepareCountingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(right: 16),
              child: times,
            ),
          ),
          Flexible(
            flex: 5,
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: countDownWidgets,
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  Widget get times => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '3',
              style: TextStyle(
                  color: Get.theme.colorScheme.tertiary, fontSize: 24),
            ),
            TextSpan(
              text: '/5',
              style: Get.textTheme.subtitle2,
            ),
          ],
        ),
      );

  List<Widget> get countDownWidgets => [
        FlutterWaveLoading(
          width: 75,
          height: 287,
          strokeWidth: 0,
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '倒计时',
              style: Get.textTheme.headline2,
            ),
            const Spacer(),
            timeView(time: 20),
            timeView(time: 20, isMinute: false),
            const Spacer(),
            OutlinedButton(
              onPressed: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Text(
                  '中止',
                  style: TextStyle(
                    color: Get.theme.colorScheme.primary,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ];

  Widget timeView({required int time, bool isMinute = true}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$time',
            style: isMinute
                ? TextStyle(
                    color: Get.theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 63,
                  )
                : TextStyle(
                    color: Get.theme.colorScheme.inversePrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 63,
                  ),
          ),
          TextSpan(
            text: isMinute ? '分' : '秒',
            style: isMinute
                ? TextStyle(
                    color: Get.theme.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )
                : TextStyle(
                    color: Get.theme.colorScheme.inversePrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
          ),
        ],
      ),
    );
  }
}
