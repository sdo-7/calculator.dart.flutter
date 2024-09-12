import 'package:flutter/material.dart';

enum CustomButtonScale {
  normal,
  large,
}

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.style = CustomButtonStyle.defaultStyle,
    this.scale = CustomButtonScale.normal,
    this.onPressed,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.child,
  });

  final CustomButtonStyle style;
  final CustomButtonScale scale;
  final VoidCallback? onPressed;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapCancel;
  final Widget? child;
  bool get disabled => onPressed == null;

  @override
  State<CustomButton> createState() => _State();
}

class _State extends State<CustomButton> {
  bool _isHovered = false;
  bool _isTapDown = false;

  @override
  Widget build(BuildContext context) {
    final CustomButtonStyleVariant style;
    if (widget.disabled) {
      style = widget.style.disabled;
    } else if (_isTapDown) {
      style = widget.style.pressed;
    } else if (_isHovered) {
      style = widget.style.hovered;
    } else {
      style = widget.style.idle;
    }

    final font = switch (widget.scale) {
      CustomButtonScale.large => style.largeFont!,
      CustomButtonScale.normal => style.font,
    };

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return MouseRegion(
            onHover: (event) => setState(() => _isHovered = true),
            onExit: (event) => setState(() => _isHovered = false),
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (details) {
                  setState(() => _isTapDown = true);
                  if (widget.onTapDown != null) widget.onTapDown!();
                },
                onTapCancel: () {
                  setState(() => _isTapDown = false);
                  if (widget.onTapCancel != null) widget.onTapCancel!();
                },
                onTapUp: (details) {
                  setState(() => _isTapDown = false);
                  if (widget.onTapUp != null) widget.onTapUp!();
                },
                onTap: widget.onPressed,
                child: Container(
                    decoration: ShapeDecoration(
                      color: style.color,
                      shape: style.shape,
                    ),
                    child: DefaultTextStyle(
                        style: font, child: widget.child ?? Container()))));
      },
    );
  }
}

class CustomButtonStyle {
  const CustomButtonStyle(
    this.idle,
    this.hovered,
    this.pressed,
    this.disabled,
  );

  CustomButtonStyle.fromValues({
    required Color idle,
    required Color onIdle,
    required ShapeBorder idleBorder,
    required Color hovered,
    required Color onHovered,
    required ShapeBorder hoveredBorder,
    required Color pressed,
    required Color onPressed,
    required ShapeBorder pressedBorder,
    required Color disabled,
    required Color onDisabled,
    required ShapeBorder disabledBorder,
    required TextStyle font,
    TextStyle? largeFont,
  })  : idle = CustomButtonStyleVariant(
          idle,
          onIdle,
          idleBorder,
          font.copyWith(color: font.color ?? onIdle),
          largeFont?.copyWith(color: largeFont.color ?? onIdle),
        ),
        hovered = CustomButtonStyleVariant(
          hovered,
          onHovered,
          hoveredBorder,
          font.copyWith(color: font.color ?? onHovered),
          largeFont?.copyWith(color: largeFont.color ?? onHovered),
        ),
        pressed = CustomButtonStyleVariant(
          pressed,
          onPressed,
          pressedBorder,
          font.copyWith(color: font.color ?? onPressed),
          largeFont?.copyWith(color: largeFont.color ?? onPressed),
        ),
        disabled = CustomButtonStyleVariant(
          disabled,
          onDisabled,
          disabledBorder,
          font.copyWith(color: font.color ?? onDisabled),
          largeFont?.copyWith(color: largeFont.color ?? onDisabled),
        );

  final CustomButtonStyleVariant idle;
  final CustomButtonStyleVariant hovered;
  final CustomButtonStyleVariant pressed;
  final CustomButtonStyleVariant disabled;

  CustomButtonStyle copyWith({
    Color? idle,
    Color? onIdle,
    ShapeBorder? idleBorder,
    Color? hovered,
    Color? onHovered,
    ShapeBorder? hoveredBorder,
    Color? pressed,
    Color? onPressed,
    ShapeBorder? pressedBorder,
    Color? disabled,
    Color? onDisabled,
    ShapeBorder? disabledBorder,
    TextStyle? font,
    TextStyle? largeFont,
  }) {
    return CustomButtonStyle.fromValues(
        idle: idle ?? this.idle.color,
        onIdle: onIdle ?? this.idle.onColor,
        idleBorder: idleBorder ?? this.idle.shape,
        hovered: hovered ?? this.hovered.color,
        onHovered: onHovered ?? this.hovered.onColor,
        hoveredBorder: hoveredBorder ?? this.hovered.shape,
        pressed: pressed ?? this.pressed.color,
        onPressed: onPressed ?? this.pressed.onColor,
        pressedBorder: pressedBorder ?? this.pressed.shape,
        disabled: disabled ?? this.disabled.color,
        onDisabled: onDisabled ?? this.disabled.onColor,
        disabledBorder: disabledBorder ?? this.disabled.shape,
        font: font ?? this.idle.font.copyWithoutColor(),
        largeFont: largeFont?.copyWithoutColor());
  }

  static const defaultStyle = CustomButtonStyle(
    CustomButtonStyleVariant.defaultVariant,
    CustomButtonStyleVariant.defaultVariant,
    CustomButtonStyleVariant.defaultVariant,
    CustomButtonStyleVariant.defaultVariant,
  );
}

class CustomButtonStyleVariant {
  const CustomButtonStyleVariant(
    this.color,
    this.onColor,
    this.shape,
    this.font, [
    this.largeFont,
  ]);

  final Color color;
  final Color onColor;
  final ShapeBorder shape;
  final TextStyle font;
  final TextStyle? largeFont;

  static const defaultVariant = CustomButtonStyleVariant(
    Colors.red,
    Colors.yellow,
    RoundedRectangleBorder(),
    TextStyle(),
  );
}

extension on TextStyle {
  TextStyle copyWithoutColor() {
    var copy = TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
    );

    return copy;
  }
}
