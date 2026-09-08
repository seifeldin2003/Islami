import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_strings.dart';
import '../../../core/data/radio_player.dart';
import '../../../core/data/radio_repository.dart';
import '../../../core/models/radio_station.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/arabic_search.dart';
import '../../../core/widgets/app_search_field.dart';
import '../../../core/widgets/islami_header.dart';
import '../../home/widgets/scrim_backdrop.dart';
import '../widgets/radio_station_card.dart';
import '../widgets/segment_control.dart';

/// The Qur'an radio line-up.
///
/// The published list runs to well over a hundred stations, so it carries a
/// filter above it. Only the `Radio` segment has content — `Reciters` is a
/// separate feature that is not part of this build.
class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  static const int _radioSegment = 0;

  final TextEditingController _searchController = TextEditingController();
  int _segment = _radioSegment;
  String _query = '';

  @override
  void initState() {
    super.initState();
    RadioPlayer.instance.addListener(_reportFailures);
    RadioRepository.load();
  }

  @override
  void dispose() {
    RadioPlayer.instance.removeListener(_reportFailures);
    _searchController.dispose();
    super.dispose();
  }

  /// Surfaces a stream that would not open, rather than leaving the card
  /// silently stuck.
  void _reportFailures() {
    final failed = RadioPlayer.instance.failed;
    if (failed == null || !mounted) return;

    RadioPlayer.instance.acknowledgeFailure();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppStrings.radioUnavailable)),
    );
  }

  List<RadioStation> _filter(List<RadioStation> stations) {
    if (_query.trim().isEmpty) return stations;
    return stations
        .where((station) => ArabicSearch.matches(station.name, _query))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ScrimBackdrop(
          image: AppAssets.radioBackground,
          designHeight: 852.h,
        ),
        SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              const IslamiHeader(),
              SizedBox(height: 7.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: SegmentControl(
                  labels: const <String>[
                    AppStrings.segmentRadio,
                    AppStrings.segmentReciters,
                  ],
                  selectedIndex: _segment,
                  onSelected: (index) => setState(() => _segment = index),
                ),
              ),
              if (_segment == _radioSegment) ...<Widget>[
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: AppSearchField(
                    controller: _searchController,
                    hint: AppStrings.radioSearchHint,
                    onChanged: (value) => setState(() => _query = value),
                  ),
                ),
              ],
              SizedBox(height: 16.h),
              Expanded(
                child: _segment == _radioSegment
                    ? ValueListenableBuilder<List<RadioStation>>(
                        valueListenable: RadioRepository.line,
                        builder: (context, all, _) {
                          if (all.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return _StationList(stations: _filter(all));
                        },
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StationList extends StatelessWidget {
  const _StationList({required this.stations});

  final List<RadioStation> stations;

  @override
  Widget build(BuildContext context) {
    if (stations.isEmpty) {
      return Center(
        child: Text(AppStrings.noMatches, style: AppTextStyles.sectionTitle),
      );
    }

    return AnimatedBuilder(
      animation: RadioPlayer.instance,
      builder: (context, _) {
        final player = RadioPlayer.instance;
        return ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          itemCount: stations.length,
          separatorBuilder: (_, __) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final station = stations[index];
            return RadioStationCard(
              station: station,
              isPlaying: player.isPlaying(station),
              isBuffering: player.isBuffering(station),
              isMuted: player.isMuted,
              onPlayPause: () => player.toggle(station),
              onToggleMute: player.toggleMute,
            );
          },
        );
      },
    );
  }
}
