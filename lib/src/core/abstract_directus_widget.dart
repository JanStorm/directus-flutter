import 'package:directus_flutter/src/content_type/textarea.dart';
import 'package:directus_flutter/directus_flutter.dart';
import 'package:flutter/widgets.dart';

class DirectusWidget extends StatefulWidget {
  final Map config;

  DirectusWidget(this.config);

  @override
  State<StatefulWidget> createState() {
    String interface = config['interface'] ?? 'textarea';

    if (DirectusContentTypeRegistry().contentTypes[interface] == null) {
      debugPrint("[WARN] No Widget defined for interface " + interface + "!!");
      debugPrint("[WARN] See README.md on how configure one yourself.");
      debugPrint("[WARN] Using textarea as default.");
    }

    return DirectusContentTypeRegistry().contentTypes[interface] ?? DirectusTextarea();
  }
}

abstract class AbstractDirectusWidgetState extends State<DirectusWidget> {}
