import 'package:axon_ui/widgets/axon_theme.dart';
import 'package:flutter/material.dart';

class AxonButtonBase extends StatefulWidget {
  const AxonButtonBase({
    super.key,
    required this.child,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    this.pressedDuration = const Duration(milliseconds: 0),
    this.normalDuration = const Duration(milliseconds: 50),
    this.disabled = false,
    this.focusNode,
    this.inactiveBackgroundColor,
    this.hoveredBackgroundColor,
    this.pressedBackgroundColor,
    this.disabledBackgroundColor,
    this.inactiveContentColor,
    this.hoveredContentColor,
    this.pressedContentColor,
    this.disabledContentColor,
    this.inactiveBorderColor,
    this.hoveredBorderColor,
    this.pressedBorderColor,
    this.disabledBorderColor,
    this.minHeight = 0,
    this.minWidth = 0,
    this.maxHeight = double.infinity,
    this.maxWidth = double.infinity,
    this.showDecorationOnHover = false,
    this.showDecorationOnPressed = false,
    this.cursor = SystemMouseCursors.basic,
    this.borderRadius,
    this.iconSize,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
  });

  final Color? inactiveBackgroundColor;
  final Color? hoveredBackgroundColor;
  final Color? pressedBackgroundColor;
  final Color? disabledBackgroundColor;
  final Color? inactiveContentColor;
  final Color? hoveredContentColor;
  final Color? pressedContentColor;
  final Color? disabledContentColor;
  final Color? inactiveBorderColor;
  final Color? hoveredBorderColor;
  final Color? pressedBorderColor;
  final Color? disabledBorderColor;
  final bool showDecorationOnHover;
  final bool showDecorationOnPressed;
  final double? borderRadius;
  final double? iconSize;
  final double? fontSize;

  final Widget child;
  final Function()? onPressed;
  final Duration pressedDuration;
  final Duration normalDuration;
  final bool disabled;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry padding;
  final double minHeight;
  final double minWidth;
  final double maxHeight;
  final double maxWidth;
  final MouseCursor cursor;
  final FontWeight fontWeight;

  @override
  State<AxonButtonBase> createState() => _AxonButtonBaseState();
}

class _AxonButtonBaseState extends State<AxonButtonBase> {
  bool _pressed = false;
  bool _hovered = false;
  //bool _focused = false;
  late final focusNode;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color inactiveBgColor = widget.inactiveBackgroundColor ?? colorScheme.background.withOpacity(0.0);
    final Color hoveredBgColor = widget.hoveredBackgroundColor ?? colorScheme.background.withOpacity(0.05);
    final Color pressedBgColor = widget.pressedBackgroundColor ?? colorScheme.background.withOpacity(0.1);
    final Color disabledBgColor = widget.disabledBackgroundColor ?? colorScheme.background.withOpacity(0.0);

    final Color inactiveContentColor = widget.inactiveContentColor ?? colorScheme.onBackground.withOpacity(1.0);
    final Color hoveredContentColor = widget.hoveredContentColor ?? colorScheme.onBackground.withOpacity(1.0);
    final Color pressedContentColor = widget.pressedContentColor ?? colorScheme.onBackground.withOpacity(1.0);
    final Color disabledContentColor = widget.disabledContentColor ?? colorScheme.onBackground.withOpacity(0.7);

    final Color inactiveBorderColor = widget.inactiveBorderColor ?? Colors.transparent;
    final Color hoveredBorderColor = widget.hoveredBorderColor ?? Colors.transparent;
    final Color pressedBorderColor = widget.pressedBorderColor ?? Colors.transparent;
    final Color disabledBorderColor = widget.disabledBorderColor ?? Colors.transparent;

    final bgColor = widget.disabled
        ? disabledBgColor
        : _pressed
            ? pressedBgColor
            : _hovered
                ? hoveredBgColor
                : inactiveBgColor;

    final contentColor = widget.disabled
        ? disabledContentColor
        : _pressed
            ? pressedContentColor
            : _hovered
                ? hoveredContentColor
                : inactiveContentColor;

    final borderColor = widget.disabled
        ? disabledBorderColor
        : _pressed
            ? pressedBorderColor
            : _hovered
                ? hoveredBorderColor
                : inactiveBorderColor;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: widget.minHeight,
        minWidth: widget.minWidth,
        maxHeight: widget.maxHeight,
        maxWidth: widget.maxWidth,
      ),
      child: Semantics(
        button: true,
        child: FocusableActionDetector(
          focusNode: focusNode,
          //onShowFocusHighlight: (value) => setState(() => _focused = value),
          onShowHoverHighlight: (value) => setState(() => _hovered = value),
          mouseCursor: widget.cursor,
          child: GestureDetector(
            onTap: widget.onPressed,
            onTapDown: (details) => setState(() => _pressed = true),
            onTapUp: (details) => setState(() => _pressed = false),
            onTapCancel: () => setState(() => _pressed = false),
            child: AnimatedContainer(
              duration: _pressed ? widget.pressedDuration : widget.normalDuration,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(widget.borderRadius ?? AxonTheme.of(context).borderRadius),
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  iconTheme: IconThemeData(
                    color: contentColor,
                    size: widget.iconSize ?? AxonTheme.of(context).iconSize,
                  ),
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    package: "axon_ui",
                    color: contentColor,
                    fontWeight: widget.fontWeight,
                    fontSize: widget.fontSize ?? AxonTheme.of(context).fontSize,
                    fontFamily: "GeneralSans",
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  child: Stack(
                    children: [
                      if (!widget.disabled && (_hovered && widget.showDecorationOnHover || _pressed && widget.showDecorationOnPressed))
                        Positioned(
                          bottom: (widget.padding.vertical / 2) - 1.25,
                          left: (widget.padding.vertical / 2) - 2,
                          right: (widget.padding.vertical / 2) - 2,
                          child: Container(
                            color: contentColor,
                            height: 2,
                          ),
                        ),
                      Padding(
                        padding: widget.padding,
                        child: widget.child,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
