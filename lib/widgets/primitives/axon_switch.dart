import 'package:axon_ui/widgets/axon_theme.dart';
import 'package:flutter/material.dart';

class AxonSwitch extends StatefulWidget {
  const AxonSwitch({super.key, required this.switched, required this.onSwitched, this.focusNode});

  final bool switched;
  final Function(bool value) onSwitched;
  final FocusNode? focusNode;

  @override
  State<AxonSwitch> createState() => _AxonSwitchState();
}

class _AxonSwitchState extends State<AxonSwitch> {
  bool _pressed = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final double height = AxonTheme.of(context).isMobile ? 30 : 23;
    final double width = AxonTheme.of(context).isMobile ? 60 : 45;
    final double padding = widget.switched
        ? _pressed
            ? 4
            : _hovered
                ? 3
                : 2
        : _pressed
            ? 6
            : _hovered
                ? 5
                : 4;
    const Duration duration = Duration(milliseconds: 350);
    const Curve curve = Curves.fastEaseInToSlowEaseOut;

    return FocusableActionDetector(
      focusNode: widget.focusNode,
      onShowHoverHighlight: (value) => setState(() => _hovered = value),
      child: GestureDetector(
        onTap: () => widget.onSwitched.call(!widget.switched),
        onTapDown: (details) => setState(() => _pressed = true),
        onTapUp: (details) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedContainer(
                  duration: duration,
                  curve: curve,
                  decoration: BoxDecoration(
                    color: widget.switched ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(height / 2),
                    border: Border.all(
                      color: widget.switched ? Colors.transparent : Theme.of(context).colorScheme.onBackground,
                      width: 1.25,
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: _pressed ? AxonTheme.of(context).pressedDuration : duration,
                curve: curve,
                left: widget.switched ? width - (height - padding) : padding,
                top: padding,
                bottom: padding,
                width: height - (padding * 2),
                child: AnimatedContainer(
                  duration: _pressed ? AxonTheme.of(context).pressedDuration : duration,
                  curve: curve,
                  decoration: BoxDecoration(
                    color: widget.switched ? Theme.of(context).colorScheme.background : Theme.of(context).colorScheme.onBackground,
                    borderRadius: BorderRadius.circular(25 / 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
