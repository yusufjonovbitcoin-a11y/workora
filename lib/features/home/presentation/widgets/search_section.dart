import 'package:flutter/material.dart';

import '../../../../core/design_system/app_spacing.dart';

/// Bosh sahifa (yoki boshqa ekran) uchun qayta ishlatiladigan qidiruv paneli.
///
/// — balandlik ~48px (ingichka qator)
/// — [borderRadius] 16
/// — fon: och kulrang / theme
/// — [horizontalInset] ekran chetidan masofa (odatda 16 yoki 20)
class SearchSection extends StatefulWidget {
  const SearchSection({
    super.key,
    required this.query,
    required this.onChanged,
    this.onFilterTap,
    this.horizontalInset = AppSpacing.s20,
    this.hintText = "Ish o‘rni yoki kompaniya qidiring...",
  });

  final String query;
  final ValueChanged<String> onChanged;
  final VoidCallback? onFilterTap;

  /// Ekran cheti bilan qidiruv o‘rtasidagi gorizontal masofa (px).
  final double horizontalInset;

  final String hintText;

  static const double _barHeight = 48;
  static const double _radius = 14;
  static const double _hintFontSize = 14;
  static const double _inputFontSize = 14;

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.query);
  }

  @override
  void didUpdateWidget(covariant SearchSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.query,
        selection: TextSelection.collapsed(offset: widget.query.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _fieldBackground(ThemeData theme) {
    if (theme.brightness == Brightness.dark) {
      return theme.colorScheme.surfaceContainerHighest;
    }
    return Colors.grey[100] ?? const Color(0xFFF3F4F6);
  }

  Color _borderColor(ThemeData theme) {
    return theme.colorScheme.outline.withValues(alpha: 0.45);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final onSurface = scheme.onSurface;
    final mutedIcon = onSurface.withValues(alpha: 0.5);
    final hintColor = onSurface.withValues(alpha: 0.45);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalInset),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _fieldBackground(theme),
          borderRadius: BorderRadius.circular(SearchSection._radius),
          border: Border.all(color: _borderColor(theme)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.035),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SizedBox(
          height: SearchSection._barHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  size: 20,
                  color: mutedIcon,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: widget.onChanged,
                    cursorColor: scheme.primary,
                    style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: SearchSection._inputFontSize,
                          fontWeight: FontWeight.w500,
                          height: 1.35,
                          color: onSurface,
                        ) ??
                        TextStyle(
                          fontSize: SearchSection._inputFontSize,
                          fontWeight: FontWeight.w500,
                          height: 1.35,
                          color: onSurface,
                        ),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: SearchSection._hintFontSize,
                            fontWeight: FontWeight.w400,
                            color: hintColor,
                            height: 1.35,
                          ) ??
                          TextStyle(
                            fontSize: SearchSection._hintFontSize,
                            fontWeight: FontWeight.w400,
                            color: hintColor,
                            height: 1.35,
                          ),
                      border: InputBorder.none,
                      isDense: true,
                      filled: false,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                IconButton(
                  onPressed: widget.onFilterTap,
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                  style: IconButton.styleFrom(
                    foregroundColor: mutedIcon,
                    hoverColor: scheme.primary.withValues(alpha: 0.08),
                  ),
                  icon: Icon(
                    Icons.tune_rounded,
                    size: 20,
                    color: mutedIcon,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
