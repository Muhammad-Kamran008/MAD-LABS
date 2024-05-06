
class Search {
  final String title;
  final String url;
  final String date;
  final int? viewCount;

  Search({
    required this.title,
    required this.url,
    required this.date,
    this.viewCount,
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    final String title = json['title']?.toString() ?? '';
    final String url = json['url']?.toString() ?? '';
    final String date = json['date']?.toString() ?? '';
    final int? viewCount = json['view_count'] != null
        ? int.tryParse(json['view_count'].toString())
        : null;
    return Search(
      title: title,
      url: url,
      date: date,
      viewCount: viewCount,
    );
  }
}


