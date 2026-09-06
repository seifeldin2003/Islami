import 'package:adhan/adhan.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

/// Computes the day's prayer times for the device's location.
///
/// Location is best-effort: if the user declines, or the platform has no
/// fix, the schedule falls back to [defaultCoordinates] so the screen always
/// has something to show.
class PrayerTimesService {
  const PrayerTimesService._();

  /// Cairo — used whenever a device fix is unavailable.
  static final Coordinates defaultCoordinates = Coordinates(30.0444, 31.2357);

  static Future<Coordinates> resolveCoordinates() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return defaultCoordinates;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return defaultCoordinates;
      }

      final position = await Geolocator.getCurrentPosition();
      return Coordinates(position.latitude, position.longitude);
    } catch (error) {
      debugPrint('Falling back to the default coordinates: $error');
      return defaultCoordinates;
    }
  }

  /// The schedule for [day] (defaults to today) at [coordinates].
  ///
  /// Times are produced against the device's UTC offset, so the clock on the
  /// tiles always reads in the same zone as the phone's own clock. Passing
  /// the offset explicitly rather than relying on `DateTime.toLocal()` keeps
  /// the behaviour testable and independent of the ambient zone.
  static PrayerTimes scheduleFor(
    Coordinates coordinates, {
    DateTime? day,
    Duration? utcOffset,
  }) {
    final date = day ?? DateTime.now();
    final params = CalculationMethod.egyptian.getParameters()
      ..madhab = Madhab.shafi;

    return PrayerTimes.utcOffset(
      coordinates,
      DateComponents(date.year, date.month, date.day),
      params,
      utcOffset ?? date.timeZoneOffset,
    );
  }
}
