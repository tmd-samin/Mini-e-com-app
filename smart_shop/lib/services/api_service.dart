import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/user.dart';
import '../utils/constants.dart';

class ApiService {
  static Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}/products'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<User?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // For demo purposes, return a mock user
        // In real app, you'd get user data from the token
        return User(
          id: 1,
          email: '$username@example.com',
          username: username,
          firstName: 'John',
          lastName: 'Doe',
          phone: '1234567890',
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}