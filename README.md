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