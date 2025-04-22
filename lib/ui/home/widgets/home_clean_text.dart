String cleanText(String input) {
  return input
    .replaceAll(RegExp(r'<[^>]*>'), '')
    .replaceAll('&amp;', '&');
}
