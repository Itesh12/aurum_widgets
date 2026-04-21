import "package:flutter/cupertino.dart";

/// Extension on [num] to provide quick [SizedBox] spacing.
/// 
/// Example: `10.h` for `SizedBox(height: 10)`
extension SpacingExtension on num {
  /// returns a [SizedBox] with this number as height.
  SizedBox get h => SizedBox(
        height: toDouble(),
      );

  /// returns a [SizedBox] with this number as width.
  SizedBox get w => SizedBox(
        width: toDouble(),
      );
}

/// Extension on [String] for common cleaning utilities.
extension StringRemoveAsterisk on String {
  /// Removes all `*` characters and trims extra spaces.
  String removeAsterisk() {
    return replaceAll("*", "").trim();
  }
}
