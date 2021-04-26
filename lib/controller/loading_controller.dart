import 'package:get/get.dart';
import 'package:socialtinder/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loader extends GetxController {
    loadingDismiss() {
    // EasyLoading.showSuccess('Data Fetched');
    EasyLoading.dismiss();
  }

  loadingShow() {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
  }
}
