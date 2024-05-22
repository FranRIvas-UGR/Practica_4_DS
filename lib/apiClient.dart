import 'package:http/http.dart' as http;
import 'pizza_builder.dart';
import 'dart:convert';

class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  Future<List<PizzaBuilder>> getPizzas() async {
    final response = await http.get(Uri.parse('$baseUrl/pizzas'));

    if (response.statusCode == 200) {
      List pizzasJson = jsonDecode(response.body);
      return pizzasJson.map((pizza) => PizzaBuilder.fromJson(pizza)).toList();
    } else {
      throw Exception('Failed to load pizzas');
    }
  }
}
