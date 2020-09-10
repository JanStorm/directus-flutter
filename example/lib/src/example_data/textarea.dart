import 'file:///E:/htdocs/Flutter/plugins/directus_flutter_core/example/example/lib/src/abstract_example.dart';

class TextareaExample extends AbstractExample {
  @override
  Future<Map> getData() async {
    return {
      'interface': 'textarea',
      'data': 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
    };
  }
}
