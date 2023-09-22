String extractFirstLetters(String input) {
  List<String> words = input.split(' ');
  List<String> firstLetters = [];

  for (String word in words) {
    if (word.isNotEmpty) {
      firstLetters.add(word[0]);
    }
  }

  return firstLetters.join('');
}
