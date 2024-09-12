import 'package:flutter/material.dart';

class IntCenter extends StatelessWidget {
  const IntCenter({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: const _Delegate(),
      child: child,
    );
  }
}

class _Delegate extends SingleChildLayoutDelegate {
  const _Delegate();

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final out = BoxConstraints(
      minWidth: constraints.minWidth.floorToDouble(),
      maxWidth: constraints.maxWidth.floorToDouble(),
      minHeight: constraints.minHeight.floorToDouble(),
      maxHeight: constraints.maxHeight.floorToDouble(),
    );

    return out;
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final x = (size.width - childSize.width) / 2;
    final y = (size.height - childSize.height) / 2;

    return Offset(x.floorToDouble(), y.floorToDouble());
  }

  @override
  bool shouldRelayout(SingleChildLayoutDelegate that) => that is! _Delegate;
}
