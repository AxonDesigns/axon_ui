import 'package:flutter/material.dart';

class AxonButton extends StatefulWidget {
  const AxonButton({super.key});

  @override
  State<AxonButton> createState() => _AxonButtonState();
}

class _AxonButtonState extends State<AxonButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 50),
    );
  }
}

class AxonButtonBase extends StatefulWidget {
  const AxonButtonBase({
    super.key,
    this.onPressed,
    this.inactiveBackgroundColor,
    this.hoveredBackgroundColor,
    this.pressedBackgroundColor,
    this.disabledBackgroundColor,
    this.focusedBackgroundColor,
    this.inactiveContentColor,
    this.hoveredContentColor,
    this.pressedContentColor,
    this.disabledContentColor,
    this.focusedContentColor,
    this.inactiveBorderColor,
    this.hoveredBorderColor,
    this.pressedBorderColor,
    this.disabledBorderColor,
    this.focusedBorderColor,
    this.pressedDuration = const Duration(milliseconds: 0),
    this.normalDuration = const Duration(milliseconds: 50),
    this.disabled = false,
    this.focusNode,
  });

  final Function()? onPressed;

  final Color? inactiveBackgroundColor;
  final Color? hoveredBackgroundColor;
  final Color? pressedBackgroundColor;
  final Color? disabledBackgroundColor;
  final Color? focusedBackgroundColor;
  final Color? inactiveContentColor;
  final Color? hoveredContentColor;
  final Color? pressedContentColor;
  final Color? disabledContentColor;
  final Color? focusedContentColor;
  final Color? inactiveBorderColor;
  final Color? hoveredBorderColor;
  final Color? pressedBorderColor;
  final Color? disabledBorderColor;
  final Color? focusedBorderColor;

  final Duration pressedDuration;
  final Duration normalDuration;
  final bool disabled;
  final FocusNode? focusNode;
  @override
  State<AxonButtonBase> createState() => _AxonButtonBaseState();
}

class _AxonButtonBaseState extends State<AxonButtonBase> {
  bool _pressed = false;
  bool _hovered = false;
  bool _focused = false;

  late final _colorScheme = Theme.of(context).colorScheme;
  late final _focusNode = widget.focusNode ?? FocusNode();

  late final Color _inactiveBgColor = widget.inactiveBackgroundColor ?? _colorScheme.background;
  late final Color _hoveredBgColor = widget.hoveredBackgroundColor ?? _colorScheme.background;
  late final Color _pressedBgColor = widget.pressedBackgroundColor ?? _colorScheme.background;
  late final Color _disabledBgColor = widget.disabledBackgroundColor ?? _colorScheme.background;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      focusNode: _focusNode,
      onShowFocusHighlight: (value) => setState(() => _focused = value),
      onShowHoverHighlight: (value) => setState(() => _hovered = value),
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: (details) => setState(() => _pressed = true),
        onTapUp: (details) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: _pressed ? widget.pressedDuration : widget.normalDuration,
          decoration: BoxDecoration(
            color: widget.disabled
                ? _disabledBgColor
                : _pressed
                    ? _pressedBgColor
                    : _hovered
                        ? _hoveredBgColor
                        : _inactiveBgColor,
          ),
        ),
      ),
    );
  }
}
