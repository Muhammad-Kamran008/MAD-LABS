import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import '../controller/api_call_controller.dart';
import '../model/api_call_model.dart';

class ApiCallScreen extends StatefulWidget {
  @override
  _ApiCallScreenState createState() => _ApiCallScreenState();
}

class _ApiCallScreenState extends State<ApiCallScreen> {
  late ApiCallController _controller;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _controller = ApiCallController();
    _fetchData();
  }

  Future<void> _fetchData() async {
    bool hasInternet = await _checkInternet();
    if (!hasInternet) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'No internet connection!';
      });
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });
      await _controller.fetchData();
      Timer(Duration(seconds: 3), () {
        // show the Go button along with CircularProgressIndicator for 3 seconds
        if (mounted) {
          // check if the widget is still mounted
          setState(() {
            _isLoading = false;
            _errorMessage = '';
          });
        }
      });
    } on Exception catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  Future<bool> _checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    await Future.delayed(Duration(seconds: 3));
    connectivityResult =
        await Connectivity().checkConnectivity(); // Check again
    print("Connectivity is: $connectivityResult");

    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 222, 230, 237),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _errorMessage.isNotEmpty
                ? _buildErrorMessage()
                : _buildList(),
      ),
    );
  }

  Widget _buildList() {
    return StreamBuilder<List<ApiCallModel>>(
      stream: _controller.modelStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show CircularProgressIndicator and Go button for the first time only
          if (_isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: Text('Go'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Container();
        } else if (snapshot.hasError) {
          return _buildErrorMessage(message: snapshot.error.toString());
        } else {
          final List<ApiCallModel> models = snapshot.data!;
          return ListView.builder(
            itemCount: models.length,
            itemBuilder: (context, index) {
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                borderOnForeground: true,
                child: ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\nID : ',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Sakkal Majalla',
                          ),
                        ),
                        TextSpan(
                          text: '\t${models[index].id}\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Calibri',
                          ),
                        ),
                        TextSpan(
                          text: '\nTitle : ',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Sakkal Majalla',
                          ),
                        ),
                        TextSpan(
                          text: '\t${models[index].title}\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Calibri',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildErrorMessage({String message = ''}) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Something terrible happened!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              message.isNotEmpty ? message : 'Unable to load data...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _fetchData,
                  child: Text('Retry'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
