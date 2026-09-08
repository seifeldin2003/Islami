import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_strings.dart';
import '../../../core/models/radio_station.dart';
import '../../../core/theme/app_theme.dart';

/// A gold station tile.
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
      height: 133.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 97.h,
            child: isPlaying || isBuffering
                ? SvgPicture.asset(AppAssets.soundWave, fit: BoxFit.cover)
                : Image.asset(
                    AppAssets.cardMosqueBand,
                    fit: BoxFit.cover,
                  ),
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 14.h),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    station.name,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.radioStation,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (isBuffering)
                        SizedBox(
                          width: 44.r,
                          height: 44.r,
                          child: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.background,
                            ),
                          ),
                        )
                      else
                        _CardButton(
                          icon: isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 44.r,
                          semanticLabel: station.name,
                          onTap: onPlayPause,
                        ),
                      SizedBox(width: 12.w),
                      _CardButton(
                        icon: isMuted ? Icons.volume_off : Icons.volume_up,
                        size: 30.r,
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
