import 'package:axon_ui/widgets/primitives/axon_text_field.dart';
import 'package:flutter/material.dart';

class AxonTextFormField extends FormField<String> {
  AxonTextFormField({
    super.key,
    super.onSaved,
    super.autovalidateMode,
    super.validator,
    super.restorationId,
    this.focusNode,
    this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.onTapOutside,
    this.onSubmitted,
    this.padding = const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
    this.style,
    this.hintStyle,
    this.hintText,
    this.suffixPadding = 0,
    this.prefixPadding = 8,
    this.readOnly = false,
    this.canBeFocused = true,
    this.selectAllOnTap = false,
    this.unFocusOnTapOutside = true,
    this.prefixBuilder,
    this.suffixBuilder,
    this.initialValue,
  }) : super(
            initialValue: controller != null ? controller.text : (initialValue ?? ''),
            builder: (FormFieldState<String> field) {
              final state = field as _AxonTextFormFieldState;

              void onChangedHandler(String value) {
                field.didChange(value);
                if (onChanged != null) {
                  onChanged(value);
                }
              }

              return UnmanagedRestorationScope(
                bucket: field.bucket,
                child: AxonTextField(
                  controller: state._effectiveController,
                  canBeFocused: canBeFocused,
                  focusNode: focusNode,
                  hintStyle: hintStyle,
                  hintText: hintText,
                  onChanged: onChangedHandler,
                  onEditingComplete: onEditingComplete,
                  onSubmitted: onSubmitted,
                  onTap: onTap,
                  onTapOutside: onTapOutside,
                  padding: padding,
                  prefixBuilder: prefixBuilder,
                  prefixPadding: prefixPadding,
                  readOnly: readOnly,
                  restorationId: restorationId,
                  selectAllOnTap: selectAllOnTap,
                  style: style,
                  suffixBuilder: suffixBuilder,
                  suffixPadding: suffixPadding,
                  unFocusOnTapOutside: unFocusOnTapOutside,
                ),
              );
            });

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final Function(PointerDownEvent value)? onTapOutside;
  final Function(String value)? onSubmitted;
  final String? initialValue;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? hintText;
  final Widget Function(TextEditingController controller, bool hovered, bool focused)? suffixBuilder;
  final Widget? Function(TextEditingController controller, bool hovered, bool focused)? prefixBuilder;
  final double suffixPadding;
  final double prefixPadding;
  final EdgeInsetsGeometry padding;
  final bool readOnly;
  final bool canBeFocused;
  final bool selectAllOnTap;
  final bool unFocusOnTapOutside;

  @override
  FormFieldState<String> createState() => _AxonTextFormFieldState();
}

class _AxonTextFormFieldState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController => _textFormField.controller ?? _controller!.value;

  AxonTextFormField get _textFormField => super.widget as AxonTextFormField;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    //

    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    if (_textFormField.controller == null) {
      _createLocalController(widget.initialValue != null ? TextEditingValue(text: widget.initialValue!) : null);
    } else {
      _textFormField.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(AxonTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_textFormField.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _textFormField.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _textFormField.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (_textFormField.controller != null) {
        setValue(_textFormField.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _textFormField.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}
