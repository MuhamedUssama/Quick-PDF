# 🎨 LocalSend Design & Theme System Guidelines

> **IMPORTANT FOR ALL DEVELOPERS & AI AGENTS**:  
> Read and adhere strictly to this design system document before implementing any UI features, widgets, screens, or components in the LocalSend project. Do **NOT** create ad-hoc inline styles, custom hardcoded colors, or duplicate widget themes.

---

## 📌 Core Architectural Directives

### 1. 🚫 No Redundant Inline Widget Styling
- All standard Flutter widgets (`ElevatedButton`, `FilledButton`, `OutlinedButton`, `TextButton`, `TextField`, `Card`, `AppBar`, `ListTile`, `Dialog`, `BottomSheet`, `NavigationBar`, etc.) have their styles **pre-configured globally** in `AppTheme`.
- **Do NOT** define ad-hoc `TextStyle`, `BorderRadius`, `minimumSize`, or `BorderSide` on individual widgets if they are already defined in `AppTheme`.
- All buttons MUST inherit their default height (`minimumSize: Size.fromHeight(56)`) and typography (`GoogleFonts.plusJakartaSans`) directly from `Theme.of(context)`.

### 2. 🎨 Always Use Theme ColorScheme (Never AppColors directly in Widgets)
- **ALWAYS** reference colors dynamically via `Theme.of(context).colorScheme` (e.g., `colorScheme.primary`, `colorScheme.surface`, `colorScheme.onSurface`, `colorScheme.secondary`, `colorScheme.tertiary`, `colorScheme.primaryContainer`, `colorScheme.outline`, etc.).
- **NEVER** use `AppColors` directly inside screens or widgets (AppColors is reserved strictly for defining the `ThemeData` / `ColorScheme` inside `app_theme.dart`).
- **NEVER** use hardcoded raw colors like `Colors.blue`, `Colors.black`, `Color(0xFF...)` directly inside screens or components.

### 3. 🔤 Typography & Font Family
- The default project typography is **Plus Jakarta Sans** via `GoogleFonts.plusJakartaSans`.
- Always consume text styles using `Theme.of(context).textTheme` (e.g., `textTheme.headlineLarge`, `textTheme.titleMedium`, `textTheme.bodyLarge`).
- Do NOT override `fontFamily` or create custom `TextStyle` instances without referencing `Theme.of(context).textTheme` or `GoogleFonts.plusJakartaSans`.

### 4. 💎 Iconography (Use `iconsax_plus` ONLY)
- **NEVER** use standard Material `Icons.*` or Cupertino icons for app features.
- **ALWAYS** import and use icons from the **`iconsax_plus`** package:
  ```dart
  import 'package:iconsax_plus/iconsax_plus.dart';
  
  // Example Usage:
  Icon(IconsaxPlusLinear.send_2, color: theme.colorScheme.primary);
  Icon(IconsaxPlusBold.wifi, color: theme.colorScheme.secondary);
  ```

### 5. ✨ Subtle Screen Animations (`animate_do` Package)
- **ALWAYS** include smooth, lightweight entry animations in screens and key components using the **`animate_do`** package (e.g., `FadeInUp`, `FadeInDown`, `ZoomIn`, `FadeIn`).
- Keep animation durations subtle and quick (e.g., 400ms – 800ms) to ensure a premium responsive user experience without slowing down interaction.

---

## 🛠️ Theme Tokens Reference

| Token | Light Theme | Dark Theme | Purpose / Usage |
|---|---|---|---|
| `primary` | `#006D77` (Deep Teal) | `#2A9D8F` (Teal Green) | Core Identity, Primary Actions |
| `secondary` | `#83C5BE` (Lighter Teal) | `#83C5BE` (Lighter Teal) | Network, Interactive Highlights |
| `accentCoral` | `#E29578` (Warm Coral Sand) | `#E29578` (Warm Coral Sand) | Active transfers, Streaming |
| `surface` | `#FFFFFF` (Pure White) | `#1B1D1E` (Dark Slate) | Card & Container Surfaces |
| `scaffoldBackgroundColor` | `#F8FAFC` (Off-White) | `#141516` (Deep Charcoal Slate) | Screen Backdrop |
| `mintGreen` | `#2A9D8F` | `#2A9D8F` | Success, Connected Status |
| `coralPulse` | `#E76F51` | `#E76F51` | Live Activity, Warning, Error |

---

## 📁 Key File Locations

- **Color Definitions**: [`lib/core/theme/app_colors.dart`](file:///Users/mohamedosama/Documents/Flutter/FlutterProjects/local_send/lib/core/theme/app_colors.dart)
- **Theme Configuration**: [`lib/core/theme/app_theme.dart`](file:///Users/mohamedosama/Documents/Flutter/FlutterProjects/local_send/lib/core/theme/app_theme.dart)
- **Theme Showcase Screen**: [`lib/features/theme_test/theme_test_screen.dart`](file:///Users/mohamedosama/Documents/Flutter/FlutterProjects/local_send/lib/features/theme_test/theme_test_screen.dart)

---

## 🚨 Strict Code Review Checklist

Before committing any UI code:
- [ ] No `Icons.*` used (Replaced with `IconsaxPlus.*`).
- [ ] No `AppColors.*` or raw `Color(...)`/`Colors.red` used in widget/screen code (All colors derived from `Theme.of(context).colorScheme`).
- [ ] No custom `minimumSize` or redundant `TextStyle` applied manually to standard buttons.
- [ ] All text elements consume `Theme.of(context).textTheme`.
- [ ] Entry animations added using `animate_do` for smooth user interactions.
