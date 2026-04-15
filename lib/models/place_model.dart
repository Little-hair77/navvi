class PlaceModel {
  final String id;
  final String name;
  final String? imageUrl;
  final String? description;

  PlaceModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    final title = _extractTitle(json) ?? 'Local sem nome';
    final description = _extractDescription(json);
    final imageUrl = _extractImageUrl(json);

    return PlaceModel(
      id: (json['Id'] ?? json['id'] ?? '').toString(),
      name: title,
      imageUrl: imageUrl,
      description: (description != null && description.isNotEmpty)
          ? description
          : 'Explore este local incrivel para descobrir mais detalhes.',
    );
  }

  static String? _extractTitle(Map<String, dynamic> json) {
    final directTitle = _firstNonEmptyString([
      json['ShortName'],
      json['Name'],
      json['Title'],
    ]);
    if (directTitle != null) return directTitle;

    final detail = json['Detail'];
    if (detail is Map<String, dynamic>) {
      return _extractLocalizedField(detail, const [
        'Title',
        'ShortName',
        'Name',
      ]);
    }

    return null;
  }

  static String? _extractDescription(Map<String, dynamic> json) {
    final directDescription = _firstNonEmptyString([
      json['BaseText'],
      json['Description'],
      json['Desc'],
      json['Text'],
    ]);
    if (directDescription != null) return directDescription;

    final detail = json['Detail'];
    if (detail is Map<String, dynamic>) {
      return _extractLocalizedField(detail, const [
        'BaseText',
        'Description',
        'Desc',
        'Text',
      ]);
    }

    return null;
  }

  static String? _extractImageUrl(Map<String, dynamic> json) {
    final gallery = json['ImageGallery'];
    if (gallery is List) {
      for (final item in gallery) {
        if (item is Map<String, dynamic>) {
          final candidate = _firstNonEmptyString([
            item['ImageUrl'],
            item['Url'],
            item['ImageSource'],
          ]);
          final normalized = _normalizeImageUrl(candidate);
          if (normalized != null) return normalized;
        }
      }
    }

    final firstImage = json['FirstImage'];
    if (firstImage is Map<String, dynamic>) {
      final normalized = _normalizeImageUrl(_firstNonEmptyString([
        firstImage['ImageUrl'],
        firstImage['Url'],
        firstImage['ImageSource'],
      ]));
      if (normalized != null) return normalized;
    }

    return _normalizeImageUrl(_firstNonEmptyString([
      json['ImageUrl'],
      json['Image'],
      json['ImageSource'],
    ]));
  }

  static String? _extractLocalizedField(
    Map<String, dynamic> detail,
    List<String> fieldNames,
  ) {
    const preferredLanguages = ['pt', 'pt-br', 'en', 'it', 'de'];

    for (final language in preferredLanguages) {
      final localizedEntry = detail[language];
      if (localizedEntry is Map<String, dynamic>) {
        final value = _firstValueFromMap(localizedEntry, fieldNames);
        if (value != null) return value;
      }
    }

    for (final entry in detail.values) {
      if (entry is Map<String, dynamic>) {
        final value = _firstValueFromMap(entry, fieldNames);
        if (value != null) return value;
      }
    }

    return _firstValueFromMap(detail, fieldNames);
  }

  static String? _firstValueFromMap(
    Map<String, dynamic> map,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = map[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }
    return null;
  }

  static String? _firstNonEmptyString(List<dynamic> values) {
    for (final value in values) {
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }
    return null;
  }

  static String? _normalizeImageUrl(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    final trimmed = value.trim();
    final uri = Uri.tryParse(trimmed);
    if (uri == null) return null;

    if (uri.hasScheme) return trimmed;
    if (trimmed.startsWith('//')) return 'https:$trimmed';
    if (trimmed.startsWith('/')) {
      return 'https://tourism.api.opendatahub.com$trimmed';
    }

    return 'https://tourism.api.opendatahub.com/$trimmed';
  }
}
