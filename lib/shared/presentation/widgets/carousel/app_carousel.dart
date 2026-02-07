import 'package:flutter/material.dart';

class XCarousel extends StatefulWidget {
  final List<Widget> widgets;
  final bool isAnimated;

  const XCarousel({super.key, required this.widgets, required this.isAnimated});

  @override
  State<XCarousel> createState() => _XCarouselState();
}

class _XCarouselState extends State<XCarousel> {
  late PageController _pageController;
  late int activePage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    activePage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
        itemCount: widget.widgets.length,
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            activePage = page;
          });
        },
        itemBuilder: (context, pagePosition) {
          final Widget currentItem = widget.widgets[pagePosition];
          final bool active = pagePosition == activePage;
          return widget.isAnimated
              ? Container(
                  margin: const EdgeInsets.all(10),
                  child: currentItem,
                )
              : slider(child: currentItem, active: active);
        },
      ),
    );
  }
}

AnimatedContainer slider({required Widget child, required bool active}) {
  final double margin = active ? 10 : 20;
  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    child: child,
  );
}
