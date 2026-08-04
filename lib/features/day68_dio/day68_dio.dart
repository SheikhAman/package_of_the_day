import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const _accent = Color(0xFF6C5CE7);

class Day68Dio extends StatefulWidget {
  const Day68Dio({super.key});

  @override
  State<Day68Dio> createState() => _Day68DioState();
}

class _Day68DioState extends State<Day68Dio> {
  final Dio _dio = Dio();

  String? _title;
  int? _userId;

  bool _isLoading = false;
  String? _errorMessage;

  static const String _url = 'https://jsonplaceholder.typicode.com/albums/1';

  Future<void> fetchData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final response = await _dio.get(_url);

      if (response.statusCode == 200) {
        setState(() {
          _userId = response.data['userId'];
          _title = response.data['title'];
        });

        debugPrint('Response: ${response.data}');
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });

      debugPrint('Dio Error: $e');
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });

      debugPrint('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void reset() {
    setState(() {
      _title = null;
      _userId = null;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 68 - Dio',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(18),
              ),

              child: Column(
                children: [
                  const Text(
                    'API Response',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  if (_isLoading)
                    const CircularProgressIndicator()
                  else if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    )
                  else
                    Column(
                      children: [
                        Text(
                          'User ID: ${_userId ?? "Not Loaded"}',
                          style: const TextStyle(fontSize: 18),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'Title: ${_title ?? "Not Loaded"}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: _accent),

                icon: const Icon(Icons.cloud_download),

                label: const Text('Fetch API Data'),

                onPressed: fetchData,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.refresh),

                label: const Text('Reset'),

                onPressed: reset,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
