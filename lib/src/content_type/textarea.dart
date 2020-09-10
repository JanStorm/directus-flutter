import 'package:directus_flutter/src/core/abstract_directus_widget.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class DirectusTextarea extends AbstractDirectusWidgetState {
  @override
  Widget build(BuildContext context) {
    return Text(widget.config['data'].toString());
  }
}
