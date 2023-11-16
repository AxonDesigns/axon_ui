import 'package:axon_ui/widgets/axon_theme.dart';
import 'package:flutter/material.dart';

class AxonTextField extends StatefulWidget {
  const AxonTextField({
    super.key,
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
    this.restorationId,
  });

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? restorationId;

  final Function(String value)? onChanged;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final Function(PointerDownEvent value)? onTapOutside;
  final Function(String value)? onSubmitted;
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
  State<AxonTextField> createState() => _AxonTextFieldState();
}

class _AxonTextFieldState extends State<AxonTextField> {
  bool _hovered = false;
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_focusListener);
    _controller.addListener(_controllerListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    _focusNode.dispose();
    _controller.removeListener(_controllerListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(
        size: AxonTheme.of(context).iconSize,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
      )),
      child: AnimatedContainer(
        duration: AxonTheme.of(context).normalDuration,
        curve: AxonTheme.of(context).curve,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AxonTheme.of(context).borderRadius),
          border: Border.all(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(
                    _focusNode.hasFocus
                        ? 0.75
                        : _hovered
                            ? 0.5
                            : 0.25,
                  )),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            MouseRegion(
              hitTestBehavior: HitTestBehavior.translucent,
              onEnter: (event) => setState(() => _hovered = true),
              onExit: (event) => setState(() => _hovered = false),
              child: Row(
                children: [
                  if (widget.prefixBuilder != null) SizedBox(width: AxonTheme.of(context).isMobile ? widget.prefixPadding * 2 : widget.prefixPadding),
                  if (widget.prefixBuilder != null)
                    Listener(
                        onPointerUp: (event) => _focusNode.requestFocus(),
                        child: widget.prefixBuilder!.call(_controller, _hovered, _focusNode.hasFocus)!),
                  Expanded(
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _controller,
                      restorationId: widget.restorationId,
                      onChanged: widget.onChanged,
                      onSubmitted: widget.onSubmitted,
                      onEditingComplete: widget.onEditingComplete,
                      onTap: () {
                        widget.onTap?.call();
                        if (widget.selectAllOnTap) {
                          _controller.selection = TextSelection(baseOffset: 0, extentOffset: _controller.value.text.length);
                        }
                      },
                      readOnly: widget.readOnly,
                      onTapOutside: (event) {
                        if (widget.unFocusOnTapOutside && _focusNode.hasFocus) FocusScope.of(context).requestFocus(FocusNode());
                      },
                      style: widget.style ??
                          TextStyle(
                            fontSize: AxonTheme.of(context).fontSize,
                          ),
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: widget.hintStyle ??
                            TextStyle(
                              fontSize: AxonTheme.of(context).fontSize,
                              fontWeight: FontWeight.normal,
                            ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 4 + widget.padding.vertical,
                          horizontal: AxonTheme.of(context).isMobile ? widget.padding.horizontal * 2 : widget.padding.horizontal,
                        ),
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.suffixBuilder != null)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Listener(
                  behavior: HitTestBehavior.translucent,
                  onPointerUp: (event) {
                    _focusNode.requestFocus();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: AxonTheme.of(context).isMobile ? widget.suffixPadding : widget.suffixPadding / 2),
                    child: widget.suffixBuilder!.call(_controller, _hovered, _focusNode.hasFocus),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _focusListener() {
    setState(() {});
  }

  void _controllerListener() {
    setState(() {});
  }
}
