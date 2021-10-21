String titleAccordingToTime() {
  var now = DateTime.now();
  String title =
      "RoarxScanner scanned document ${now.millisecond}${now.microsecond}${now.minute}";
  return title;
}
