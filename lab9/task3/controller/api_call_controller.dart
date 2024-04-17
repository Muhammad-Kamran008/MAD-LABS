import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/api_call_model.dart';

class ApiCallController {
  final String _url = 'https://jsonplaceholder.typicode.com/todos';
  late StreamController<List<ApiCallModel>> _modelStreamController;

  Stream<List<ApiCallModel>> get modelStream => _modelStreamController.stream;

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<ApiCallModel> models = List<ApiCallModel>.from(
          jsonData.map((x) => ApiCallModel.fromJson(x)));
      _modelStreamController.add(models);
    } else {
      throw Exception('Unable to load data...');
    }
  }

  void dispose() {
    _modelStreamController.close();
  }

  ApiCallController() {
    _modelStreamController = StreamController<List<ApiCallModel>>();
  }
}
