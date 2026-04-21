class AurumAssetsImages {
  factory AurumAssetsImages() {
    return _singleton;
  }

  AurumAssetsImages._internal();

  static final AurumAssetsImages _singleton = AurumAssetsImages._internal();

  final String downArrowIcon = "assets/images/down_arrow_icon.png";
}
