import 'package:flutter/material.dart';

import '../models/country_model.dart';
import '../models/foreign_program_model.dart';
import '../models/region_model.dart';

class ForeignJobsMockSource {
  const ForeignJobsMockSource();

  List<RegionModel> getRegions() {
    return const [
      RegionModel(title: 'Barchasi', icon: Icons.language_rounded),
      RegionModel(title: 'Osiyo', icon: Icons.terrain_rounded),
      RegionModel(title: 'Yevropa', icon: Icons.apartment_rounded),
      RegionModel(title: 'Yaqin Sharq', icon: Icons.mosque_rounded),
      RegionModel(title: 'Amerika', icon: Icons.location_city_rounded),
    ];
  }

  List<CountryModel> getCountries() {
    return const [
      CountryModel(
        name: 'Koreya',
        jobs: '1200+ ish',
        flag: 'рџ‡°рџ‡·',
        tag: 'Eng mashhur',
      ),
      CountryModel(
        name: 'Germaniya',
        jobs: '850+ ish',
        flag: 'рџ‡©рџ‡Є',
        tag: 'Yevropa',
      ),
      CountryModel(
        name: 'Turkiya',
        jobs: '950+ ish',
        flag: 'рџ‡№рџ‡·',
        tag: 'Yaqin Sharq',
      ),
      CountryModel(
        name: 'BAA',
        jobs: '600+ ish',
        flag: 'рџ‡¦рџ‡Є',
        tag: 'Yaqin Sharq',
      ),
    ];
  }

  List<ForeignProgramModel> getPrograms() {
    return const [
      ForeignProgramModel(
        title: 'Dubai вЂ” Mehmonxona xodimi',
        country: 'Birlashgan Arab Amirliklari',
        salary: '\$1000 - \$1500',
        time: '2 yil',
        housing: 'Yotoqxona bor',
        emoji: 'рџЏ™пёЏ',
      ),
      ForeignProgramModel(
        title: 'Koreya вЂ” Zavod ishchisi',
        country: 'Koreya',
        salary: '\$1200 - \$1800',
        time: '3 yil',
        housing: 'Yotoqxona bor',
        emoji: 'рџЏ­',
      ),
      ForeignProgramModel(
        title: 'Germaniya вЂ” Ombor xodimi',
        country: 'Germaniya',
        salary: '\$1800 - \$2500',
        time: '1 yil',
        housing: 'Yordam bor',
        emoji: 'рџ“¦',
      ),
    ];
  }
}
