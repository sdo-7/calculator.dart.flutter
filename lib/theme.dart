import 'package:flutter/material.dart';
import 'widgets/custom_button.dart';
import 'widgets/page_title_bar.dart';

class AppTheme {
  const AppTheme({
    required this.surface,
    required this.onSurface,
    required this.onSurfaceDim,
    required this.menuIconColor,
    required this.fontBase,
    required this.surfaceDefaultFont,
    required this.appTitleBarFont,
    required this.expressionFieldFont,
    required this.resultFont,
    required this.resultBigFont,
    required this.pageTitleBar,
    required this.primary,
    required this.plusMinus,
    required this.secondary,
    required this.accented,
    required this.memoryButtons,
    required this.pageBarButtons,
  });

  final Color surface;
  final Color onSurface;
  final Color onSurfaceDim;
  final Color menuIconColor;
  final TextStyle fontBase;
  final TextStyle surfaceDefaultFont;
  final TextStyle appTitleBarFont;
  final TextStyle expressionFieldFont;
  final TextStyle resultFont;
  final TextStyle resultBigFont;
  final PageTitleBarStyle pageTitleBar;
  final CustomButtonStyle primary;
  final CustomButtonStyle plusMinus;
  final CustomButtonStyle secondary;
  final CustomButtonStyle accented;
  final CustomButtonStyle memoryButtons;
  final CustomButtonStyle pageBarButtons;

  static AppTheme current = dark;

  static final AppTheme dark = AppTheme(
    surface: const Color(0xFF202020),
    onSurface: Colors.white,
    onSurfaceDim: const Color(0xFFa6a6a6),
    menuIconColor: const Color(0xFFe3e3e3),
    fontBase: _fontBase,
    surfaceDefaultFont: _fontBase.copyWith(
      color: Colors.white,
    ),
    expressionFieldFont: _fontBase.copyWith(
      fontSize: 14,
      color: const Color(0xFFA6A6A6),
      letterSpacing: 0,
      wordSpacing: -2,
    ),
    resultFont: _fontBase.copyWith(
      fontSize: 47,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    resultBigFont: _fontBase.copyWith(
      fontSize: 72,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    appTitleBarFont: _fontBase.copyWith(
      fontSize: 12,
      color: Colors.white,
    ),
    pageTitleBar: PageTitleBarStyle(
      buttons: _quaternary,
      titleFont: _fontBase.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    primary: _primary,
    plusMinus: _primary.copyWith(
        font: _fontBase.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        largeFont: _fontBase.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w400,
        )),
    secondary: CustomButtonStyle.fromValues(
      idle: const Color(0xFF323232),
      onIdle: Colors.white,
      idleBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          side: BorderSide(width: 1, color: Color(0xFF353535))),
      hovered: const Color(0xFF3c3c3c),
      onHovered: Colors.white,
      hoveredBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          side: BorderSide(width: 1, color: Color(0xFF353535))),
      pressed: const Color(0xFF323232),
      onPressed: const Color(0xFFd0d0d0),
      pressedBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          side: BorderSide(width: 1, color: Color(0xFF303030))),
      disabled: Colors.red,
      onDisabled: Colors.black,
      disabledBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          side: BorderSide(width: 1, color: Colors.yellow)),
      font: _fontBase.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      largeFont: _fontBase.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    ),
    accented: CustomButtonStyle.fromValues(
      idle: const Color(0xFF76b9ed),
      onIdle: const Color(0xFF213442),
      idleBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          side: BorderSide(width: 1, color: Color(0xFF76b9ed))),
      hovered: const Color(0xFF6da9d8),
      onHovered: const Color(0xFF1e2f3c),
      hoveredBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          side: BorderSide(width: 1, color: Color(0xFF76b9ed))),
      pressed: const Color(0xFF649ac3),
      onPressed: const Color(0xFF40627d),
      pressedBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          side: BorderSide(width: 1, color: Color(0xFF649ac3))),
      disabled: Colors.red,
      onDisabled: Colors.black,
      disabledBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          side: BorderSide(width: 1, color: Colors.yellow)),
      font: _fontBase.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      largeFont: _fontBase.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    memoryButtons: _quaternary.copyWith(
      font: _fontBase.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w100,
      ),
    ),
    pageBarButtons: _quaternary.copyWith(idle: Colors.red),
  );
}

const _borderRadius = 4.0;
const _fontBase = TextStyle(fontFamily: 'CalculatorIcons');

final _primary = CustomButtonStyle.fromValues(
  idle: const Color(0xFF3b3b3b),
  onIdle: Colors.white,
  idleBorder: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      side: BorderSide(width: 1, color: Color(0xFF353535))),
  hovered: const Color(0xFF323232),
  onHovered: Colors.white,
  hoveredBorder: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      side: BorderSide(width: 1, color: Color(0xFF353535))),
  pressed: const Color(0xFF282828),
  onPressed: const Color(0xFFcecece),
  pressedBorder: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      side: BorderSide(width: 1, color: Color(0xFF303030))),
  disabled: const Color(0xFF282828),
  onDisabled: const Color(0xFF767676),
  disabledBorder: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      side: BorderSide(width: 1, color: Color(0xFF303030))),
  font: _fontBase.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  ),
  largeFont: _fontBase.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),
);

final _quaternary = CustomButtonStyle.fromValues(
  idle: Colors.transparent,
  onIdle: Colors.white,
  idleBorder: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      side: BorderSide(style: BorderStyle.none)),
  hovered: const Color(0xFF2d2d2d),
  onHovered: Colors.white,
  hoveredBorder: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      side: BorderSide(style: BorderStyle.none)),
  pressed: const Color(0xFF292929),
  onPressed: const Color(0xFFcecece),
  pressedBorder: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      side: BorderSide(style: BorderStyle.none)),
  disabled: Colors.transparent,
  onDisabled: const Color(0xFF717171),
  disabledBorder: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      side: BorderSide(style: BorderStyle.none)),
  font: _fontBase.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w100,
  ),
);
