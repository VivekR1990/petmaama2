import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String _baseUrl = 'https://petopia-server.vercel.app/api';

  // Helper method for POST requests
  static Future<http.Response> _postRequest(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    try {
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      return response;
    } catch (e) {
      // Print the error and rethrow for higher-level error handling
      rethrow;
    }
  }

  // User sign-in
  static Future<bool> postSignin(Map<String, dynamic> body) async {
    try {
      final response = await _postRequest('/auth/user-signin', body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // User sign-up
  static Future<bool> postSignup(Map<String, dynamic> body) async {
    try {
      final response = await _postRequest('/auth/user-signup', body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Fetching the list of pets
  static Future<String> getAddPet() async {
    final uri = Uri.parse('$_baseUrl/pet/get-pets-list');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return response.body; // Return the JSON string
      } else {
        throw Exception('Failed to load pets');
      }
    } catch (e) {
      rethrow;
    }
  }

// Fetching the structure of a specific pet
/// Fetches the structure of a specific pet from the server.
///
/// This function makes an asynchronous GET request to the server with the provided `petId` as a query parameter.
/// It returns the response body as a JSON string if the request is successful (200 status code).
/// If the request fails, it throws an exception with a descriptive error message.
///
/// Parameters:
///   petId (String): The ID of the pet whose structure is to be fetched.
///
/// Returns:
///   Future<String>: A future that resolves to the JSON string representing the pet structure.
static Future<String> getPetStructure(String petId) async {
  final uri = Uri.parse('$_baseUrl/pet/get-pet-structure')
      .replace(queryParameters: {'petId': petId});
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load pet structure');
    }
  } catch (e) {
    rethrow;
  }
}
  static Future<bool> submitPet(Map<String, dynamic> body) async {
    try {
      final response = await _postRequest('/user/add-a-pet', body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
