import 'package:flutter/material.dart';

import '../../domain/entities/country_entity.dart';
import 'country_card.dart';

class CountryList extends StatelessWidget {
  const CountryList({super.key, required this.countries});

  final List<CountryEntity> countries;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 172,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: countries.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          return CountryCard(country: countries[index]);
        },
      ),
    );
  }
}
