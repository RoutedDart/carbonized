abstract class DocItem {}

class TextItem extends DocItem {
  final String text;
  TextItem(this.text);
}

class ExampleItem extends DocItem {
  final String code;
  final String output;
  ExampleItem({required this.code, required this.output});
}

class DocSection {
  final String title;
  final String slug;
  final List<DocItem> items;

  DocSection({required this.title, required this.slug, required this.items});
}
