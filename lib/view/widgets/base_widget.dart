import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({
    super.key,
    required this.children,
    this.padding = 20,
    this.bottomNavBar,
    this.crossAxisAlignment,
  });

  final List<Widget> children;
  final double padding;
  final Widget? bottomNavBar;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment:
                  crossAxisAlignment ?? CrossAxisAlignment.center,
              children: children,
            ),
          ),
        ),
        bottomNavBar ?? const SizedBox.shrink(),
      ],
    );
  }
}
