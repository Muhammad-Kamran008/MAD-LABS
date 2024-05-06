import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'search.dart';
import 'package:flutter/services.dart'; // Import for asset loading

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD-LAB 10',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchString = '';

  @override
  void initState() {
    super.initState();
    fetchData();
    readJsonFile();
  }

  static Future<List<Search>> fetchData() async {
    final response = await http
        .get(Uri.parse('https://codewithandrea.com/search/search.json'));
    print(
        "Response code is: ${response.statusCode}. \n Response body is: ${response.body} ");
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      return data.map((json) => Search.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Search>> readJsonFile() async {
    final jsonString = await rootBundle.loadString('assets/searchlist.json');
    final List<dynamic> data = jsonDecode(jsonString);
    return data.map((json) => Search.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: FutureBuilder<List<Search>>(
        future: readJsonFile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final searchList = snapshot.data!;
            return ListView.builder(
              itemCount: searchList.length,
              itemBuilder: (context, index) {
                final search = searchList[index];
                final shortTitle = search.title.split(' ').take(7).join(' ');
                final responseNum =
                    index + 1; // Add 1 to make the index 1-based

                return ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Response $responseNum: \n",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: "Date: \t\t${search.date}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Text(
                    "Title: \t\t\t$shortTitle\n",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {},
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
