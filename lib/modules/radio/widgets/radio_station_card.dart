import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_dimens.dart';
import '../../../core/app_strings.dart';
import '../../../core/models/radio_station.dart';
import '../../../core/theme/app_theme.dart';

/// Figma `Rectangle 132` (node 103:403): a gold station tile.
///
/// While the station is streaming the mosque band is replaced by the sound
/// wave and the play control becomes a pause.
class RadioStationCard extends StatelessWidget {
  const RadioStationCard({
    super.key,
    required this.station,
    required this.isPlaying,
    required this.isBuffering,
    required this.isMuted,
    required this.onPlayPause,
    required this.onToggleMute,
  });

  final RadioStation station;
  final bool isPlaying;
  final bool isBuffering;
  final bool isMuted;
  final VoidCallback onPlayPause;
  final VoidCallback onToggleMute;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.radioCardHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(AppDimens.radioCardRadius),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: AppDimens.radioCardBandHeight,
            child: isPlaying || isBuffering
                ? SvgPicture.asset(AppAssets.soundWave, fit: BoxFit.cover)
                : Image.asset(
                    AppAssets.cardMosqueBand,
                    fit: BoxFit.cover,
                  ),
          ),
          Column(
            children: <Widget>[
              const SizedBox(height: AppDimens.radioCardNameTop),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.radioCardNameInset,
                ),
                child: Text(
                station.name,
                textAlign: TextAlign.center,
                style: AppTextStyles.radioStation,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (isBuffering)
                        const SizedBox(
                          width: AppDimens.radioIconSize,
                          height: AppDimens.radioIconSize,
                          child: Padding(
                            padding: EdgeInsets.all(AppDimens.radioIconGap),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.background,
                            ),
                          ),
                        )
                      else
                        _CardButton(
                          icon: isPlaying ? Icons.pause : Icons.play_arrow,
                          size: AppDimens.radioIconSize,
                          semanticLabel: station.name,
                          onTap: onPlayPause,
                        ),
                      const SizedBox(width: AppDimens.radioIconGap),
                      _CardButton(
                        icon: isMuted ? Icons.volume_off : Icons.volume_up,
                        size: AppDimens.radioVolumeIconSize,
                        semanticLabel: AppStrings.volume,
                        onTap: onToggleMute,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardButton extends StatelessWidget {
  const _CardButton({
    required this.icon,
    required this.size,
    required this.semanticLabel,
    required this.onTap,
  });

  final IconData icon;
  final double size;
  final String semanticLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Icon(
        icon,
        size: size,
        color: AppColors.background,
        semanticLabel: semanticLabel,
      ),
    );
  }
}
