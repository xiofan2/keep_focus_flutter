import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SettingsPage extends StatelessWidget {
  final logic = Get.put(SettingsLogic());
  final state = Get.find<SettingsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
