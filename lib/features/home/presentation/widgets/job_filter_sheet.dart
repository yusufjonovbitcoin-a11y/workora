import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/home_job_filters.dart';

/// Bottom sheet UI provided by design; state is synced with [HomeJobFilters].
class JobFilterSheet extends StatefulWidget {
  const JobFilterSheet({
    super.key,
    required this.initial,
    required this.onApply,
    required this.computeCount,
  });

  final HomeJobFilters initial;
  final ValueChanged<HomeJobFilters> onApply;
  final int Function(HomeJobFilters draft) computeCount;

  @override
  State<JobFilterSheet> createState() => _JobFilterSheetState();
}

class _JobFilterSheetState extends State<JobFilterSheet> {
  late final TextEditingController categoryController;
  late final TextEditingController locationController;

  late List<String> categories;

  late String selectedJobType;
  late String selectedExperience;
  late RangeValues salaryRange;

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController();
    locationController =
        TextEditingController(text: widget.initial.locationQuery);
    categories = List<String>.from(widget.initial.categories);
    selectedJobType = widget.initial.jobType;
    selectedExperience = widget.initial.experience;
    salaryRange = RangeValues(
      widget.initial.salaryMin,
      widget.initial.salaryMax,
    );
  }

  @override
  void dispose() {
    categoryController.dispose();
    locationController.dispose();
    super.dispose();
  }

  HomeJobFilters _draft() {
    return HomeJobFilters(
      categories: List<String>.from(categories),
      jobType: selectedJobType,
      locationQuery: locationController.text.trim(),
      salaryMin: salaryRange.start,
      salaryMax: salaryRange.end,
      experience: selectedExperience,
      sortNewestFirst: widget.initial.sortNewestFirst,
    );
  }

  void addCategory(String value) {
    final text = value.trim();
    if (text.isEmpty) return;

    if (!categories.contains(text)) {
      setState(() => categories.add(text));
    }

    categoryController.clear();
  }

  void _clear() {
    final cleared = HomeJobFilters.initial();
    setState(() {
      categories = List<String>.from(cleared.categories);
      selectedJobType = cleared.jobType;
      selectedExperience = cleared.experience;
      salaryRange = RangeValues(cleared.salaryMin, cleared.salaryMax);
      categoryController.clear();
      locationController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final matchCount = widget.computeCount(_draft());

    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.5,
      maxChildSize: 0.96,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          decoration: const BoxDecoration(
            color: Color(0xFFFDFDFD),
            borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 54,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1D5DB),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  const Text(
                    'Filtrlar',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _clear,
                    child: const Text(
                      'Tozalash',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              filterTitle(
                icon: Icons.work_outline_rounded,
                title: 'Kategoriyalar',
                subtitle: 'Qo‘l bilan yozib, Enter bosing',
                expanded: true,
              ),

              const SizedBox(height: 12),

              categoryInput(),

              const SizedBox(height: 26),

              filterTitle(
                icon: Icons.business_center_outlined,
                title: 'Ish turi',
                expanded: true,
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  choiceChip('Barchasi', selectedJobType),
                  choiceChip('To‘liq vaqt', selectedJobType),
                  choiceChip('Qisman vaqt', selectedJobType),
                  choiceChip('Stajirovka', selectedJobType),
                  choiceChip('Freelance', selectedJobType),
                ],
              ),

              const SizedBox(height: 26),

              filterTitle(
                icon: Icons.location_on_outlined,
                title: 'Manzil',
                expanded: true,
              ),

              const SizedBox(height: 12),

              locationInput(),

              const SizedBox(height: 26),

              filterTitle(
                icon: Icons.attach_money_rounded,
                title: 'Maosh oralig‘i',
                expanded: false,
              ),

              Row(
                children: const [
                  Text('\$200'),
                  Spacer(),
                  Text('\$5000+'),
                ],
              ),

              RangeSlider(
                min: 200,
                max: 5000,
                values: salaryRange,
                activeColor: AppColors.primary,
                inactiveColor: const Color(0xFFE5E7EB),
                onChanged: (value) {
                  setState(() => salaryRange = value);
                },
              ),

              const SizedBox(height: 18),

              filterTitle(
                icon: Icons.bar_chart_rounded,
                title: 'Tajriba darajasi',
                expanded: false,
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 12,
                children: [
                  experienceChip('Boshlang‘ich'),
                  experienceChip('O‘rta'),
                  experienceChip('Yuqori'),
                  experienceChip('Ekspert'),
                ],
              ),

              const SizedBox(height: 26),

              filterTitle(
                icon: Icons.swap_vert_rounded,
                title: 'Saralash',
                expanded: true,
              ),

              const SizedBox(height: 12),

              inputTile(
                text: 'Eng yangilari',
                icon: Icons.keyboard_arrow_down_rounded,
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 64,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => widget.onApply(_draft()),
                  child: Text(
                    'Natijalarni ko‘rish  ($matchCount)',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget locationInput() {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 14,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: Color(0xFF667085)),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: locationController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Shahar yoki mamlakat',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color(0xFF667085),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: const TextStyle(
                color: Color(0xFF101828),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFF667085)),
        ],
      ),
    );
  }

  Widget categoryInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.lock_outline, color: Color(0xFF111827)),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: categoryController,
                  onSubmitted: addCategory,
                  decoration: const InputDecoration(
                    hintText: 'Kategoriya yozing va Enter bosing...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => addCategory(categoryController.text),
                icon: Icon(Icons.add, color: AppColors.primary),
              ),
            ],
          ),

          const Divider(),

          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: categories.map((item) {
                return Chip(
                  label: Text(item),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  onDeleted: () {
                    setState(() => categories.remove(item));
                  },
                  backgroundColor: const Color(0xFFE6F7F0),
                  labelStyle: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget filterTitle({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool expanded,
  }) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFE6F7F0),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF667085),
                  fontSize: 14,
                ),
              ),
          ],
        ),
        const Spacer(),
        Icon(
          expanded
              ? Icons.keyboard_arrow_up_rounded
              : Icons.keyboard_arrow_down_rounded,
        ),
      ],
    );
  }

  Widget choiceChip(String text, String selected) {
    final active = text == selected;

    return GestureDetector(
      onTap: () {
        setState(() => selectedJobType = text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFE6F7F0) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? AppColors.primary : const Color(0xFF111827),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget experienceChip(String text) {
    final active = selectedExperience == text;

    return GestureDetector(
      onTap: () {
        setState(() => selectedExperience = text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFE6F7F0) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? AppColors.primary : const Color(0xFF111827),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget inputTile({
    required IconData icon,
    required String text,
  }) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 14,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF667085)),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF667085),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}
