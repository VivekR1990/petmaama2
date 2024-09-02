import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petmaama/presentation/map_page/map_page.dart'; // Ensure the path is correct

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _locationDetails = "Fetching location..."; // Placeholder for location details

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        _getLocationDetails();
        break;
      case PermissionStatus.denied:
        _showPermissionDeniedDialog();
        break;
      case PermissionStatus.permanentlyDenied:
        _showOpenSettingsDialog();
        break;
      default:
        // Handle other cases if necessary
        break;
    }
  }

  /// Fetches the current location details and updates the UI with the received information.
  /// 
  /// This function simulates a delay to mimic the time it takes to fetch location details.
  /// 
  /// Returns: A Future that completes when the location details have been fetched and the UI has been updated.
  Future<void> _getLocationDetails() async {
    // Simulate fetching location details
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
    setState(() {
      _locationDetails = "Current Location: Ernakulam"; // Example location details
    });
  }}

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Location Permission Denied'),
          content: const Text('The app needs location permission to function properly.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showOpenSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Location Permission Permanently Denied'),
          content: const Text('Please go to settings and enable location permissions for this app.'),
          actions: [
            TextButton(
              onPressed: () {
                openAppSettings(); // Open app settings
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _navigateToLocationScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationScreen()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _locationDetails = result['address'] ?? "No address available";
      });
    } else {
      setState(() {
        _locationDetails = "No address available";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: _navigateToLocationScreen,
            child: const Icon(Icons.location_on_outlined),
          ),
          title: Text(
            _locationDetails,
            style: const TextStyle(fontSize: 16.0),
            overflow: TextOverflow.ellipsis,
          ),
          actions: const [Icon(Icons.shopping_bag_outlined)],
        ),
        body: Center(
          child: Text(
            _locationDetails,
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
