# Aurum Widgets

A premium, theme-agnostic UI kit for Flutter applications. Aurum Widgets provides a collection of standardized, enterprise-grade components designed for consistency, performance, and ease of use.

## ✨ Features

- **🛡️ AurumTextField**: A robust input field with validation, icon support, and a dedicated `dropdownField` mode.
- **🚀 Buttons**: Modern `AurumPushButton` (bold shadow effects) and `AurumOutlinedButton`.
- **🏗️ AurumBottomSheet**: Powerful utilities for selection lists (Radio, Checkbox, Single-select).
- **📝 AurumText**: Standardized typography scaling from 12 to 20 pixels with pre-defined weights.
- **🔄 MaybeMarquee**: Automatic marquee scrolling specifically for overflowing text.
- **🔍 AurumRegex**: A centralized collection of enterprise validation patterns (Email, PAN, Aadhaar, Mobile, etc.).

---

## 📦 Installation

To use this plugin, add `aurum_widgets` as a dependency in your `pubspec.yaml` file pointing to the Git repository:

```yaml
dependencies:
  aurum_widgets:
    git:
      url: https://github.com/Itesh12/aurum_widgets.git
      ref: main
```

Run `flutter pub get` to install.

---

## 🚀 Usage

### 1. AurumTextField (Dropdown Example)
The `dropdownField` mode automatically makes the field read-only, hides the cursor, and adds a selection arrow.

```dart
AurumTextField(
  controller: myController,
  labelText: "Select Branch",
  dropdownField: true,
  onTap: () {
    // Open your picker here
  },
)
```

### 2. AurumPushButton
A premium button with a dynamic shadow effect that responds to touch.

```dart
AurumPushButton(
  text: "Confirm Payment",
  onPressed: () async {
    await processPayment();
  },
)
```

### 3. Selection Bottom Sheets
Quickly show radio-button or checkbox selection lists.

```dart
AurumBottomSheet().showRBBottomSheet<String>(
  context: context,
  title: "Select Office",
  originalList: ["Main Office", "Branch A"].obs,
  selectedItem: selectedOfficeRx,
  getText: (item) => item,
);
```

### 4. Typography
Consistent text styles across your entire app.

```dart
AurumText.f18w600("Title Text"),
AurumText.f14w400("Body Description"),
```

---

## 📱 Example App

A complete demonstration of all widgets can be found in the [example](example/lib/main.dart) folder.

To run the example:
1. Navigate to the example folder: `cd example`
2. Run the app: `flutter run`

---

## 🛠️ Requirements

- Flutter SDK: `>=3.0.0`
- Dart SDK: `>=3.0.0 <4.0.0`
- Dependencies: `get`, `marquee`
