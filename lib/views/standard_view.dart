import 'dart:math' show min;
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/page_title_bar.dart';
import '../widgets/memory_bar.dart';
import '../widgets/main_pad.dart';
import '../widgets/history_memory_pane.dart';

class StandardView extends StatefulWidget {
  const StandardView({super.key});

  @override
  State<StandardView> createState() => _State();
}

class _State extends State<StandardView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final TextStyle resultFieldFont;
        if (constraints.maxHeight > 770) {
          resultFieldFont = AppTheme.current.resultBigFont;
        } else {
          resultFieldFont = AppTheme.current.resultFont;
        }

        final bool historyMemoryPaneShown = constraints.maxWidth > 545;

        final multiChildLayout = CustomMultiChildLayout(
          delegate: _Delegate(),
          children: [
            LayoutId(
                id: const _ChildId('pageTitleBar'),
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 36),
                    child: PageTitleBar(
                      style: AppTheme.current.pageTitleBar,
                      onMenu: () {},
                      onAlwaysOnTop: () {},
                      onHistory: historyMemoryPaneShown ? null : () {},
                    ))),
            LayoutId(
                id: const _ChildId('expressionField'),
                child: Text(
                  '12345 - 12345 =',
                  style: AppTheme.current.expressionFieldFont,
                )),
            LayoutId(
                id: const _ChildId('resultField'),
                child: SelectionArea(
                  child: Text(
                    '0',
                    style: resultFieldFont,
                  ),
                )),
            LayoutId(
                id: const _ChildId('memoryBar'),
                child: MemoryBar(
                  style: AppTheme.current.memoryButtons,
                  showShowPaneButton: !historyMemoryPaneShown,
                  // onClear: () {},
                  // onRecall: () {},
                  onPlus: () {},
                  onMinus: () {},
                  onMS: () {},
                  // onShowPane: () {},
                )),
            LayoutId(
                id: const _ChildId('mainPad'),
                child: MainPad(
                  primaryButtonStyle: AppTheme.current.primary,
                  secondaryButtonStyle: AppTheme.current.secondary,
                  plusMinusButtonStyle: AppTheme.current.plusMinus,
                  calculateButtonStyle: AppTheme.current.accented,
                  onPercent: () {},
                  onClearEntry: () {},
                  onClear: () {},
                  onBackspace: () {},
                  onInvert: () {},
                  onPower2: () {},
                  onSqrt: () {},
                  onDivide: () {},
                  onMultiply: () {},
                  onSub: () {},
                  onAdd: () {},
                  onPlusMinus: () {},
                  onComma: () {},
                  onCalculate: () {},
                  on0: () {},
                  on1: () {},
                  on2: () {},
                  on3: () {},
                  on4: () {},
                  on5: () {},
                  on6: () {},
                  on7: () {},
                  on8: () {},
                  on9: () {},
                )),
          ],
        );

        if (historyMemoryPaneShown) {
          final paneWidth = min(320.0, constraints.maxWidth / 7 * 3);
          return Row(children: [
            ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth:
                        (constraints.maxWidth - paneWidth).floorToDouble(),
                    maxHeight: constraints.maxHeight),
                child: multiChildLayout),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: paneWidth, maxHeight: constraints.maxHeight),
              child: const HistoryMemoryPane(),
            )
          ]);
        } else {
          return multiChildLayout;
        }
      },
    );
  }
}

class _Delegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    _ChildId id;
    double xPos = 0, yPos = 0;
    Size currentSize;
    BoxConstraints constraints;

    id = const _ChildId('pageTitleBar');
    constraints = BoxConstraints(maxWidth: size.width - 6, maxHeight: 36);
    currentSize = layoutChild(id, constraints);
    positionChild(id, const Offset(1, 4));
    yPos += 50;

    final part = (size.height - yPos) / 434;

    id = const _ChildId('expressionField');
    constraints = BoxConstraints(
      maxWidth: size.width,
      maxHeight: (part * 22).roundToDouble(),
    );
    currentSize = layoutChild(id, constraints);
    xPos = size.width - currentSize.width - 16;
    yPos += constraints.maxHeight - currentSize.height - 3;
    positionChild(id, Offset(xPos, yPos));

    id = const _ChildId('resultField');
    constraints = BoxConstraints(
      maxWidth: size.width,
      maxHeight: (part * 72).floorToDouble(),
    );
    currentSize = layoutChild(id, constraints);
    xPos = (size.width - currentSize.width - 10).ceilToDouble();
    yPos += 19;
    yPos = yPos.floorToDouble();
    positionChild(id, Offset(xPos, yPos));
    yPos += constraints.maxHeight.floorToDouble() - 1;

    id = const _ChildId('mainPad');
    constraints = BoxConstraints.tightFor(
      width: size.width - 2,
      height: (part * 308).floorToDouble(),
    );
    xPos = 1;
    layoutChild(id, constraints);
    yPos = size.height - constraints.maxHeight - 1;
    positionChild(id, Offset(xPos, yPos));
    yPos -= 2;

    id = const _ChildId('memoryBar');
    constraints = BoxConstraints(
      maxWidth: size.width - 2,
      maxHeight: (part * 32).ceilToDouble() - 2,
    );
    currentSize = layoutChild(id, constraints);
    xPos = 1;
    yPos -= constraints.maxHeight;
    positionChild(id, Offset(xPos, yPos));
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
