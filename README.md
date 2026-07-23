# Package of the Day 📦

<img src="screenshots/badges/built-with-love.svg" height="28px"/>&nbsp;&nbsp;
<img src="screenshots/badges/flutter-dart.svg" height="28px" />&nbsp;&nbsp;
<a href="https://choosealicense.com/licenses/mit/" target="_blank"><img src="screenshots/badges/license-MIT.svg" height="28px" /></a>&nbsp;&nbsp;
<img src="screenshots/badges/Flutter-3.svg" height="28px" />&nbsp;&nbsp;
<img src="screenshots/badges/dart-null_safety-blue.svg" height="28px"/>

A Flutter practice project focused on mastering popular packages through hands-on implementation and real-world UI examples.

This project is built to strengthen Flutter development skills by exploring one package at a time with practical, working code samples.

---

## 📖 About the Project

**Package of the Day** is a learning-focused Flutter project where essential and advanced packages are explored through practical implementations.  
Instead of just reading documentation, this project focuses on *learning by building*.

The goal is to understand how Flutter packages work, when to use them, and how to integrate them effectively into real applications.

🎯 Perfect for:
- Flutter developers learning new packages
- Quick reference for package implementation
- Hands-on practice with popular pub.dev packages
- Building a personal package knowledge library

---

## 📦 Packages Covered

### Day 01. Avatar Glow
- Animated glowing ring effect around widgets
- Perfect for profile pictures & live indicators
- Call buttons and active status badges
- Package: `avatar_glow: ^3.0.1`
- Features: Customizable glow color, duration, and repeat patterns

### Day 02. Google Fonts
- Instant access to 1500+ fonts from [fonts.google.com](https://fonts.google.com) — no manual downloads, no pubspec asset setup
- Great for fast typography experiments, branding, and UI polish
- Includes a **live preview** with an interactive font-size slider and bold toggle, so anyone opening the app can see the effect of typography changes in real time
- Package: `google_fonts: ^8.2.0`
- Features: custom font weight, style, and size support; caches fonts locally after first load for offline use

### Day 03. Liquid Pull to Refresh
- Replaces the default refresh spinner with a fun, animated **liquid-fill** effect
- Great for adding personality to list-based screens (feeds, dashboards, inboxes)
- Includes a **live refresh counter** and **last-refreshed timestamp**, so the effect of pulling to refresh is visible, not just decorative
- Package: `liquid_pull_to_refresh: ^3.0.1`
- Features: customizable liquid color, background color, height, and animation speed

### Day 04. Percent Indicator
- Animated **circular** and **linear** progress indicators for stats, downloads, and onboarding screens
- Includes a **live, draggable slider** that updates the circular indicator in real time — not just a static hardcoded percentage
- A "Quick Stats" section shows several linear bars at once (storage, battery, downloads), styled as clean white cards
- Package: `percent_indicator: ^4.2.5`
- Features: customizable stroke width, colors, rounded caps, and animation duration for both indicator types

### Day 05. Carousel Slider
- Fun, built-in **3D cube transition** between slides, plus a circular slide indicator — no custom animation code needed
- Carousel is sized as a **fixed-height banner (220px)**, not stretched full-screen — mirrors how carousels actually appear in real apps (App Store featured banners, onboarding hero sections)
- A "Why use it" section below the banner fills out the rest of the screen with real content, so the layout looks like a finished screen rather than an isolated widget demo
- Each slide is a styled gradient card with an icon, title, and subtitle instead of a flat color block
- Package: `flutter_carousel_slider: ^1.1.0`
- Features: swappable slide transforms (e.g. cube), customizable slide indicators, infinite looping via `unlimitedMode`

### Day 06. Smooth Page Indicator
- Pairs with any PageView to add polished, animated dot indicators — a staple of onboarding flows
- Page view is sized reasonably within the layout (not a nested Scaffold per page, not full-screen by accident), with a "Next" button that walks through pages using the shared PageController
- Each page is a gradient card with an icon, title, and subtitle instead of an empty colored box, and the button label changes to "You're all set" on the last page
- Package: smooth_page_indicator: ^2.0.1
- Features: multiple built-in dot effects (ExpandingDotsEffect, WormEffect, JumpingDotEffect, and more), fully customizable size, spacing, and color

### Day 07. Font Awesome
- Brings 2000+ Font Awesome icons (solid, regular, and brand) to Flutter as simple `FaIcon` widgets — a drop-in replacement for the standard `Icon`
- A clean grid showcases a mix of brand icons (GitHub, Google, LinkedIn) and common UI icons (bell, heart, star, search), each in its own labeled card
- Package: `font_awesome_flutter: ^11.0.0`
- Features: solid/regular/brand icon sets, same API as Flutter's built-in `Icon` widget

### Day 08. Animations (OpenContainer)
- OpenContainer (from the animations package) smoothly morphs a small card into a full detail screen — a common pattern in real apps (product cards, list-to-detail navigation)
- Uses a realistic example: a short list of trail cards that expand into detail pages with a title, tag, and description, instead of an abstract "small box / big box" demo
- Package: animations: ^2.2.0
- Features: multiple transition types (fadeThrough, fade, fadeThroughWithRipple), customizable colors, shapes, and duration for both the closed and open states

### Day 09. Neon
- Renders glowing, sign-style text with built-in retro fonts (Cyberpunk, Night Club 70s, Beon, and more), colors, and an optional flicker effect
- Kept on a dark background intentionally — unlike the earlier light-themed days, neon glow only reads clearly against black, so each sign sits in its own subtly-bordered panel like a real sign board
- Package: neon: ^0.1.0
- Features: multiple neon fonts, custom glow color, adjustable font size, per-letter or whole-text flickering

### Day 10. Aurora Gradients
- Draws soft, blurred color blobs to give a screen an ambient, animated backdrop
- Kept on a black background intentionally, same reasoning as Day 09 — the glow only reads clearly against dark backdrops
- Content sits on a frosted-glass card (BackdropFilter + translucent container) over the aurora blobs, showing a realistic use case — a hero/landing header — rather than plain text floating on the background
- Package: aurora: ^1.0.0
- Features: customizable blob size, position, and color list; layer multiple Aurora widgets in a Stack for a fuller effect

### Day 11. Card Swiper
- Turns a list of widgets into an auto-playing, swipeable carousel with pagination dots — a common pattern for promo/banner sections
- The original example used bundled asset images (assets/images/banner/*.jpg); swapped for styled gradient banner cards (icon, title, subtitle) so the example runs standalone without needing image assets in the project
- Carousel is sized as a fixed 190px banner, not full-screen, sitting inside a scrollable page alongside the info card
- Package: card_swiper: ^3.0.1
- Features: autoplay with configurable delay, multiple layouts, customizable pagination dot builder

### Day 12. BlurHash
- Decodes a short string (like LB9amjso4Txuq@t8yYMxD4IUysx]) into a soft blurred preview shown instantly, while the real image loads over the network — the same technique behind Medium's and Wolt's image placeholders
- Added a "Replay transition" button so you can watch the blur-to-image fade more than once, instead of only seeing it on first load
- Generate your own hash for any photo at blurha.sh
- Package: flutter_blurhash: ^0.9.1
- Features: works as an Image fit/loader combo, configurable fade duration, any BoxFit

### Day 13. Flutter SVG
- Renders vector graphics via SvgPicture.asset, .network, or .string — stays crisp at any size, unlike raster (PNG/JPG) images
- The original example loaded a bundled asset (assets/svg/flutter.svg); since that file isn't available here, this uses inline SVG strings with SvgPicture.string instead, so the example runs standalone with no asset setup — swap in SvgPicture.asset(...) once you have real files in pubspec.yaml
- A small gallery shows three hand-written vector icons (sun, mountains, rocket) in styled cards
- Package: flutter_svg: ^2.3.0
- Features: BoxFit support, works from assets, network URLs, or raw SVG strings

### Day 14. Custom Clippers
- Ships ready-made ClipPath shapes — waves, arcs, tickets, diagonals — for headers, banners, and cards without hand-drawing paths yourself
- Rather than dumping all ~18 clippers with debug labels, this curates 4 clippers used the way they'd appear in a real app: a wave header banner, a movie-ticket-style coupon card, an arc promo banner, and an oval profile header
- Each shape is filled with a gradient and real content (icon + text) instead of a flat color with the class name printed on it
- Package: flutter_custom_clippers: ^2.1.0
- Features: wave, arc, oval, diagonal, ticket, and pointed-edge clippers, most with flip/reverse options for mirroring

### Day 15. Flutter TTS
- Converts text into spoken audio using the platform's built-in speech engine — no server, API key, or internet connection required
- Swapped the original's unrelated news-article sample text for generic, self-describing copy ("try adjusting the rate and pitch...") so the demo makes sense on its own
- Added live speech-rate and pitch sliders wired directly to setSpeechRate / setPitch, so you can actually hear the effect instead of only seeing fixed platform-specific presets
- Package: flutter_tts: ^4.2.5
- Features: adjustable language, pitch, speech rate, and volume; start/completion/cancel handlers to track playback state

### Day 16. Flutter Highlight
- Adds syntax-colored code blocks with themes borrowed from highlight.js — handy for tutorials, docs, and code-sharing screens
- Fixed a bug from the original: the code was Dart but language was set to 'javascript' — now correctly matches each snippet's actual language
- A small language switcher (Dart / JSON) swaps both the code and the highlighter's language live, and a copy button puts the current snippet on the clipboard with a confirmation snackbar
- Package: flutter_highlight: ^0.7.0
- Features: dozens of built-in themes, language auto-detection or explicit language param, works with any TextStyle (paired here with google_fonts' Fira Code for a real code-editor look)

### Day 17. Syncfusion Flutter Charts
- Production-ready bar, line, and area/pie charts with built-in tooltips, legends, and animation — free for individuals and small businesses under Syncfusion's Community License
- The original referenced RunningBidsChart, CompletedBidsChart, and TotalAmountChart from a separate model.dart that wasn't included; this version is fully self-contained with sample weekly data built right in, so it compiles and runs standalone
- Three chart types on purpose, to show range: a column chart (running bids), a line chart with markers (completed bids), and an area chart (total amount)
- Package: syncfusion_flutter_charts: ^34.1.32
- Features: TooltipBehavior, category/numeric axes, dozens of series types (column, line, area, pie, and more), per-series color and styling

### Day 18. RFlutter Alert
- Makes it easy to show styled dialogs — success, error, warning, and fully custom layouts — with built-in animations
- The six examples are laid out as a **clean tappable action list** (icon, title, subtitle) instead of six stacked `ElevatedButton`s with plain labels
- The original loaded a bundled asset image for the "custom image" example; swapped for an `Icon` widget instead, showing that the `image:` slot accepts any widget, not just `Image.asset` — so it runs standalone with no asset setup
- Package: `rflutter_alert: ^2.0.7`
- Features: built-in alert types (success, error, warning, info), custom buttons with color/gradient, fully custom `AlertStyle` (animation, border, colors), and arbitrary custom `content`

### Day 19. Settings UI
- Builds native-feeling settings screens — sections, tiles, and switches — without hand-rolling ListTile styling and dividers yourself
- Fixed a logic bug from the original: "Change password" was a switchTile (a boolean toggle), which doesn't make sense for an action like changing a password — it's now a regular tappable tile like "Sign out" or "Email"
- Every tile's onPressed now shows a snackbar (Opening "Language"...) instead of doing nothing, so tapping around actually gives feedback
- Package: flutter_settings_ui: ^3.0.1
- Features: sections with titles, standard tiles, switch tiles, custom leading/trailing widgets, works with Text widgets for full styling control

### Day 20. Flutter Spinkit
- Ships 20+ animated loading indicators — a drop-in upgrade from the default CircularProgressIndicator
- Curated down to 9 spinners in one consistent accent color, instead of all 20+ in random colors separated by thick dividers — easier to compare styles side by side, and reads as a designed screen rather than a raw feature dump
- Added an "In Practice" section: a real submit button that swaps its label for a spinner during a simulated 2-second load, showing the pattern you'd actually use in an app
- Package: flutter_spinkit: ^5.2.2
- Features: dozens of spinner styles, customizable color, size, duration, and (for some) control via AnimationController

### Day 21. Audioplayers
- Plays audio from assets, files, or URLs, with play/pause/seek control and position/duration streams
- Updated to the current API — the original used AudioCache and PlayerMode.LOW_LATENCY, which are from a much older version of the package (pre-v1). audioplayers: ^6.8.1 plays sources directly via AudioPlayer().play(...) with typed sources like UrlSource, AssetSource, or DeviceFileSource
- Also replaced missing local assets (audio file + cover image) with a streamed sample track from a public URL and a gradient album-art placeholder, so the example runs standalone
- Added a live, seekable progress bar driven by onPositionChanged/onDurationChanged, and pause/resume instead of only play/stop
- Package: audioplayers: ^6.7.1
- Features: multiple source types, player state stream, position/duration streams, seeking

### Day 22. Go Router
- Adds declarative, URL-based navigation to Flutter — deep linking and browser back/forward work out of the box, on web and mobile alike
- Updated to the current router API: replaced the separate routeInformationParser / routerDelegate parameters with the single routerConfig parameter, which is what go_router (and Flutter's Router widget) recommends as of v6+
- Renamed Page1Screen/Page2Screen to HomeScreen/DetailsScreen, each showing its current path so it's clear what context.go(...) actually changed
- Package: go_router: ^17.3.0
- Features: declarative route definitions, path parameters, nested/shell routes, redirects, deep linking

### Day 23. HTTP
- Makes GET, POST, and other requests with a simple, promise-like API — this example fetches a sample record from a free public test API (jsonplaceholder.typicode.com)
- Fixed a race condition in the original: it set isLoading = false after a hardcoded 3-second Future.delayed, regardless of whether the actual request had finished — meaning a slow network would flip the UI back before data arrived, and a fast one would show a spinner for 3 seconds for nothing. Now the button awaits _fetchData() directly, and loading state is always cleared in a finally block
- Added proper error handling — failed requests now show a visible error message instead of just a print() no one sees
- JSON response is pretty-printed (JsonEncoder.withIndent) in a code-style block, instead of dumped as one unformatted line of text
- Package: http: ^1.6.0
- Features: GET/POST/PUT/DELETE, headers, timeouts, works with any REST API

### Day 24. Onboarding
- Drag-based onboarding flow with a fixed footer, page indicator, and skip/get-started button — built on the verified v4.0.2 API
- Each slide's icon sits in a gradient circle with a soft shadow instead of a flat tinted circle — small touch, reads noticeably more polished
- Package: onboarding: ^4.0.2
- Features: CustomPainter-based indicators (4 built-ins: LinePainter, CirclePainter, SquarePainter, TrianglePainter), fully custom footer builder, configurable animation speed

### Day 25. Flutter Neumorphic
- Renders "soft UI" components — embossed buttons, sliders, switches, progress bars — using light/shadow pairs instead of flat colors or borders
- Trimmed down to 4 core components (progress, button, slider, switch) instead of the full showcase (radio, checkboxes, 8 indicators, two button styles) — easier to read top to bottom and enough to show the visual style clearly
- Uses the package's own theming (NeumorphicTheme/NeumorphicBackground) rather than the series' usual white-card style, since neumorphism needs one shared flat base color for the embossed effect to read correctly
- Working dark/light toggle in the header, now a single icon button instead of a labeled "Dark Mode" button
- Switched to flutter_neumorphic_plus — the original flutter_neumorphic package is unmaintained and its source still references Flutter Material APIs (bodyText2, headline5, ThemeData.accentColor, AppBarTheme.textTheme) that were removed in later Flutter SDK versions, causing build failures. The fork patches exactly this and is a drop-in replacement — same widget names, same API, just a different import path (package:flutter_neumorphic_plus/flutter_neumorphic.dart)
- Package: flutter_neumorphic_plus: ^3.5.0
- Features: NeumorphicButton, Slider, Switch, Progress, concave/convex/flat shape styles, full dark mode support

### Day 26. Math Expressions
- Parses and evaluates math strings like `"1+2-4*3"` at runtime — handy for calculators, spreadsheets, or user-defined formulas
- **Fixed a crash bug**: the original called `exp.evaluate(...)` with no error handling — typing anything malformed (`"2+"`, `"2++2"`, empty input) would throw an uncaught exception and crash the widget. Wrapped in a `try/catch` that shows a friendly "Invalid expression" message instead
- **Fixed a confusing UX bug**: the original's "Clear" button only reset the *answer* text while leaving stale text in the input field — now "Reset" clears both together
- Added **quick-insert operator buttons** (`+ − × ÷ ( ) .`) that type into the field at the cursor position, since typing math symbols on a phone keyboard is annoying
- Package: `math_expressions: ^3.1.0`
- Features: `Parser`/`Expression`/`ContextModel` for parsing and evaluating arbitrary math strings, supports variables, functions, and multiple evaluation types

### Day 27. Clay Containers
- Renders soft, moldable "clay" shapes using layered shadows — flat, embossed, concave, or convex — all derived from one base color
- **Kept a single flat base color throughout the screen**, same reasoning as Day 25's neumorphic example: clay/soft-UI effects only render correctly when every element shares the same background color, so the series' usual white-card style would fight the effect here
- Replaced the original's **10 unlabeled shapes stacked in a column** with three organized sections: a realistic "profile card" combining `ClayContainer` + `ClayText`, a labeled side-by-side comparison of the three curve types, and a small custom-border-radius gallery
- Package: `clay_containers: ^0.3.4`
- Features: `ClayContainer` (flat/emboss, adjustable depth/spread, custom border radius, concave/convex/none curve types), `ClayText` for embossed text

### Day 28. Day/Night Switch
- **`day_night_switcher` (originally requested) is discontinued** — swapped for `day_night_switch`, an actively maintained package offering the same idea (an animated sun/moon toggle), with a simpler single-widget API instead of two separate widgets
- **Removed a redundant UI pattern** from the original: it had three separate controls (`Switch.adaptive`, `DayNightSwitcher`, and `DayNightSwitcherIcon`) all bound to the exact same boolean — visually confusing and pointless, since toggling any one should logically toggle all three. Now there's a single switch
- Uses `provider`'s `ChangeNotifier` to drive `ThemeMode` across the whole app — the switch is just one input that calls `toggleTheme()`; everything else (app bar colors, background, text colors) updates automatically via `Theme.of(context)`
- Package: `day_night_switch: <latest>` (replacing discontinued `day_night_switcher: ^0.2.0+1`)
- Features: single animated toggle between day/night states, customizable day/night/sun/moon colors, optional custom sun/moon images

### Day 29. Provider
- Lightweight state management built on `InheritedWidget` — `ChangeNotifier` + `context.watch`/`context.read` instead of manually threading callbacks through widget constructors
- **Kept the original's smart pattern of isolating the watching widget**: only `_CountDisplay` calls `context.watch<Counter>()`, so incrementing/decrementing only rebuilds that one `Text`, not the whole screen — this was correctly commented in your original code and preserved here
- **Replaced the three stacked `FloatingActionButton`s** (unconventional — Material design expects a single FAB, not three crammed into a `Row` inside `floatingActionButton`) with a proper inline button row: minus / restart (outlined) and plus (filled, as the primary action)
- Package: `provider: ^6.1.5+1`
- Features: `ChangeNotifier`, `ChangeNotifierProvider`, `MultiProvider` for combining multiple providers, `context.watch`/`context.read`/`context.select` for reading state with different rebuild granularity

### Day 30. Flutter Lucide
- Lucide is a free, open-source icon set of 1,699+ simple, consistent outline icons on a 24x24 grid — a clean alternative to Material's filled icon set, and the actively-maintained continuation of the (now-discontinued) Feather icon project
- Curated the original's 20-icon dump across 5 rows in 5 different pastel background colors down to a **labeled 12-icon grid in one consistent accent color**, matching Day 7's Font Awesome showcase
- Package: `flutter_lucide: <latest>`
- Features: 1,699+ icons, tree-shaking (only the icons you actually use are bundled), cross-platform (Android/iOS/web/desktop), regularly updated alongside upstream Lucide releases

### Day 31. Simple Gradient Text
- Paints any string with a linear or radial color gradient — a quick way to make a headline, hero title, or logo text stand out without a custom `ShaderMask`
- A large **hero-style gradient title** up top, plus two labeled example cards below (linear vs. radial), instead of one lone centered example — shows both gradient types side by side for comparison
- Package: `simple_gradient_text: ^1.4.0`
- Features: `GradientType.linear` (default) or `.radial`, any number of colors, adjustable radius for radial gradients, works with any `TextStyle`

### Day 32. Image Picker
- Lets users choose a photo from their gallery or take a new one with the camera — a near-universal building block for profile pictures and uploads
- **Fixed a web-compatibility bug**: the original used `File(image.path)` and `Image.file(...)`. `dart:io`'s `File` doesn't work on Flutter web (there's no real filesystem there) — this would crash if the app ever ran on web. Reads the picked image as bytes (`picked.readAsBytes()`) and displays it with `Image.memory(...)` instead, which works identically on mobile, desktop, and web
- **Fixed silent error handling**: the original only `print()`ed failures — invisible to the actual user. Failures now show a snackbar with the actual error message
- Restyled the preview as a circular avatar placeholder (with a loading spinner while picking) instead of the default `FlutterLogo`, and the two buttons as a labeled icon row instead of full-width stacked buttons
- Package: `image_picker: ^1.2.3`
- Features: pick from gallery or camera, image/video support, quality and size constraints, cross-platform (Android/iOS/web/desktop where supported)





---

## 📋 Table of Contents
<div align="center">

## 📦 Flutter Package of the Day

Learn Flutter packages by building practical examples, one package at a time. Each example demonstrates real-world usage with clean, easy-to-understand code.

</div>

## 📋 Packages

<table>
  <thead>
    <tr>
      <th width="90">Day</th>
      <th width="220">Package</th>
      <th width="220">Pub.dev</th>
      <th>Preview</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center"><b>01</b></td>
      <td>
        <a href="lib/features/day01_avatar_glow/day01_avatar_glow.dart">
          <b>Avatar Glow</b>
        </a><br/>
        <sub>Animated glowing avatar effect</sub>
      </td>
      <td>
        <a href="https://pub.dev/packages/avatar_glow">
          avatar_glow ^3.0.1
        </a>
      </td>
      <td align="center">
        <a href="screenshots/day01_avatar_glow.gif">
          <img src="screenshots/day01_avatar_glow.gif" width="170"/>
        </a>
      </td>
    </tr>
  </tbody>
</table>

---

## 🚀 Goal

To explore the Flutter ecosystem by learning one package at a time, understanding its purpose, API, best practices, and real-world implementation through practical examples.

---

## 🛠️ Tech Stack

- Flutter
- Dart
- Pub.dev Packages

---

## 🚀 Getting Started

```bash
# Clone the repository
git clone https://github.com/SheikhAman/package_of_the_day.git

# Navigate to the project
cd package_of_the_day

# Install dependencies
flutter pub get

# Run the application
flutter run
```

---

## 📌 Note

This repository is created for learning and practice purposes.  
Each package is implemented in its own example to keep the code clean, focused, and easy to understand.

---

## ⭐ Future Improvements

- Cover 100+ popular Flutter packages
- Add package comparisons and alternatives
- Build mini real-world apps using multiple packages
- Add web support where applicable
- Keep examples updated with the latest package versions