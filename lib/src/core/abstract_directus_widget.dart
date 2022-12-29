import 'package:directus_flutter/directus_flutter.dart';
import 'package:flutter/widgets.dart';

class DirectusWidget extends StatefulWidget {
  final Map config;
  final dynamic data;

  DirectusWidget(this.config, this.data, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    String interface = config['meta']?['interface'] ?? config['type'] ?? '';
    AbstractDirectusWidgetState? widget = DirectusContentTypeRegistry()
        .getWidget(interface);

    if (widget == null) {
      debugPrint("[WARN] No Widget defined for interface " + interface + "!!");
      debugPrint("[WARN] See README.md on how configure one yourself.");
      debugPrint("[WARN] Using textarea as default.");

      widget = DirectusContentTypeRegistry().getWidget('textarea');
    }

    return widget!;
  }
}

abstract class AbstractDirectusWidgetState extends State<DirectusWidget> {}
