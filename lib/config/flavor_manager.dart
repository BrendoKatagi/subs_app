enum FlavorEnum {
  dev,
  staging,
  prod,
}

class FlavorManager {
  static FlavorEnum? appFlavor;

  static String get name => appFlavor?.name ?? '';
}
