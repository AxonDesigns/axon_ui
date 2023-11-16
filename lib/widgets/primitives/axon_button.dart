import 'package:axon_ui/context_extension.dart';
import 'package:axon_ui/widgets/axon_theme.dart';
import 'package:flutter/material.dart';
import 'axon_base_button.dart';

enum AxonButtonStyle { primary, secondary, outline, ghost, link }

enum _AxonButtonState { disabled, inactive, hovered, pressed }

class AxonButton extends StatelessWidget {
  const AxonButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    this.pressedDuration = const Duration(milliseconds: 0),
    this.normalDuration = const Duration(milliseconds: 50),
    this.focusNode,
    this.style = AxonButtonStyle.ghost,
  });

  final Function()? onPressed;
  final Widget child;
  final Duration pressedDuration;
  final Duration normalDuration;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry padding;
  final AxonButtonStyle style;

  factory AxonButton.icon({
    required Function()? onPressed,
    required Widget icon,
    Duration pressedDuration = const Duration(milliseconds: 0),
    Duration normalDuration = const Duration(milliseconds: 50),
    EdgeInsetsGeometry padding = const EdgeInsets.all(7),
    FocusNode? focusNode,
    AxonButtonStyle style = AxonButtonStyle.ghost,
  }) {
    return AxonButton(
      onPressed: onPressed,
      style: style,
      focusNode: focusNode,
      normalDuration: normalDuration,
      pressedDuration: pressedDuration,
      padding: padding,
      child: icon,
    );
  }

  factory AxonButton.iconAndText({
    required Widget icon,
    required Widget text,
    required Function()? onPressed,
    Duration pressedDuration = const Duration(milliseconds: 0),
    Duration normalDuration = const Duration(milliseconds: 50),
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    FocusNode? focusNode,
    AxonButtonStyle style = AxonButtonStyle.ghost,
  }) {
    return AxonButton(
      onPressed: onPressed,
      style: style,
      focusNode: focusNode,
      normalDuration: normalDuration,
      pressedDuration: pressedDuration,
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          text,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;

    return AxonButtonBase(
      onPressed: onPressed,
      disabled: disabled,
      focusNode: focusNode,
      padding: AxonTheme.of(context).isMobile ? EdgeInsets.symmetric(horizontal: padding.horizontal, vertical: padding.vertical) : padding,
      disabledBackgroundColor: _backgroundColor(_AxonButtonState.disabled, context),
      inactiveBackgroundColor: _backgroundColor(_AxonButtonState.inactive, context),
      hoveredBackgroundColor: _backgroundColor(_AxonButtonState.hovered, context),
      pressedBackgroundColor: _backgroundColor(_AxonButtonState.pressed, context),
      disabledBorderColor: _borderColor(_AxonButtonState.disabled, context),
      inactiveBorderColor: _borderColor(_AxonButtonState.inactive, context),
      hoveredBorderColor: _borderColor(_AxonButtonState.hovered, context),
      pressedBorderColor: _borderColor(_AxonButtonState.pressed, context),
      disabledContentColor: _contentColor(_AxonButtonState.disabled, context),
      inactiveContentColor: _contentColor(_AxonButtonState.inactive, context),
      hoveredContentColor: _contentColor(_AxonButtonState.hovered, context),
      pressedContentColor: _contentColor(_AxonButtonState.pressed, context),
      showDecorationOnHover: style == AxonButtonStyle.link,
      showDecorationOnPressed: style == AxonButtonStyle.link,
      cursor: style == AxonButtonStyle.link && !disabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      borderRadius: AxonTheme.of(context).borderRadius,
      iconSize: AxonTheme.of(context).iconSize,
      fontSize: AxonTheme.of(context).fontSize,
      fontWeight: style == AxonButtonStyle.primary ? FontWeight.w600 : FontWeight.normal,
      child: child,
    );
  }

  Color _backgroundColor(_AxonButtonState state, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color inactiveGhostColor = colorScheme.onBackground.withOpacity(0.0);
    final Color hoveredGhostColor = colorScheme.onBackground.withOpacity(0.1);
    final Color pressedGhostColor = colorScheme.onBackground.withOpacity(0.07);
    final Color disabledGhostColor = colorScheme.onBackground.withOpacity(0.0);

    final Color inactiveOutlineColor = colorScheme.onBackground.withOpacity(0.0);
    final Color hoveredOutlineColor = colorScheme.onBackground.withOpacity(0.1);
    final Color pressedOutlineColor = colorScheme.onBackground.withOpacity(0.07);
    final Color disabledOutlineColor = colorScheme.onBackground.withOpacity(0.0);

    final Color inactivePrimaryColor = colorScheme.primary;
    final Color hoveredPrimaryColor =
        HSLColor.fromColor(colorScheme.primary).withLightness(context.isDarkMode ? 0.72 : 0.37).withSaturation(0.7).toColor();
    final Color pressedPrimaryColor =
        HSLColor.fromColor(colorScheme.primary).withLightness(context.isDarkMode ? 0.65 : 0.32).withSaturation(0.65).toColor();
    final Color disabledPrimaryColor = colorScheme.primary.withOpacity(0.7);

    final Color inactiveSecondaryColor = colorScheme.onBackground.withOpacity(0.15);
    final Color hoveredSecondaryColor = colorScheme.onBackground.withOpacity(0.1);
    final Color pressedSecondaryColor = colorScheme.onBackground.withOpacity(0.07);
    final Color disabledSecondaryColor = colorScheme.onBackground.withOpacity(0.05);

    switch (state) {
      case _AxonButtonState.disabled:
        return switch (style) {
          AxonButtonStyle.ghost => disabledGhostColor,
          AxonButtonStyle.outline => disabledOutlineColor,
          AxonButtonStyle.primary => disabledPrimaryColor,
          AxonButtonStyle.secondary => disabledSecondaryColor,
          AxonButtonStyle.link => Colors.transparent,
        };
      case _AxonButtonState.inactive:
        return switch (style) {
          AxonButtonStyle.ghost => inactiveGhostColor,
          AxonButtonStyle.outline => inactiveOutlineColor,
          AxonButtonStyle.primary => inactivePrimaryColor,
          AxonButtonStyle.secondary => inactiveSecondaryColor,
          AxonButtonStyle.link => Colors.transparent,
        };
      case _AxonButtonState.hovered:
        return switch (style) {
          AxonButtonStyle.ghost => hoveredGhostColor,
          AxonButtonStyle.outline => hoveredOutlineColor,
          AxonButtonStyle.primary => hoveredPrimaryColor,
          AxonButtonStyle.secondary => hoveredSecondaryColor,
          AxonButtonStyle.link => Colors.transparent,
        };
      case _AxonButtonState.pressed:
        return switch (style) {
          AxonButtonStyle.ghost => pressedGhostColor,
          AxonButtonStyle.outline => pressedOutlineColor,
          AxonButtonStyle.primary => pressedPrimaryColor,
          AxonButtonStyle.secondary => pressedSecondaryColor,
          AxonButtonStyle.link => Colors.transparent,
        };
    }
  }

  Color _borderColor(_AxonButtonState state, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color inactiveOutlineColor = colorScheme.onBackground.withOpacity(0.2);
    final Color hoveredOutlineColor = colorScheme.onBackground.withOpacity(0.0);
    final Color pressedOutlineColor = colorScheme.onBackground.withOpacity(0.0);
    final Color disabledOutlineColor = colorScheme.onBackground.withOpacity(0.1);

    switch (state) {
      case _AxonButtonState.disabled:
        return switch (style) {
          AxonButtonStyle.ghost => Colors.transparent,
          AxonButtonStyle.outline => disabledOutlineColor,
          AxonButtonStyle.primary => Colors.transparent,
          AxonButtonStyle.secondary => Colors.transparent,
          AxonButtonStyle.link => Colors.transparent,
        };
      case _AxonButtonState.inactive:
        return switch (style) {
          AxonButtonStyle.ghost => Colors.transparent,
          AxonButtonStyle.outline => inactiveOutlineColor,
          AxonButtonStyle.primary => Colors.transparent,
          AxonButtonStyle.secondary => Colors.transparent,
          AxonButtonStyle.link => Colors.transparent,
        };
      case _AxonButtonState.hovered:
        return switch (style) {
          AxonButtonStyle.ghost => Colors.transparent,
          AxonButtonStyle.outline => hoveredOutlineColor,
          AxonButtonStyle.primary => Colors.transparent,
          AxonButtonStyle.secondary => Colors.transparent,
          AxonButtonStyle.link => Colors.transparent,
        };
      case _AxonButtonState.pressed:
        return switch (style) {
          AxonButtonStyle.ghost => Colors.transparent,
          AxonButtonStyle.outline => pressedOutlineColor,
          AxonButtonStyle.primary => Colors.transparent,
          AxonButtonStyle.secondary => Colors.transparent,
          AxonButtonStyle.link => Colors.transparent,
        };
    }
  }

  Color _contentColor(_AxonButtonState state, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color inactiveGhostColor = colorScheme.onBackground;
    final Color hoveredGhostColor = colorScheme.onBackground;
    final Color pressedGhostColor = colorScheme.onBackground;
    final Color disabledGhostColor = colorScheme.onBackground.withOpacity(0.7);

    final Color inactiveOutlineColor = colorScheme.onBackground;
    final Color hoveredOutlineColor = colorScheme.onBackground;
    final Color pressedOutlineColor = colorScheme.onBackground;
    final Color disabledOutlineColor = colorScheme.onBackground.withOpacity(0.7);

    final Color inactivePrimaryColor = colorScheme.background;
    final Color hoveredPrimaryColor = colorScheme.background;
    final Color pressedPrimaryColor = colorScheme.background;
    final Color disabledPrimaryColor = colorScheme.background.withOpacity(0.7);

    final Color inactiveSecondaryColor = colorScheme.onBackground;
    final Color hoveredSecondaryColor = colorScheme.onBackground;
    final Color pressedSecondaryColor = colorScheme.onBackground;
    final Color disabledSecondaryColor = colorScheme.onBackground.withOpacity(0.7);

    switch (state) {
      case _AxonButtonState.disabled:
        return switch (style) {
          AxonButtonStyle.ghost => disabledGhostColor,
          AxonButtonStyle.outline => disabledOutlineColor,
          AxonButtonStyle.primary => disabledPrimaryColor,
          AxonButtonStyle.secondary => disabledSecondaryColor,
          AxonButtonStyle.link => colorScheme.onBackground.withOpacity(0.7),
        };
      case _AxonButtonState.inactive:
        return switch (style) {
          AxonButtonStyle.ghost => inactiveGhostColor,
          AxonButtonStyle.outline => inactiveOutlineColor,
          AxonButtonStyle.primary => inactivePrimaryColor,
          AxonButtonStyle.secondary => inactiveSecondaryColor,
          AxonButtonStyle.link => colorScheme.onBackground,
        };
      case _AxonButtonState.hovered:
        return switch (style) {
          AxonButtonStyle.ghost => hoveredGhostColor,
          AxonButtonStyle.outline => hoveredOutlineColor,
          AxonButtonStyle.primary => hoveredPrimaryColor,
          AxonButtonStyle.secondary => hoveredSecondaryColor,
          AxonButtonStyle.link => colorScheme.onBackground,
        };
      case _AxonButtonState.pressed:
        return switch (style) {
          AxonButtonStyle.ghost => pressedGhostColor,
          AxonButtonStyle.outline => pressedOutlineColor,
          AxonButtonStyle.primary => pressedPrimaryColor,
          AxonButtonStyle.secondary => pressedSecondaryColor,
          AxonButtonStyle.link => colorScheme.onBackground,
        };
    }
  }
}
