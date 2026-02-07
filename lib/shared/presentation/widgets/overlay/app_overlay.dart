import 'package:flutter/material.dart';

class AppOverlayEntry extends OverlayEntry {
  Future<void> Function()? dismiss;

  AppOverlayEntry({this.dismiss, required super.builder});
}

class AppOverlay {
  AppOverlay._();

  static List<AppOverlayEntry> overlayEntries = <AppOverlayEntry>[];

  static void show(BuildContext context, Widget overlay) {
    final AppOverlayEntry overlayEntry = AppOverlayEntry(builder: (_) => Positioned.fill(child: overlay));
    final AppOverlayEntry? above = overlayEntries.isEmpty ? null : overlayEntries.last;

    Overlay.of(context).insert(overlayEntry, above: above);
    overlayEntries.add(overlayEntry);
  }

  static Future<void> dismiss() async {
    if (overlayEntries.isEmpty) return;

    final AppOverlayEntry overlayEntry = overlayEntries.last;
    if (overlayEntry.dismiss != null) await overlayEntry.dismiss!();
    overlayEntry.remove();
    overlayEntries.remove(overlayEntry);
  }

  static void reset() {
    AppOverlay.overlayEntries = <AppOverlayEntry>[];
  }
}
