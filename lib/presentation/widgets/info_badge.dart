import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class InfoBadge extends StatefulWidget {
  final String eventType;

  const InfoBadge({required this.eventType, Key? key}) : super(key: key);

  @override
  InfoBadgeState createState() => InfoBadgeState();
}

Map<String, String> eventTypeExplanation(BuildContext context) {
  return {
    "docking": context.l10n.dockingExplanation,
    "wetdressrehearsal": context.l10n.wetDressRehearsalExplanation,
    "eva": context.l10n.evaExplanation,
    "staticfire": context.l10n.staticFireExplanation,
  };
}

class InfoBadgeState extends State<InfoBadge> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void _showOverlay(BuildContext context) {
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5.0,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5.0),
          child: Material(
            color: Colors.transparent,
            elevation: 4.0,
            child: Container(
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                eventTypeExplanation(context)[
                        widget.eventType.toLowerCase().replaceAll(" ", "")] ??
                    "",
                style: context.theme.textTheme.titleSmall
                    ?.copyWith(color: context.theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(right: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.eventType,
                style: context.theme.textTheme.titleMedium
                    ?.copyWith(color: context.theme.colorScheme.onPrimary),
              ),
              IconButton(
                onPressed: () {
                  if (_overlayEntry != null) {
                    // If an overlay is already displayed, remove it
                    _overlayEntry!.remove();
                    _overlayEntry = null;
                  } else {
                    // Show the overlay
                    _showOverlay(context);
                  }
                },
                icon: const Icon(Icons.info, color: Colors.white),
              ),
            ],
          )),
    );
  }
}
