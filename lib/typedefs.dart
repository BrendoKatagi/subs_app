import 'package:flutter/material.dart';

typedef PageBuilder = Widget Function(BuildContext context, Object? arguments);
typedef PageTransition = Widget Function(BuildContext, Animation<double>, Animation<double>, Widget);
typedef JsonObject = Map<String, Object?>;
