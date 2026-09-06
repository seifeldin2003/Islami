import 'dart:async' show unawaited;
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../models/radio_station.dart';

/// Owns the single audio stream the radio screen plays through.
///
/// The underlying [AudioPlayer] is created lazily so that merely reading
/// this store — in a widget test, say — never reaches the platform.
class RadioPlayer extends ChangeNotifier {
  RadioPlayer._();

  static final RadioPlayer instance = RadioPlayer._();

  AudioPlayer? _audio;
  RadioStation? _current;
  bool _isPlaying = false;
  bool _isBuffering = false;
  bool _isMuted = false;
  RadioStation? _failed;

  RadioStation? get current => _current;
  bool get isMuted => _isMuted;

  /// Whether [station] is the one currently streaming.
  bool isPlaying(RadioStation station) => _current == station && _isPlaying;

  /// Whether [station] is still opening its stream.
  bool isBuffering(RadioStation station) =>
      _current == station && _isBuffering;

  /// The station that last refused to open, if any.
  RadioStation? get failed => _failed;

  /// Clears the failure once it has been shown.
  void acknowledgeFailure() {
    _failed = null;
  }

  AudioPlayer get _player {
    final existing = _audio;
    if (existing != null) return existing;

    final created = AudioPlayer();
    created.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      _isBuffering = state.processingState == ProcessingState.loading ||
          state.processingState == ProcessingState.buffering;
      notifyListeners();
    });
    return _audio = created;
  }

  /// Starts [station], or pauses/resumes it when it is already selected.
  Future<void> toggle(RadioStation station) async {
    if (_current == station) {
      if (_isPlaying) {
        await _player.pause();
      } else {
        unawaited(_player.play());
      }
      return;
    }

    _current = station;
    _isBuffering = true;
    _failed = null;
    notifyListeners();

    try {
      await _player.setUrl(station.url);
      unawaited(_player.play());
    } catch (error) {
      debugPrint('Could not open ${station.name}: $error');
      _current = null;
      _isPlaying = false;
      _isBuffering = false;
      _failed = station;
      notifyListeners();
    }
  }

  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    notifyListeners();
    await _player.setVolume(_isMuted ? 0 : 1);
  }

  @override
  void dispose() {
    _audio?.dispose();
    super.dispose();
  }
}
