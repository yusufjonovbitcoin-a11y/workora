import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/design_system/app_typography.dart';

/// Rasmdagidek: kapsula shakl, oq fon, ingichka kulrang chegar, minimalist ikonlar.
class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({
    super.key,
    required this.query,
    required this.onChanged,
    this.onFilterTap,
  });

  final String query;
  final ValueChanged<String> onChanged;
  final VoidCallback? onFilterTap;

  static const Color _lightBorder = Color(0xFFE5E7EB);
  static const Color _lightIconHint = Color(0xFF9CA3AF);

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.query);
  }

  @override
  void didUpdateWidget(covariant HomeSearchBar oldWidget) {
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

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = isDark ? scheme.surface : Colors.white;
    final borderColor = isDark
        ? scheme.outline.withValues(alpha: 0.45)
        : HomeSearchBar._lightBorder;
    final muted = isDark
        ? scheme.onSurface.withValues(alpha: 0.48)
        : HomeSearchBar._lightIconHint;

    return Material(
      color: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 6.w, 12.h),
          child: Row(
            children: [
              Icon(Icons.search_rounded, size: 23.r, color: muted),
              SizedBox(width: 10.w),
              Expanded(
                child: TextField(
                  controller: _controller,
                  onChanged: widget.onChanged,
                  minLines: 1,
                  maxLines: 1,
                  cursorColor: isDark
                      ? scheme.onSurface
                      : const Color(0xFF374151),
                  style: AppTypography.body(context).copyWith(
                    fontSize: 16.sp,
                    color: isDark
                        ? scheme.onSurface
                        : const Color(0xFF374151),
                    fontWeight: FontWeight.w400,
                    height: 1.35,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: 'Ish yoki ish qidiruvchi qidirish...',
                    hintStyle: AppTypography.body(context).copyWith(
                      fontSize: 16.sp,
                      color: muted,
                      fontWeight: FontWeight.w400,
                      height: 1.35,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              IconButton(
                onPressed: widget.onFilterTap,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.all(8.r),
                constraints: BoxConstraints.tightFor(width: 40.r, height: 40.r),
                icon: Icon(Icons.tune_rounded, size: 23.r, color: muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
