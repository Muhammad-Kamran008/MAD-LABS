class ApiCallModel {
  final int id;
  final String title;

  ApiCallModel({
    required this.id,
    required this.title,
  });

  factory ApiCallModel.fromJson(Map<String, dynamic> json) {
    return ApiCallModel(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}
