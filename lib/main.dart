import 'package:flutter/material.dart';

void main() {
  runApp(DatabaseApp());
}

class DatabaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DatabaseQueryScreen(),
    );
  }
}

class DatabaseQueryScreen extends StatefulWidget {
  @override
  _DatabaseQueryScreenState createState() => _DatabaseQueryScreenState();
}

class _DatabaseQueryScreenState extends State<DatabaseQueryScreen> {
  bool _isLoading = false; // State for loading spinner
  List<String> _data = []; // Simulated database records

  // Simulate a database query with Future.delayed
  Future<void> _fetchDataFromDatabase() async {
    setState(() {
      _isLoading = true; // Start loading
      _data = []; // Clear previous data
    });

    try {
      // Simulate a delay to represent database query
      await Future.delayed(Duration(seconds: 3));
      setState(() {
        // Simulated database records
        _data = [
          "Record 1: Apple",
          "Record 2: Banana",
          "Record 3: Cherry",
          "Record 4: Date",
          "Record 5: Elderberry",
        ];
      });
    } catch (error) {
      // Handle any potential errors
      setState(() {
        _data = ["Error fetching data: $error"];
      });
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Async Database Query"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                CircularProgressIndicator() // Show loading spinner
              else if (_data.isEmpty)
                const Text(
                  "No data available. Press the button to fetch data.",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.storage),
                        title: Text(_data[index]),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchDataFromDatabase,
                child: const Text("Fetch Data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
