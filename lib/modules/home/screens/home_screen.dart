import 'package:flutter/material.dart';

import '../../../core/data/recent_suras_store.dart';
import '../../../core/models/sura.dart';
import '../../../core/models/hadith.dart';
import '../../hadeth/screens/hadeth_tab.dart';
import '../../hadeth/screens/hadith_details_screen.dart';
import '../../../core/models/azkar_category.dart';
import '../../quran/screens/quran_tab.dart';
import '../../radio/screens/radio_tab.dart';
import '../../sebha/screens/sebha_tab.dart';
import '../../times/screens/azkar_details_screen.dart';
import '../../times/screens/times_tab.dart';
import '../../quran/screens/sura_details_screen.dart';
import '../models/home_tab.dart';
import '../widgets/app_bottom_nav_bar.dart';

/// The tabbed shell every main destination lives in.
///
/// The Qur'an tab is complete; Hadith, Sebha, Radio and Time are wired to the
/// navigation bar and get their content in later steps.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeTab _current = HomeTab.quran;

  /// Destinations the user has actually opened.
  ///
  /// `IndexedStack` builds every child, and the radio and prayer-times tabs
  /// reach for the network and the device's location as soon as they are
  /// built — so a tab is only constructed once it has been selected.
  final Set<HomeTab> _visited = <HomeTab>{HomeTab.quran};

  @override
  void initState() {
    super.initState();
    RecentSurasStore.instance.load();
  }

  void _openSura(Sura sura) {
    RecentSurasStore.instance.markOpened(sura);
    SuraDetailsScreen.open(context, sura);
  }

  void _openHadith(Hadith hadith) => HadithDetailsScreen.open(context, hadith);

  void _openAzkar(AzkarCategory category) =>
      AzkarDetailsScreen.open(context, category);

  Widget _contentFor(HomeTab tab) {
    if (!_visited.contains(tab)) return const SizedBox.shrink();
    return switch (tab) {
      HomeTab.quran => QuranTab(onSuraSelected: _openSura),
      HomeTab.hadeth => HadethTab(onHadithSelected: _openHadith),
      HomeTab.sebha => const SebhaTab(),
      HomeTab.radio => const RadioTab(),
      HomeTab.times => TimesTab(onAzkarSelected: _openAzkar),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _current.index,
        children: <Widget>[
          for (final tab in HomeTab.values) _contentFor(tab),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        current: _current,
        onSelected: (tab) => setState(() {
          _current = tab;
          _visited.add(tab);
        }),
      ),
    );
  }
}
