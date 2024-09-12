import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  Grid({
    super.key,
    required this.direction,
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required List<Widget> children,
  })  : assert(crossAxisCount > 0),
        children = _prepareChildren(
          direction: direction,
          mainAxisCount: _calcMainAxisCount(children, crossAxisCount),
          crossAxisCount: crossAxisCount,
          children: children,
        );

  final Axis direction;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final List<Widget> children;

  int get mainAxisCount => _calcMainAxisCount(children, crossAxisCount);

  @override
  Widget build(BuildContext context) {
    final int xCount, yCount;
    final double xSpacing, ySpacing;
    switch (direction) {
      case Axis.horizontal:
        xCount = mainAxisCount;
        xSpacing = mainAxisSpacing;
        yCount = crossAxisCount;
        ySpacing = crossAxisSpacing;
      case Axis.vertical:
        xCount = crossAxisCount;
        xSpacing = crossAxisSpacing;
        yCount = mainAxisCount;
        ySpacing = mainAxisSpacing;
    }

    return CustomMultiChildLayout(
      delegate: _Delegate(
        xCount: xCount,
        xSpacing: xSpacing,
        yCount: yCount,
        ySpacing: ySpacing,
      ),
      children: children,
    );
  }

  static List<Widget> _prepareChildren({
    required Axis direction,
    required int mainAxisCount,
    required int crossAxisCount,
    required List<Widget>? children,
  }) {
    if (children == null) return [];

    final makeId = switch (direction) {
      Axis.horizontal => (int x, int y) => _ChildId(x, y),
      Axis.vertical => (int y, int x) => _ChildId(x, y),
    };

    return List<Widget>.of(
      () sync* {
        int index = 0;
        for (int a = 0; a < mainAxisCount; ++a) {
          for (int b = 0; b < crossAxisCount; ++b) {
            final id = makeId(a, b);
            yield LayoutId(
              id: id,
              child: index >= children.length ? Container() : children[index++],
            );
          }
        }
      }(),
      growable: false,
    );
  }

  static int _calcMainAxisCount(List<Widget>? children, int crossAxisCount) {
    if (children == null) return 0;
    if (children.isEmpty) return 0;

    int count = children.length ~/ crossAxisCount;
    final int modulo = children.length % crossAxisCount;
    if (modulo != 0) ++count;

    return count;
  }
}

class _Delegate extends MultiChildLayoutDelegate {
  _Delegate({
    required this.xCount,
    required this.xSpacing,
    required this.yCount,
    required this.ySpacing,
  });

  final int xCount;
  final double xSpacing;
  final int yCount;
  final double ySpacing;

  @override
  void performLayout(Size size) {
    if (xCount == 0 || yCount == 0) return;

    final childrenTotalSize = Size(
      (size.width - xSpacing * (xCount - 1)),
      (size.height - ySpacing * (yCount - 1)),
    );
    final childFullSize = Size(
      childrenTotalSize.width / xCount,
      childrenTotalSize.height / yCount,
    );
    final childSize = Size(
      childFullSize.width,
      childFullSize.height,
    );
    final extraSize = Size(
      childFullSize.width - childSize.width,
      childFullSize.height - childSize.height,
    );

    double yPos = 0;
    double extraHeightAccumulator = 0;
    for (int y = 0; y < yCount; ++y) {
      final double height;
      if (y == yCount - 1) {
        height = size.height - yPos;
      } else if (extraHeightAccumulator > 1) {
        extraHeightAccumulator -= 1;
        height = childSize.height + 1;
      } else {
        height = childSize.height;
      }
      extraHeightAccumulator += extraSize.height * 2;

      double xPos = 0;
      double extraWidthAccumulator = 0;
      for (int x = 0; x < xCount; ++x) {
        final double width;
        if (x == xCount - 1) {
          width = size.width - xPos;
        } else if (extraWidthAccumulator > 1) {
          extraWidthAccumulator -= 1;
          width = childSize.width + 1;
        } else {
          width = childSize.width;
        }
        extraWidthAccumulator += extraSize.width;

        final id = _ChildId(x, y);
        final currentSize = layoutChild(
            id, BoxConstraints(maxWidth: width - 1, maxHeight: height - 1));

        final offset = Offset(xPos + 0.5, yPos + 0.5);
        positionChild(id, offset);

        xPos += currentSize.width + xSpacing;
      }

      yPos += ySpacing + height;
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate that) =>
      that is! _Delegate ||
      xCount != that.xCount ||
      xSpacing != that.xSpacing ||
      yCount != that.yCount ||
      ySpacing != that.ySpacing;
}

class _ChildId {
  const _ChildId(
    this.x,
    this.y,
  );

  final int x;
  final int y;

  @override
  bool operator ==(Object that) =>
      that is _ChildId && x == that.x && y == that.y;

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write('GridId ')
      ..write(x)
      ..write(':')
      ..write(y);
    return buffer.toString();
  }
}
