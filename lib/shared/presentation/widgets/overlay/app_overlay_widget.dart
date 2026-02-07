import 'package:flutter/material.dart';
import 'package:substore_app/shared/presentation/widgets/overlay/app_overlay.dart';

enum AppOverlayShowingDirection { fromBottom, fromTop }

class AppOverlayWidget extends StatefulWidget {
  final AnimationController? controller;
  final VoidCallback? onDismiss;
  final VoidCallback? onShow;
  final Duration? displayTime;
  final Curve curve;
  final bool dismissable;
  final Widget content;
  final Color? backgroundColor;
  final AppOverlayShowingDirection showingDirection;
  final bool applyOpacity;
  final bool blockExternalFlow;
  final BoxConstraints? constraints;

  const AppOverlayWidget({
    super.key,
    this.controller,
    this.onDismiss,
    this.onShow,
    this.displayTime,
    this.curve = Curves.easeOut,
    this.dismissable = false,
    this.backgroundColor,
    required this.content,
    this.showingDirection = AppOverlayShowingDirection.fromBottom,
    this.applyOpacity = true,
    this.blockExternalFlow = true,
    this.constraints,
  });

  bool get fromBottom => showingDirection == AppOverlayShowingDirection.fromBottom;
  bool get fromTop => showingDirection == AppOverlayShowingDirection.fromTop;

  static const Duration animationDuration = Duration(milliseconds: 600);

  factory AppOverlayWidget.flexible({
    AnimationController? controller,
    VoidCallback? onDismiss,
    VoidCallback? onShow,
    Duration? displayTime,
    Curve curve = Curves.easeOut,
    bool dismissable = false,
    required Widget content,
    int flex = 4,
    Color? backgroundColor,
  }) {
    return _AppOverlayFlexible(
      controller: controller,
      dismissable: dismissable,
      curve: curve,
      displayTime: displayTime,
      onDismiss: onDismiss,
      onShow: onShow,
      content: content,
      flex: flex,
      backgroundColor: backgroundColor,
    );
  }

  @override
  State<AppOverlayWidget> createState() => AppOverlayWidgetState();
}

@visibleForTesting
class AppOverlayWidgetState extends State<AppOverlayWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;
  bool dismissed = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AnimationController(vsync: this, duration: AppOverlayWidget.animationDuration);
    animation = CurvedAnimation(parent: _controller, curve: widget.curve);

    show();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> show() async {
    if (!dismissed) return;

    setState(() => dismissed = false);

    await _controller.forward();

    if (widget.onShow != null) {
      widget.onShow?.call();
    }

    if (widget.displayTime != null) {
      await Future<void>.delayed(widget.displayTime!);
      await AppOverlay.dismiss();
    }
  }

  Future<void> dismiss() async {
    if (dismissed) return;

    await _controller.reverse();

    setState(() => dismissed = true);

    if (widget.onDismiss != null) {
      widget.onDismiss?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !dismissed,
      child: BlockSemantics(
        blocking: widget.blockExternalFlow,
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (!didPop && widget.dismissable) {
              await AppOverlay.dismiss();
              if (context.mounted) return Navigator.of(context).pop();
            }
          },
          child: AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                final Offset translateFromBottomOffset = Offset(0, (1 - animation.value) * MediaQuery.of(context).size.height);
                final Offset translateFromTopOffset =
                    Offset(0, (animation.value * MediaQuery.of(context).size.height) - MediaQuery.of(context).size.height - kToolbarHeight);
                final Color animatedOpacity = Colors.grey.withValues(alpha: 0.7 * animation.value);

                return Material(
                  color: widget.applyOpacity ? animatedOpacity : Colors.transparent,
                  type: widget.blockExternalFlow ? MaterialType.canvas : MaterialType.transparency,
                  child: Column(
                    mainAxisSize: widget.blockExternalFlow ? MainAxisSize.min : MainAxisSize.max,
                    children: <Widget>[
                      if (widget.blockExternalFlow)
                        Expanded(
                          child: ExcludeSemantics(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.dismissable) {
                                  AppOverlay.dismiss();
                                }
                              },
                            ),
                          ),
                        ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: kToolbarHeight),
                          child: Transform.translate(
                            offset: widget.fromBottom ? translateFromBottomOffset : translateFromTopOffset,
                            child: Column(
                              mainAxisAlignment: widget.fromBottom ? MainAxisAlignment.end : MainAxisAlignment.start,
                              mainAxisSize: widget.blockExternalFlow ? MainAxisSize.min : MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  color: widget.backgroundColor ?? Colors.white,
                                  constraints: widget.constraints ??
                                      BoxConstraints.loose(Size(
                                        MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height - kToolbarHeight,
                                      )),
                                  child: widget.content,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class _AppOverlayFlexible extends AppOverlayWidget {
  final int flex;

  const _AppOverlayFlexible({
    super.controller,
    super.curve,
    super.dismissable,
    super.displayTime,
    super.onDismiss,
    super.onShow,
    super.backgroundColor,
    required super.content,
    required this.flex,
  });

  @override
  State<_AppOverlayFlexible> createState() => _AppOverlayFlexibleState();
}

class _AppOverlayFlexibleState extends State<_AppOverlayFlexible> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;
  bool dismissed = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AnimationController(vsync: this, duration: AppOverlayWidget.animationDuration);
    animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    show();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> show() async {
    if (!dismissed) return;

    setState(() => dismissed = false);

    await _controller.forward();

    if (widget.onShow != null) {
      widget.onShow?.call();
    }

    if (widget.displayTime != null) {
      await Future<void>.delayed(widget.displayTime!);
      await AppOverlay.dismiss();
    }
  }

  Future<void> dismiss() async {
    if (dismissed) return;

    await _controller.reverse();

    setState(() => dismissed = true);

    if (widget.onDismiss != null) {
      widget.onDismiss?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !dismissed,
      child: BlockSemantics(
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (!didPop && widget.dismissable) {
              await AppOverlay.dismiss();
              if (context.mounted) return Navigator.of(context).pop();
            }
          },
          child: AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    children: <Widget>[
                      ExcludeSemantics(
                        child: GestureDetector(
                          onTap: () {
                            if (widget.dismissable) {
                              AppOverlay.dismiss();
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey.withValues(alpha: 0.7 * animation.value),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: kToolbarHeight,
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Transform.translate(
                            offset: Offset(0, (1 - animation.value) * MediaQuery.of(context).size.height),
                            child: ColoredBox(
                              color: widget.backgroundColor ?? Colors.white,
                              child: SafeArea(
                                top: false,
                                child: widget.content,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
