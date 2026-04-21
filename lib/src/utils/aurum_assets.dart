/// A utility class that holds paths for images and icons bundled with the plugin.
class AurumAssetsImages {
  factory AurumAssetsImages() {
    return _singleton;
  }

  AurumAssetsImages._internal();

  static final AurumAssetsImages _singleton = AurumAssetsImages._internal();

  final String downArrowIcon = "assets/images/down_arrow_icon.png";
  final String placeholderImage01 = "assets/images/placeholder_profile.png";
  final String coverBrokenImage = "assets/images/cover_broken.png";
  final String logoBrokenImage = "assets/images/logo_broken.png";
}
