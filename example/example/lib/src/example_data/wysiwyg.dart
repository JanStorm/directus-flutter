import 'file:///E:/htdocs/Flutter/plugins/directus_flutter_core/example/example/lib/src/abstract_example.dart';

class WYSIWYGExample extends AbstractExample {
  @override
  Future<Map> getData() async {
    return {
      'interface': 'wysiwyg',
      'data':
          '<p>Lange <strong>Beschreibung</strong> mit&nbsp;<span style=\"text-decoration: underline;\">Formatierem</span> Text</p>\n<h1>Header 1</h1>\n<h2>Header 2</h2>\n<h3>Header 3</h3>\n<p><span style=\"font-family: terminal, monaco, monospace;\">List</span>:</p>\n<ul>\n<li>Point 1</li>\n<li>Point 2</li>\n</ul>\n<p><span style=\"font-family: impact, sans-serif;\">List with numbers</span>:</p>\n<ol>\n<li>Point 1</li>\n<li>Point 2</li>\n</ol>'
    };
  }
}
