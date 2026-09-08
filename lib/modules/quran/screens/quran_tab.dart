import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_strings.dart';
import '../../../core/data/recent_suras_store.dart';
import '../../../core/data/suras_data.dart';
import '../../../core/models/sura.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/arabic_search.dart';
import '../../../core/app_assets.dart';
import '../../../core/widgets/islami_header.dart';
import '../../home/widgets/scrim_backdrop.dart';
import '../widgets/recent_sura_card.dart';
import '../widgets/sura_row.dart';
import '../../../core/widgets/app_search_field.dart';

/// The Qur'an destination: header, search, "Most Recently" carousel and
/// the full sura list.
class QuranTab extends StatefulWidget {
  const QuranTab({super.key, required this.onSuraSelected});

  final ValueChanged<Sura> onSuraSelected;

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  bool get _isSearching => _query.trim().isNotEmpty;

  List<Sura> get _results {
    if (!_isSearching) return SurasData.all;
    return SurasData.all
        .where((sura) =>
            ArabicSearch.matches(sura.englishName, _query) ||
            ArabicSearch.matches(sura.arabicName, _query))
        .toList(growable: false);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;

    return Stack(
      children: <Widget>[
        ScrimBackdrop(
          image: AppAssets.homeBackground,
          designHeight: 862.h,
        ),
        _buildList(context, results),
      ],
    );
  }

  Widget _buildList(BuildContext context, List<Sura> results) {
    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Center(child: IslamiHeader()),
              SizedBox(height: 21.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: AppSearchField(
                  controller: _searchController,
                  hint: AppStrings.searchHint,
                  onChanged: (value) => setState(() => _query = value),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
        if (!_isSearching) ...<Widget>[
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: RecentSurasStore.instance,
              builder: (context, _) {
                final recents = RecentSurasStore.instance.recents;
                if (recents.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const _SectionTitle(AppStrings.mostRecently),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 150.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        itemCount: recents.length,
                        separatorBuilder: (_, __) => SizedBox(width: 10.w),
                        itemBuilder: (context, index) => RecentSuraCard(
                          sura: recents[index],
                          onTap: () => widget.onSuraSelected(recents[index]),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: _SectionTitle(AppStrings.surasList)),
          SliverToBoxAdapter(
            child: SizedBox(height: 10.h),
          ),
        ],
        if (results.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                AppStrings.noMatches,
                style: AppTextStyles.sectionTitle,
              ),
            ),
          ),
        SliverList.separated(
          itemCount: results.length,
          separatorBuilder: (_, __) => const SuraRowDivider(),
          itemBuilder: (context, index) => SuraRow(
            sura: results[index],
            onTap: () => widget.onSuraSelected(results[index]),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 21.w,
      ),
      child: Text(label, style: AppTextStyles.sectionTitle),
    );
  }
}
