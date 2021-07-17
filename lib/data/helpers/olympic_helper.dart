class OlympicHelper {
  static String countryFlagFromCode({String countryCode}) {
    return String.fromCharCode(countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6) +
        String.fromCharCode(countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6);
  }
}
