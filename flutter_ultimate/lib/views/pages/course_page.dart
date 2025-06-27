import 'dart:convert';
import 'package:flutte_ultimate/data/classes/activity_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  // State variables to hold data, loading status, and error messages
  Activity? _activity;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Fetch data as soon as the widget is created
    _fetchActivity();
  }

  // Asynchronous function to fetch data from the API
  Future<void> _fetchActivity() async {
    // Reset state before fetching
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Create the Uri object from the URL
      final url = Uri.https('bored-api.appbrewery.com', '/random');
      // Make the GET request using the http package
      final response = await http.get(url);

      // Check if the response was successful (status code 200)
      if (response.statusCode == 200) {
        // Decode the JSON string from the response body
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

        // Use the factory constructor to parse the JSON into an Activity object
        final activity = Activity.fromJson(jsonResponse);

        // Update the UI state with the new data
        setState(() {
          _activity = activity;
          _isLoading = false;
        });
      } else {
        // Handle non-200 status codes (e.g., 404, 500)
        setState(() {
          _errorMessage =
              'Failed to load activity. Status code: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      // Catch any exceptions that occur during the network request or parsing
      setState(() {
        _errorMessage = 'An error occurred: $e';
        _isLoading = false;
      });
    }
  }

  // Build the UI based on the current state
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bored API Viewer'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        // Use a conditional check to show different widgets
        child: _isLoading
            ? const CircularProgressIndicator() // Show a loader while fetching
            : _errorMessage != null
            ? Text(
                _errorMessage!, // Show error message if an error occurred
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              )
            : _activity != null
            ? SingleChildScrollView(
                // Display the fetched activity details
                child: Card(
                  margin: const EdgeInsets.all(20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _activity!.activity,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 16),
                        Text('Type: ${_activity!.type}'),
                        Text('Participants: ${_activity!.participants}'),
                        Text('Price: \$${_activity!.price}'),
                        Text('Accessibility: ${_activity!.accessibility}'),
                        if (_activity!.link.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('Link: ${_activity!.link}'),
                          ),
                        const SizedBox(height: 20),
                        Text(
                          'Ready to be bored?',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Text(
                'Press the button to get an activity.',
                textAlign: TextAlign.center,
              ),
      ),
      // Floating action button to fetch a new activity
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchActivity, // Call the fetch function when pressed
        tooltip: 'Get a new activity',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
