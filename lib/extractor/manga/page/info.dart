import 'package:utilx/locale.dart';

class PageInfo {
  const PageInfo({
    required this.url,
    required this.locale,
  });

  factory PageInfo.fromJson(final Map<dynamic, dynamic> json) => PageInfo(
        url: json['url'] as String,
        locale: Locale.parse(json['locale'] as String),
      );

  final String url;
  final Locale locale;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'url': url,
        'locale': locale.toCodeString(),
      };
}
