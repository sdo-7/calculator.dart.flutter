import 'package:flutter/material.dart';
import 'grid.dart';
import 'custom_button.dart';

class MainPad extends StatelessWidget {
  const MainPad({
    super.key,
    required this.primaryButtonStyle,
    required this.secondaryButtonStyle,
    required this.plusMinusButtonStyle,
    required this.calculateButtonStyle,
    this.onPercent,
    this.onClearEntry,
    this.onClear,
    this.onBackspace,
    this.onInvert,
    this.onPower2,
    this.onSqrt,
    this.onDivide,
    this.onMultiply,
    this.onSub,
    this.onAdd,
    this.onPlusMinus,
    this.onComma,
    this.onCalculate,
    this.on0,
    this.on1,
    this.on2,
    this.on3,
    this.on4,
    this.on5,
    this.on6,
    this.on7,
    this.on8,
    this.on9,
  });

  final CustomButtonStyle primaryButtonStyle;
  final CustomButtonStyle secondaryButtonStyle;
  final CustomButtonStyle plusMinusButtonStyle;
  final CustomButtonStyle calculateButtonStyle;
  final VoidCallback? onPercent;
  final VoidCallback? onClearEntry;
  final VoidCallback? onClear;
  final VoidCallback? onBackspace;
  final VoidCallback? onInvert;
  final VoidCallback? onPower2;
  final VoidCallback? onSqrt;
  final VoidCallback? onDivide;
  final VoidCallback? onMultiply;
  final VoidCallback? onSub;
  final VoidCallback? onAdd;
  final VoidCallback? onPlusMinus;
  final VoidCallback? onComma;
  final VoidCallback? onCalculate;
  final VoidCallback? on0;
  final VoidCallback? on1;
  final VoidCallback? on2;
  final VoidCallback? on3;
  final VoidCallback? on4;
  final VoidCallback? on5;
  final VoidCallback? on6;
  final VoidCallback? on7;
  final VoidCallback? on8;
  final VoidCallback? on9;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final CustomButtonScale buttonScale;
        if (constraints.maxWidth > 470 && constraints.maxHeight > 495) {
          buttonScale = CustomButtonScale.large;
        } else {
          buttonScale = CustomButtonScale.normal;
        }

        return Grid(
            direction: Axis.vertical,
            crossAxisCount: 4,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2.5,
            children: [
              CustomButton(
                  // %
                  scale: buttonScale,
                  style: secondaryButtonStyle,
                  onPressed: onPercent,
                  child: _wrapButtonChild(const Text('\u{E94C}'))),
              CustomButton(
                  // CE
                  scale: buttonScale,
                  style: secondaryButtonStyle,
                  onPressed: onClearEntry,
                  child: _wrapButtonChild(const Text('CE'))),
              CustomButton(
                  // C
                  scale: buttonScale,
                  style: secondaryButtonStyle,
                  onPressed: onClear,
                  child: _wrapButtonChild(const Text('C'))),
              CustomButton(
                  // backspace
                  scale: buttonScale,
                  style: secondaryButtonStyle,
                  onPressed: onBackspace,
                  child: _wrapButtonChild(const Text('\u{E94F}'))),
              CustomButton(
                  // 1/x
                  scale: buttonScale,
                  style: secondaryButtonStyle,
                  onPressed: onInvert,
                  child: _wrapButtonChild(const Text('\u{F7C9}'))),
              CustomButton(
                  // x power 2
                  scale: buttonScale,
                  style: secondaryButtonStyle,
                  onPressed: onPower2,
                  child: _wrapButtonChild(const Text('\u{F7C8}'))),
              CustomButton(
                  // square root of x
                  scale: buttonScale,
                  style: secondaryButtonStyle,
                  onPressed: onSqrt,
                  child: _wrapButtonChild(const Text('\u{F899}'))),
              CustomButton(
                  // division
                  scale: buttonScale,
                  style: secondaryButtonStyle,
                  onPressed: onDivide,
                  child: _wrapButtonChild(const Text('\u{E94A}'))),
              CustomButton(
                  // 7
                  scale: buttonScale,
                  style: primaryButtonStyle,
                  onPressed: on7,
                  child: _wrapButtonChild(const Text('7'))),
              CustomButton(
                  // 8
                  scale: buttonScale,
                  style: primaryButtonStyle,
                  onPressed: on8,
                  child: _wrapButtonChild(const Text('8'))),
              CustomButton(
                  // 9
                  scale: buttonScale,
                  style: primaryButtonStyle,
                  onPressed: on9,
                  child: _wrapButtonChild(const Text('9'))),
              CustomButton(
                  // multiply
                  scale: buttonScale,
                  style: secondaryButtonStyle,
                  onPressed: onMultiply,
                  child: _wrapButtonChild(const Text('\u{E947}'))),
              CustomButton(
                  // 4
                  scale: buttonScale,
                  style: primaryButtonStyle,
                  onPressed: on4,
                  child: _wrapButtonChild(const Text('4'))),
              CustomButton(
                  // 5
                  scale: buttonScale,
                  style: primaryButtonStyle,
                  onPressed: on5,
                  child: _wrapButtonChild(const Text('5'))),
              CustomButton(
                  // 6
                  scale: buttonScale,
                  style: primaryButtonStyle,
                  onPressed: on6,
                  child: _wrapButtonChild(const Text('6'))),
              CustomButton(
                  // minus
                  scale: buttonScale,
                  style: secondaryButtonStyle,
                  onPressed: onSub,
                  child: _wrapButtonChild(const Text('\u{E949}'))),
              CustomButton(
                  // 1
                  scale: buttonScale,
                  style: primaryButtonStyle,
                  onPressed: on1,
                  child: _wrapButtonChild(const Text('1'))),
              CustomButton(
                  // 2
                  scale: buttonScale,
                  style: primaryButtonStyle,
                  onPressed: on2,
                  child: _wrapButtonChild(const Text('2'))),
              CustomButton(
                  // 3
                  scale: buttonScale,
                  style: primaryButtonStyle,
                  onPressed: on3,
                  child: _wrapButtonChild(const Text('3'))),
              CustomButton(
                  // plus
                  scale: buttonScale,
                  style: secondaryButtonStyle,
                  onPressed: onAdd,
                  child: _wrapButtonChild(const Text('\u{E948}'))),
              CustomButton(
                  // +/-
                  scale: buttonScale,
                  style: plusMinusButtonStyle,
                  onPressed: onPlusMinus,
                  child: _wrapButtonChild(const Text('\u{F898}'))),
              CustomButton(
                  // 0
                  scale: buttonScale,
                  style: primaryButtonStyle,
                  onPressed: on0,
                  child: _wrapButtonChild(const Text('0'))),
              CustomButton(
                  // ,
                  scale: buttonScale,
                  style: primaryButtonStyle,
                  onPressed: onComma,
                  child: _wrapButtonChild(const Text(','))),
              CustomButton(
                  // =
                  scale: buttonScale,
                  style: calculateButtonStyle,
                  onPressed: onCalculate,
                  child: _wrapButtonChild(const Text('\u{E94E}'))),
            ]);
      },
    );
  }

  Widget _wrapButtonChild(Widget child) {
    return Center(child: child);
  }
}
