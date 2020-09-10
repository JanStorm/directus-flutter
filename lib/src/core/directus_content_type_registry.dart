import 'package:directus_flutter/src/content_type/textarea.dart';

import 'abstract_directus_widget.dart';

class DirectusContentTypeRegistry {
  static final DirectusContentTypeRegistry _singleton = new DirectusContentTypeRegistry._internal();

  factory DirectusContentTypeRegistry() {
    return _singleton;
  }
  DirectusContentTypeRegistry._internal();

  Map<String, AbstractDirectusWidgetState> contentTypes = {
    'textarea': DirectusTextarea()
  };
}