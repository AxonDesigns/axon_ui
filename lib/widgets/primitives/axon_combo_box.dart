import 'dart:async';

import 'package:axon_ui/widgets/axon_theme.dart';
import 'package:axon_ui/widgets/primitives/axon_base_button.dart';
import 'package:flutter/material.dart';

class AxonComboBox<T extends dynamic> extends StatefulWidget {
  const AxonComboBox({
    super.key,
    required this.items,
    required this.value,
    required this.onSelected,
    this.placeholder,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    this.focusNode,
    this.expanded = false,
  });

  final EdgeInsetsGeometry padding;
  final FocusNode? focusNode;
  final T value;
  final void Function(T value) onSelected;
  final List<AxonComboBoxItem> items;
  final Widget? placeholder;
  final bool expanded;

  @override
  State<AxonComboBox<T>> createState() => _AxonComboBoxState<T>();
}

class _AxonComboBoxState<T extends dynamic> extends State<AxonComboBox<T>> {
  final LayerLink layerLink = LayerLink();
  final overlayKey = GlobalKey<_OverlayState>();
  OverlayEntry? entry;
  bool _overlayOpened = false;
  bool _hoveringOverlay = false;
  bool _hovered = false;
  int _selectedIndex = 0;

  late final focusNode = widget.focusNode ?? FocusNode();

  @override
  void initState() {
    _updateSelectedIndex();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AxonComboBox<T> oldWidget) {
    _updateSelectedIndex();

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final itemValues = widget.items.map((e) => e.value).toList();
    final List<Widget> itemWidgets = widget.items.map((e) => e.content).toList();

    final isValidValue = itemValues.contains(widget.value);

    itemWidgets.add(widget.placeholder ?? const SizedBox());

    final child = IndexedStack(
      sizing: StackFit.passthrough,
      index: isValidValue ? _selectedIndex : itemWidgets.length - 1,
      alignment: AlignmentDirectional.centerStart,
      children: List<Widget>.from(itemWidgets)
          .map((e) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [e],
              ))
          .toList(),
    );

    bool isExpanded = false;

    context.visitAncestorElements((element) {
      final type = element.widget.runtimeType;
      if ([Expanded, Flexible].contains(type)) {
        isExpanded = true;
      }

      if (type == Column) {
        final column = element.widget as Column;
        if (column.crossAxisAlignment == CrossAxisAlignment.stretch) {
          isExpanded = true;
        }
      }

      return false;
    });

    final button = MouseRegion(
      hitTestBehavior: HitTestBehavior.translucent,
      onEnter: (event) => _hovered = true,
      onExit: (event) => _hovered = false,
      child: AxonButtonBase(
        onPressed: () {
          if (focusNode.hasFocus) {
            _unFocus();
          } else {
            if (_overlayOpened) return;
            _focus();
          }
        },
        focusNode: focusNode,
        padding: widget.padding,
        disabled: false,
        disabledBackgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.0),
        inactiveBackgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.0),
        hoveredBackgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
        pressedBackgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.07),
        // --
        disabledBorderColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.025),
        inactiveBorderColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
        hoveredBorderColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.0),
        pressedBorderColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.0),
        // --
        disabledContentColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
        inactiveContentColor: Theme.of(context).colorScheme.onBackground,
        hoveredContentColor: Theme.of(context).colorScheme.onBackground,
        pressedContentColor: Theme.of(context).colorScheme.onBackground,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            child,
            const SizedBox(width: 22),
          ],
        ),
      ),
    );

    return Semantics(
      focusable: true,
      child: FocusScope(
        onFocusChange: (value) {
          if (value) {
            _showOverlay();
          } else {
            _dismissOverlay();
          }
          setState(() {});
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            CompositedTransformTarget(
              link: layerLink,
              child: isExpanded
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [button],
                    )
                  : button,
            ),
            Positioned(
              right: widget.padding.horizontal / 2,
              child: IgnorePointer(
                child: AnimatedRotation(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  turns: focusNode.hasFocus ? -1.5 : 0,
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 16,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _focus() {
    focusNode.requestFocus();
  }

  void _unFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _updateSelectedIndex() {
    setState(() {
      _selectedIndex = widget.items.map((e) => e.value).toList().indexOf(widget.value);
    });
  }

  void _onSelected(T value) {
    widget.onSelected(value);
    _unFocus();
    _updateSelectedIndex();
  }

  void _dismissOverlay() {
    overlayKey.currentState?.close().then((value) {
      if (!_overlayOpened) return;
      if (entry != null) {
        entry!.remove();
        entry = null;
        _overlayOpened = false;
      }
    });
  }

  void _showOverlay() {
    final overlay = Overlay.of(context, rootOverlay: true);
    final renderBox = context.findRenderObject() as RenderBox;
    final pos = renderBox.localToGlobal(Offset.zero, ancestor: Navigator.of(context).context.findRenderObject());

    if (entry != null) {
      entry!.remove();
      entry = null;
    }

    const double itemHeight = 34;
    const double itemPadding = 4;
    const double offset = 5;

    final height = (itemHeight * widget.items.length) + (itemPadding * (widget.items.length + 1)) + offset;

    final onBottom = pos.dy + (renderBox.size.height) + height >= MediaQuery.sizeOf(context).height;

    entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerDown: (event) {
                  if (_hoveringOverlay || _hovered) return;
                  _unFocus();
                },
              ),
            ),
            Positioned(
              width: layerLink.leaderSize?.width,
              child: CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                followerAnchor: onBottom ? Alignment.bottomLeft : Alignment.topLeft,
                offset: Offset(0, onBottom ? -offset : renderBox.size.height + offset),
                child: MouseRegion(
                    hitTestBehavior: HitTestBehavior.translucent,
                    onEnter: (value) => _hoveringOverlay = true,
                    onExit: (value) => _hoveringOverlay = false,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 500,
                      ),
                      child: _Overlay(
                        key: overlayKey,
                        alignment: onBottom ? Alignment.topLeft : Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.items.length,
                            itemBuilder: (context, index) {
                              final item = widget.items[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: index < widget.items.length - 1 ? itemPadding : 0,
                                ),
                                child: _ComboBoxItem(
                                  height: itemHeight,
                                  selected: _selectedIndex == index,
                                  onPressed: () => _onSelected(item.value),
                                  data: item,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(entry!);
    _overlayOpened = true;
  }
}

class _ComboBoxItem<T extends dynamic> extends StatelessWidget {
  const _ComboBoxItem({
    super.key,
    this.selected = false,
    required this.onPressed,
    required this.data,
    this.height = 35,
  });

  final bool selected;
  final Function() onPressed;
  final AxonComboBoxItem<T> data;
  final double height;

  @override
  Widget build(BuildContext context) {
    final contentColor = selected ? Theme.of(context).colorScheme.background : Theme.of(context).colorScheme.onBackground;
    return SizedBox(
      height: height,
      child: AxonButtonBase(
        disabled: false,
        onPressed: onPressed,
        disabledBackgroundColor: Colors.transparent,
        inactiveBackgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(selected ? 1 : 0.0),
        hoveredBackgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(selected ? 0.9 : 0.1),
        pressedBackgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(selected ? 0.8 : 0.15),
        disabledContentColor: contentColor,
        inactiveContentColor: contentColor,
        hoveredContentColor: contentColor,
        pressedContentColor: contentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            data.content,
          ],
        ),
      ),
    );
  }
}

class AxonComboBoxItem<T extends dynamic> {
  const AxonComboBoxItem({
    required this.child,
    this.icon,
    required this.value,
  });

  final Widget child;
  final Widget? icon;
  final T value;

  Widget get content {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [icon!, const SizedBox(width: 8), child],
      );
    } else {
      return child;
    }
  }
}

class _Overlay extends StatefulWidget {
  const _Overlay({super.key, required this.child, this.alignment = Alignment.topLeft});

  final Widget child;
  final AlignmentGeometry alignment;

  @override
  State<_Overlay> createState() => _OverlayState();
}

class _OverlayState extends State<_Overlay> {
  bool _showing = false;
  final duration = const Duration(milliseconds: 150);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _showing = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedContainer(
        duration: duration,
        curve: Curves.fastEaseInToSlowEaseOut,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(AxonTheme.of(context).borderRadius),
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(_showing ? 0.25 : 0.0),
          ),
        ),
        child: ClipRRect(
          child: AnimatedAlign(
            alignment: widget.alignment,
            heightFactor: _showing ? 1 : 0,
            duration: duration,
            curve: Curves.fastEaseInToSlowEaseOut,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Future<void> close() async {
    setState(() {
      _showing = false;
    });
    await Future.delayed(duration);
  }
}

class ComboBoxLayoutDelegate extends SingleChildLayoutDelegate {
  final Function(Size size) onLayout;

  const ComboBoxLayoutDelegate({
    required this.onLayout,
  });

  @override
  bool shouldRelayout(covariant ComboBoxLayoutDelegate oldDelegate) {
    return this != oldDelegate;
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    onLayout.call(childSize);
    return super.getPositionForChild(size, childSize);
  }
}
