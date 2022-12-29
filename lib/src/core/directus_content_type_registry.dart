import 'package:directus_flutter/src/content_type/html.dart';
import 'package:directus_flutter/src/content_type/status.dart';
import 'package:directus_flutter/src/content_type/textarea.dart';

import 'abstract_directus_widget.dart';

class DirectusContentTypeRegistry {
  static final DirectusContentTypeRegistry _singleton =
      DirectusContentTypeRegistry._internal();

  factory DirectusContentTypeRegistry() {
    return _singleton;
  }

  DirectusContentTypeRegistry._internal();

  AbstractDirectusWidgetState? getWidget(String contentType) {
    switch (contentType) {
      case 'input-rich-text-html':
        return DirectusHtml();
      case 'status':
        return DirectusStatus();
      case 'input':
      case 'textarea':
      case 'input-multiline':
        return DirectusTextarea();
      default:
        return null;
    }
  }
}
