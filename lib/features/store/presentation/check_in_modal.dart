import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:substore_app/shared/app_colors/colors.dart';
import 'package:substore_app/shared/app_strings/app_strings.dart';
import 'package:substore_app/shared/presentation/widgets/buttons/app_buttons.dart';
import 'package:substore_app/shared/presentation/widgets/text_field/text_field.dart';
import 'package:substore_app/shared/typography/typography.dart';

typedef CheckInModalCallback = void Function(String checkInData);

class CheckInModal extends StatefulWidget {
  final CheckInModalCallback onCheckInDataScanned;

  const CheckInModal({required this.onCheckInDataScanned, super.key});

  @override
  State<CheckInModal> createState() => _CheckInModalState();

  static void show(
    BuildContext context,
    CheckInModalCallback onCheckInDataScanned,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CheckInModal(onCheckInDataScanned: onCheckInDataScanned);
      },
    );
  }
}

class _CheckInModalState extends State<CheckInModal> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  bool inputManually = kDebugMode;
  TextEditingController checkInDataController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final safeBottomInsets = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      height: MediaQuery.of(context).size.height / 2 + safeBottomInsets,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32).copyWith(
          top: 32,
          bottom: safeBottomInsets + 32,
        ),
        child: Column(
          children: [
            Expanded(
              child: !inputManually
                  ? MobileScanner(
                      controller: controller,
                      onDetect: (capture) {
                        widget.onCheckInDataScanned(
                          capture.barcodes[0].rawValue!,
                        );
                        AppRoutes.pop(context);
                      },
                    )
                  : Column(
                      children: [
                        XTextField(
                          controller: checkInDataController,
                          width: MediaQuery.of(context).size.width,
                          labelText: AppStrings.store.checkInCode,
                          fillColor: XColors.textFieldBackground[20],
                          onChanged: (_) {
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          'assets/images/qr_sample.png',
                          height: MediaQuery.of(context).size.height / 5.5,
                        ),
                        XTypography.headingRegular(
                          checkInDataController.text,
                          fontSize: 14,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                XPrimaryButton(
                  !inputManually ? AppStrings.store.insertCode : AppStrings.store.scanCode,
                  onPressed: () {
                    setState(() {
                      inputManually = !inputManually;
                    });
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  foregroundColor: const Color(0xFF1C1C1C),
                  textColor: const Color(0xFF1C1C1C),
                  backgroundColor: Colors.transparent,
                ),
                if (inputManually) ...[
                  const SizedBox(width: 12),
                  XPrimaryButton(
                    AppStrings.store.send,
                    onPressed: () {
                      if (checkInDataController.text.isNotEmpty) {
                        widget.onCheckInDataScanned(checkInDataController.text);
                        AppRoutes.pop(context);
                      }
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
