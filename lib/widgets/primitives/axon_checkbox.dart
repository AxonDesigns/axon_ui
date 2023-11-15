import 'package:axon_ui/widgets/axon_theme.dart';
import 'package:flutter/material.dart';

class AxonCheckbox extends StatefulWidget {
  const AxonCheckbox({
    super.key,
    required this.checked,
    required this.onChecked,
    this.focusNode,
  });

  final bool checked;
  final Function(bool value) onChecked;
  final FocusNode? focusNode;

  @override
  State<AxonCheckbox> createState() => _AxonCheckboxState();
}

class _AxonCheckboxState extends State<AxonCheckbox> {
  bool _pressed = false;
  bool _hovered = false;

  late final focusNode = widget.focusNode ?? FocusNode();

  @override
  Widget build(BuildContext context) {
    const Duration duration = Duration(milliseconds: 350);
    const Curve curve = Curves.fastEaseInToSlowEaseOut;

    final double sideOffset = widget.checked
        ? _pressed
            ? 5
            : _hovered
                ? 4.5
                : 4
        : _pressed
            ? 2
            : _hovered
                ? 1.5
                : 1;

    return FocusableActionDetector(
      focusNode: focusNode,
      onShowHoverHighlight: (value) => setState(() => _hovered = value),
      child: GestureDetector(
        onTap: () => widget.onChecked.call(!widget.checked),
        onTapDown: (details) => setState(() => _pressed = true),
        onTapUp: (details) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
                duration: _pressed ? AxonTheme.of(context).pressedDuration : duration,
                curve: curve,
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AxonTheme.of(context).borderRadius + (sideOffset - 1)),
                  border: Border.all(
                    color: widget.checked ? Theme.of(context).colorScheme.primary : Colors.transparent,
                    width: widget.checked
                        ? _pressed
                            ? 2
                            : _hovered
                                ? 1.65
                                : 1.25
                        : 0,
                  ),
                  color: widget.checked ? Theme.of(context).colorScheme.background : Theme.of(context).colorScheme.onBackground,
                )),
            AnimatedPositioned(
              duration: _pressed ? AxonTheme.of(context).pressedDuration : duration,
              curve: curve,
              top: sideOffset,
              left: sideOffset,
              right: sideOffset,
              bottom: sideOffset,
              child: AnimatedContainer(
                duration: duration,
                curve: curve,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AxonTheme.of(context).borderRadius - 1),
                  color: widget.checked ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.background,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
