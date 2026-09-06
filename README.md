# Islami — setup

This was hand-scaffolded (no Flutter SDK in this sandbox), so a couple of one-time steps before it runs:

1. **Generate platform folders.** From inside `islami/`, run:
   ```
   flutter create .
   ```
   This fills in `android/`, `ios/`, etc. without touching `lib/` or the deps already in `pubspec.yaml`.

2. **Export 2 images from Figma** (network to figma.com is blocked in this sandbox, so these need to come from you):
   - Node `11:63` ("Mosque-01 1") → export as PNG @2x → save as `assets/images/mosque_header.png`
   - Node `1478:30` (the calligraphy illustration frame) → export as PNG @2x → save as `assets/images/intro_1_illustration.png`

   In Figma: select the layer → right panel → Export → PNG, 2x → Export.

3. (Optional, for exact typography) Add the two custom fonts used in the design and uncomment the `fonts:` block in `pubspec.yaml`:
   - `Kamali-Regular.ttf` → `assets/fonts/`
   - `JannaLT-Bold.ttf` → `assets/fonts/`
   Without these, the app runs fine and just falls back to the system font.

4. `flutter pub get && flutter run`

## Status
- Screen 1 of 5 (Intro/onboarding) implemented: `lib/screens/intro/intro_screen.dart`.
- Screens 2–5: select each frame in the Figma desktop app and ask me to pull it — I'll add each to `lib/screens/intro/intro_page_data.dart`.
