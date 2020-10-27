extension StringExt on String {
  List toList() {
    return this
        .replaceRange(0, 1, "")
        .replaceRange(this.length - 2, this.length - 1, "")
        .split(", ");
  }
}
