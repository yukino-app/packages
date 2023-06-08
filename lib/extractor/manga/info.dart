import 'package:utilx/locale.dart';
import 'package:utilx/utils.dart';
import '../base/image_describer.dart';
import 'chapter/info.dart';

class MangaInfo {
  MangaInfo({
    required this.url,
    required this.title,
    required final List<ChapterInfo> chapters,
    required this.locale,
    required this.availableLocales,
    this.thumbnail,
  }) : chapters = ListUtils.tryArrange(
          chapters,
          (final ChapterInfo x) => x.chapter,
        );

  factory MangaInfo.fromJson(final Map<dynamic, dynamic> json) => MangaInfo(
        title: json['title'] as String,
        url: json['url'] as String,
        chapters: (json['chapters'] as List<dynamic>)
            .cast<Map<dynamic, dynamic>>()
            .map((final Map<dynamic, dynamic> x) => ChapterInfo.fromJson(x))
            .toList(),
        thumbnail: json['thumbnail'] != null
            ? ImageDescriber.fromJson(
                json['thumbnail'] as Map<dynamic, dynamic>,
              )
            : null,
        locale: Locale.parse(json['locale'] as String),
        availableLocales: (json['availableLocales'] as List<dynamic>)
            .cast<String>()
            .map((final String x) => Locale.parse(x))
            .toList(),
      );

  final String title;
  final String url;
  final List<ChapterInfo> chapters;
  final ImageDescriber? thumbnail;
  final Locale locale;
  final List<Locale> availableLocales;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'title': title,
        'url': url,
        'thumbnail': thumbnail?.toJson(),
        'chapters': chapters.map((final ChapterInfo x) => x.toJson()).toList(),
        'locale': locale.toCodeString(),
        'availableLocales':
            availableLocales.map((final Locale x) => x.toCodeString()).toList(),
      };
}
