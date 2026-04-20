import "package:flutter/cupertino.dart";

extension SpacingExtension on num {
  SizedBox get h => SizedBox(
        height: toDouble(),
      );

  SizedBox get w => SizedBox(
        width: toDouble(),
      );
}



extension StringRemoveAsterisk on String {
  /// Removes all `*` characters and trims extra spaces
  String removeAsterisk() {
    return replaceAll("*", "").trim();
  }
}
