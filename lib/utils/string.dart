import 'dart:math';

abstract class StringUtils {
  static String capitalize(final String string) => string.isNotEmpty
      ? '${string.substring(0, 1).toUpperCase()}${string.substring(1).toLowerCase()}'
      : string;

  static String random({
    final int inputLength = 6,
    final String characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890-=',
  }) {
    final Random r = Random();

    return List<String>.generate(
      inputLength,
      (final int i) => characters[r.nextInt(characters.length)],
    ).join();
  }

  static String toHex(final String input) =>
      input.codeUnits.map((final int x) => x.toRadixString(16)).join();

  static String render(
    final String template,
    final Map<String, String> context,
  ) =>
      template.replaceAllMapped(RegExp('{{{(.*?)}}}'), (final Match match) {
        final String key = match.group(1)!.trim();
        return context.containsKey(key) ? context[key]! : 'null';
      });

  static List<String> getWords(final String text) => text
      .replaceAllMapped(
        RegExp('[A-Z]'),
        (final Match m) => '_${m.group(0)!.toLowerCase()}',
      )
      .split(RegExp(r'[\s_-]+'))
      .where((final String x) => x.isNotEmpty)
      .toList();

  static String? onlyIfNotEmpty(final String text) =>
      text.trim().isNotEmpty ? text : null;

  static String formatPositional(final String text, final List<String> args) {
    final StringBuffer output = StringBuffer();
    final int length = text.length;
    for (int i = 0; i < length; i++) {
      final String x = text[i];
      if (x == '{') {}
      switch (x) {
        case '{':
          final String y = text[i + 1];
          if (y == '{') {
            output.write('{');
            i++;
            continue;
          }
          output.write(args[int.parse(y)]);
          i += 2;

        case '}':
          output.write('}');
          i++;

        default:
          output.write(x);
      }
    }
    return output.toString();
  }

  static final RegExp _illegalCharacterRegex = RegExp(r'[^\w]+');
  static String replaceIllegalCharacters(
    final String text, {
    final String replaceWith = '-',
  }) =>
      text.replaceAll(_illegalCharacterRegex, replaceWith);

  static String substringLast(final String text, final int maxLength) =>
      text.substring(max(0, text.length - maxLength), text.length);
}

class StringCase {
  const StringCase(this.text);

  final String text;

  List<String> get words => StringUtils.getWords(text);

  String get camelCase {
    final List<String> words = this.words;
    if (words.isEmpty) return '';
    return '${words.first}${words.sublist(1).map(StringUtils.capitalize).join()}';
  }

  String get sentenceCase {
    final List<String> words = this.words;
    if (words.isEmpty) return '';
    return '${words.first} ${words.sublist(1).map(StringUtils.capitalize).join(' ')}'
        .trim();
  }

  String get titleCase => words.map(StringUtils.capitalize).join(' ');
  String get pascalCase => words.map(StringUtils.capitalize).join();
  String get snakeCase => words.join('_');
  String get kebabCase => words.join('-');
}
