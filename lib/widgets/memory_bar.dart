import 'dart:math' show min;
import 'package:flutter/material.dart';
import 'custom_button.dart';
import 'int_center.dart';

class MemoryBar extends StatefulWidget {
  const MemoryBar({
    super.key,
    required this.style,
    required this.showShowPaneButton,
    this.onClear,
    this.onRecall,
    this.onPlus,
    this.onMinus,
    this.onMS,
    this.onShowPane,
  });

  final CustomButtonStyle style;
  final bool showShowPaneButton;
  final VoidCallback? onClear;
  final VoidCallback? onRecall;
  final VoidCallback? onPlus;
  final VoidCallback? onMinus;
  final VoidCallback? onMS;
  final VoidCallback? onShowPane;

  @override
  State<MemoryBar> createState() => _State();
}

class _State extends State<MemoryBar> {
  @override
  Widget build(BuildContext context) {
    final children = List<Widget>.from(() sync* {
      yield* [
        LayoutId(
            id: const _ChildId(0),
            child: CustomButton(
                // MC
                style: widget.style,
                onPressed: widget.onClear,
                child: _wrapButtonChild(const Text('\u{F754}')))),
        LayoutId(
            id: const _ChildId(1),
            child: CustomButton(
                // MR
                style: widget.style,
                onPressed: widget.onRecall,
                child: _wrapButtonChild(const Text('\u{F755}')))),
        LayoutId(
            id: const _ChildId(2),
            child: CustomButton(
                // M+
                style: widget.style,
                onPressed: widget.onPlus,
                child: _wrapButtonChild(const Text('\u{F757}')))),
        LayoutId(
            id: const _ChildId(3),
            child: CustomButton(
                // M-
                style: widget.style,
                onPressed: widget.onMinus,
                child: _wrapButtonChild(const Text('\u{F758}')))),
        LayoutId(
            id: const _ChildId(4),
            child: CustomButton(
                // MS
                style: widget.style,
                onPressed: widget.onMS,
                child: _wrapButtonChild(const Text('\u{F756}')))),
      ];

      if (!widget.showShowPaneButton) return;

      yield LayoutId(
          id: const _ChildId(5),
          child: CustomButton(
              // M with down arrow
              style: widget.style,
              onPressed: widget.onShowPane,
              child: _wrapButtonChild(const Text('\u{E61D}'))));
    }(), growable: false);
    return CustomMultiChildLayout(
      delegate: _Delegate(spacing: 2, maxWidth: 78),
      children: children,
    );
  }

  Widget _wrapButtonChild(Widget child) {
    return Container(
      transform: Matrix4.identity()..translate(0.0, 1.0, 0.0),
      child: IntCenter(child: child),
    );
  }
}

class _Delegate extends MultiChildLayoutDelegate {
  _Delegate({
    required this.spacing,
    required this.maxWidth,
  });

  static const count = 6;
  final double spacing;
  final double maxWidth;

  @override
  void performLayout(Size size) {
    final double totalChildrenWidth = size.width - spacing * (count - 1);
    final childFullWidth = min(totalChildrenWidth / count, maxWidth);
    final childWidth = childFullWidth.floorToDouble();
    final extra = childFullWidth - childWidth;

    double x = 0;
    double extraAccumulator = 0;
    for (int i = 0; i < count - 1; ++i) {
      final double width;
      if (extraAccumulator > 1) {
        extraAccumulator -= 1;
        width = childWidth + 1;
      } else {
        width = childWidth;
      }
      extraAccumulator += extra;

      final id = _ChildId(i);
      final currentSize = layoutChild(
          id, BoxConstraints(maxWidth: width, maxHeight: size.height));

      positionChild(id, Offset(x, 0));

      x += currentSize.width + spacing;
    }

    const id = _ChildId(count - 1);
    if (!hasChild(id)) return;

    final currentSize = layoutChild(
        id,
        BoxConstraints(
          maxWidth: min(maxWidth, size.width.floorToDouble() - x),
          maxHeight: size.height,
        ));
    positionChild(
        id, Offset(size.width.floorToDouble() - currentSize.width, 0));
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate that) =>
      that is! _Delegate ||
      spacing != that.spacing ||
      maxWidth != that.maxWidth;
}

class _ChildId {
  const _ChildId(
    this.x,
  );

  final int x;

  @override
  bool operator ==(Object that) => that is _ChildId && x == that.x;

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    final buffer = StringBuffer()..write(x);
    return buffer.toString();
  }
}
