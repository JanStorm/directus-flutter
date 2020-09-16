import 'package:directus_flutter/src/core/abstract_directus_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class DirectusStatus extends AbstractDirectusWidgetState {
  @override
  Widget build(BuildContext context) {
    Color color = Colors.yellow;
    switch (widget.data.toString()) {
      case 'published':
        color = Colors.green;
        break;
      case 'draft':
        color = Colors.blue;
        break;
      case 'deleted':
        color = Colors.red;
        break;
    }
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(widget.data.toString()),
      ),
    );
  }
}
