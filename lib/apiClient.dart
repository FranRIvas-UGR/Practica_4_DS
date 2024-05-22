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
      return pizzasJson.map((pizza) {
        switch (pizza['name']) {
          case 'Pizza margarita':
            return MargheritaPizzaBuilder().fromJson(pizza);
          case 'Pizza pepperoni':
            return PepperoniPizzaBuilder().fromJson(pizza);
          case 'Pizza veggie':
            return VeggiePizzaBuilder().fromJson(pizza);
          default:
            throw Exception('Unknown pizza type');
        }
      }).toList();
    } else {
      throw Exception('Failed to load pizzas');
    }
  }
}
