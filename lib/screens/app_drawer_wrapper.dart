import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ich1/providers/app_drawer_controller.dart';

/// Wrap a page with [AppDrawerWrapper] and ChangeNotifierProvider of
/// [AppDrawerWrapperController] to add "animated" app drawer to that page.
///
/// Use [AppDrawerWrapperController.animateForward] and [AppDrawerWrapperController.animateReverse]
/// to open and close app drawer.
class AppDrawerWrapper extends StatefulWidget {
  const AppDrawerWrapper({
    Key key,
    @required this.appDrawer,
    @required this.child,
  }) : super(key: key);

  /// Main UI
  final Widget child;

  /// App drawer UI
  final Widget appDrawer;

  @override
  _AppDrawerWrapperState createState() {
    return _AppDrawerWrapperState();
  }
}

class _AppDrawerWrapperState extends State<AppDrawerWrapper>
    with SingleTickerProviderStateMixin {
  Duration duration = const Duration(milliseconds: 500);
  double screenWidth, screenHeight;

  @override
  void initState() {
    super.initState();
    context.read<AppDrawerWrapperController>().animationController =
        AnimationController(vsync: this, duration: duration);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    AppDrawerWrapperController wrapperController =
        context.watch<AppDrawerWrapperController>();

    return WillPopScope(
      onWillPop: () async {
        if (!wrapperController.isCollapsed) {
          // Not collapsed. Go to uncollapsed state
          wrapperController.animateReverse();
          return false;
        } else
          return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            widget.appDrawer,
            AnimatedPositioned(
              duration: duration,
              left: wrapperController.isCollapsed ? 0 : 0.6 * screenWidth,
              right: wrapperController.isCollapsed ? 0 : -0.6 * screenWidth,
              top: wrapperController.isCollapsed ? 0 : screenHeight * 0.1,
              bottom: wrapperController.isCollapsed ? 0 : screenHeight * 0.1,
              curve: Curves.fastOutSlowIn,
              child: InkWell(
                onTap: () {
                  if (!wrapperController.isCollapsed) {
                    // "child" tapped in collapsed state. Go to uncollapsed state.
                    wrapperController.animateReverse();
                  }
                },
                child: AbsorbPointer(
                  // Don't register taps on "child" in collapsed state
                  absorbing: !wrapperController.isCollapsed,
                  child: Container(
                    child: widget.child,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    context.read<AppDrawerWrapperController>().disposeAnimationController();
    super.dispose();
  }
}
