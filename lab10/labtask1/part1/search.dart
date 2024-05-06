class Search {
  final String title;
  final String url;
  final String date;

  Search({
    required this.title,
    required this.url,
    required this.date,
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      title: json['title'],
      url: json['url'],
      date: json['date'],
    );
  }
}
