import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_harness.dart';
import 'package:islami/core/app_assets.dart';
import 'package:islami/core/data/radio_repository.dart';
import 'package:islami/core/models/radio_station.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/modules/radio/widgets/radio_station_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(RadioRepository.clearCache);

  test('the sound wave carries its stroke as attributes, not CSS', () async {
    // flutter_svg ignores <style> blocks, so a class-styled wave would
    // render as nothing on the playing card.
    final svg = await rootBundle.loadString(AppAssets.soundWave);

    expect(svg, isNot(contains('<style')));
    expect(svg, isNot(contains('class="cls-1"')));
    expect(svg, contains('stroke="#1D1D1B"'));
  });

  test('the bundled snapshot parses into stations', () {
    const body = '{"radios":[{"id":1,"name":"Radio One","url":"https://x/1"}]}';
    final stations = RadioRepository.parse(body);

    expect(stations, hasLength(1));
    expect(stations.single.id, 1);
    expect(stations.single.name, 'Radio One');
    expect(stations.single.url, 'https://x/1');
  });

  test('the line-up loads from the bundle with no network at all', () async {
    // No HTTP is available under `flutter test`, so this is the offline
    // path end to end: the list must still arrive.
    final stations = await RadioRepository.load();

    expect(stations.length, greaterThan(100));
    expect(stations.first.name, 'Radio Ibrahim Al-Akdar');
    expect(stations.every((s) => s.url.startsWith('http')), isTrue);
    expect(RadioRepository.line.value, same(stations));
  });

  testWidgets('a station card shows play, and pause while streaming',
      (tester) async {
    const station = RadioStation(
      id: 1,
      name: 'Radio One',
      url: 'https://example.test/one',
    );
    var playPauseTaps = 0;
    var muteTaps = 0;

    Widget card({
      required bool isPlaying,
      required bool isMuted,
      bool isBuffering = false,
    }) =>
        scaled(MaterialApp(
          theme: AppTheme.dark,
          home: Scaffold(
            body: RadioStationCard(
              station: station,
              isPlaying: isPlaying,
              isBuffering: isBuffering,
              isMuted: isMuted,
              onPlayPause: () => playPauseTaps++,
              onToggleMute: () => muteTaps++,
            ),
          ),
        ));

    await tester.pumpWidget(card(isPlaying: false, isMuted: false));
    await tester.pump();

    expect(find.text('Radio One'), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    expect(find.byIcon(Icons.volume_up), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.tap(find.byIcon(Icons.volume_up));
    expect(playPauseTaps, 1);
    expect(muteTaps, 1);

    await tester.pumpWidget(card(isPlaying: true, isMuted: true));
    await tester.pump();

    expect(find.byIcon(Icons.pause), findsOneWidget);
    expect(find.byIcon(Icons.volume_off), findsOneWidget);

    // While the stream opens the control becomes a spinner, so the card
    // never claims to be playing before it is.
    await tester.pumpWidget(
      card(isPlaying: false, isMuted: false, isBuffering: true),
    );
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow), findsNothing);
    expect(find.byIcon(Icons.pause), findsNothing);
  });
}
