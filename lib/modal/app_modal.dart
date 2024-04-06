class Festival {
  final String name;
  final String date;
  final String description;
  final String thamb;
  final List<String> images;
  final List<String> elements;

  Festival({
    required this.name,
    required this.date,
    required this.description,
    required this.thamb,
    required this.images,
    required this.elements,
  });

  factory Festival.formMap({required Map data}) => Festival(
        name: data['name'],
        date: data['date'],
        description: data['description'],
        thamb: data['thamb'],
        images: data['images'],
        elements: data['elements'],
      );

  Map<String, dynamic> get toMap => {
        'name': name,
        'date': date,
        'description': description,
        'thamb': thamb,
        'images': images,
        'elements': elements
      };
}
