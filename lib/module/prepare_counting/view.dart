import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_focus/common_widget/count_down_widget.dart';

import 'logic.dart';

class PrepareCountingPage extends StatelessWidget {
  final logic = Get.put(PrepareCountingLogic());
  final state = Get.find<PrepareCountingLogic>().state;

  PrepareCountingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CountDownWidget(),
      ],
    );
  }
}
