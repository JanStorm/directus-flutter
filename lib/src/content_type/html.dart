import 'package:directus_flutter/src/core/abstract_directus_widget.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

class DirectusHtml extends AbstractDirectusWidgetState {
  @override
  Widget build(BuildContext context) {
    return Html(data: widget.data.toString());
  }
}
