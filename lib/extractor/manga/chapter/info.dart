import 'package:utilx/locale.dart';

class ChapterInfo {
  const ChapterInfo({
    required this.chapter,
    required this.url,
    required this.locale,
    this.title,
    this.volume,
  });

  factory ChapterInfo.fromJson(final Map<dynamic, dynamic> json) => ChapterInfo(
        title: json['title'] as String?,
        url: json['url'] as String,
        volume: json['volume'] as String?,
        chapter: json['chapter'] as String,
        locale: Locale.parse(json['locale'] as String),
      );

  final String? title;
  final String? volume;
  final String chapter;
  final String url;
  final Locale locale;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'title': title,
        'volume': volume,
        'chapter': chapter,
        'url': url,
        'locale': locale.toCodeString(),
      };
}
