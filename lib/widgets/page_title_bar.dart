import 'package:flutter/material.dart';
import 'menu_icon.dart';
import 'custom_button.dart';
import 'int_center.dart';

class PageTitleBar extends StatefulWidget {
  const PageTitleBar({
    super.key,
    required this.style,
    this.onMenu,
    this.onAlwaysOnTop,
    this.onHistory,
  });

  final PageTitleBarStyle style;
  final VoidCallback? onMenu;
  final VoidCallback? onAlwaysOnTop;
  final VoidCallback? onHistory;

  @override
  State<PageTitleBar> createState() => _State();
}

class PageTitleBarStyle {
  const PageTitleBarStyle({
    required this.buttons,
    required this.titleFont,
  });

  final CustomButtonStyle buttons;
  final TextStyle titleFont;
}

class _State extends State<PageTitleBar> {
  static const _iconMinWidth = 8.0;
  static const _iconMaxWidth = 14.0;
  double _iconWidth = _iconMaxWidth;

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _Delegate(),
      children: [
        LayoutId(
            id: const _ChildId('menuButton'),
            child: CustomButton(
                style: widget.style.buttons,
                onPressed: widget.onMenu,
                onTapDown: () {
                  setState(() => _iconWidth = _iconMinWidth);
                },
                onTapUp: () {
                  setState(() => _iconWidth = _iconMaxWidth);
                },
                onTapCancel: () {
                  setState(() => _iconWidth = _iconMaxWidth);
                },
                child: IntCenter(
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      width: _iconWidth,
                      height: 11,
                      child: const MenuIcon()),
                ))),
        LayoutId(
            id: const _ChildId('title'),
            child: Text('Standard', style: widget.style.titleFont)),
        LayoutId(
          id: const _ChildId('alwaysOnTopButton'),
          child: CustomButton(
              style: widget.style.buttons,
              onPressed: widget.onAlwaysOnTop,
              child: const IntCenter(child: Text('\u{EE49}'))),
        ),
        LayoutId(
            id: const _ChildId('historyButton'),
            child: widget.onHistory == null
                ? Container()
                : CustomButton(
                    style: widget.style.buttons,
                    onPressed: widget.onHistory,
                    child: const IntCenter(child: Text('\u{e81c}')))),
      ],
    );
  }
}

class _Delegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    _ChildId id;
    double x, y;

    id = const _ChildId('menuButton');
    y = (size.height - 36) / 2;
    layoutChild(id, const BoxConstraints(maxWidth: 40, maxHeight: 36));
    positionChild(id, Offset(0, y));

    id = const _ChildId('title');
    layoutChild(id, const BoxConstraints(maxWidth: 90, maxHeight: 40));
    positionChild(id, const Offset(43, 3));

    id = const _ChildId('alwaysOnTopButton');
    y = (size.height - 32) / 2;
    layoutChild(id, const BoxConstraints(maxWidth: 32, maxHeight: 32));
    positionChild(id, Offset(136, y.floorToDouble()));

    id = const _ChildId('historyButton');
    x = size.width - 32;
    y = (size.height - 32) / 2;
    layoutChild(id, const BoxConstraints(maxWidth: 32, maxHeight: 32));
    positionChild(id, Offset(x.floorToDouble(), y.floorToDouble()));
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate that) => that is! _Delegate;
}

class _ChildId {
  const _ChildId(this.name);

  final String name;

  @override
  bool operator ==(Object that) => that is _ChildId && name == that.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => name;
}
