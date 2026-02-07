import 'package:flutter/material.dart';
import 'package:substore_app/shared/constants/view_constants.dart';

extension ViewPort on BuildContext {
  bool isSmallDevice() {
    final Size viewPort = MediaQuery.of(this).size;
    return viewPort.width <= smallWidth;
  }

  bool isMediumDevice() {
    final Size viewPort = MediaQuery.of(this).size;
    return viewPort.width <= phoneWidth;
  }
}
