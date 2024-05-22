abstract class PizzaBuilder {
  double pizzaPrice();
  List<String> ingredients = [];
  String dough, sauce, name;
  double price;
  void setIngredients();
  String getDough();
  String getSauce();
  String getName();
  List<String> getIngredients();
  void addIngredient(String ingredient);

  // Con valores "" por defecto
  PizzaBuilder({this.name = "", this.dough = "", this.sauce = "", this.ingredients = const [], this.price = 0});

  PizzaBuilder fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

}

class MargheritaPizzaBuilder extends PizzaBuilder {
  String name = '';
  String dough = '';
  String sauce = '';
  double price = 0.0;
  List<String> ingredients = [];

  MargheritaPizzaBuilder({
    this.name = 'Pizza margarita',
    this.dough = 'Thin crust',
    this.sauce = 'Tomato sauce',
    this.price = 8.0,
    this.ingredients = const ['Mozzarella cheese', 'Fresh basil', 'Tomato sauce'],
  });

  @override
  String getName() {
    return name;
  }

  @override
  double pizzaPrice() {
    return price;
  }

  @override
  void setIngredients() {
    ingredients = ['Mozzarella cheese', 'Fresh basil', 'Tomato sauce'];
  }

  @override
  String getDough() {
    return dough;
  }

  @override
  String getSauce() {
    return sauce;
  }

  @override
  List<String> getIngredients() {
    return ingredients;
  }

  @override
  void addIngredient(String ingredient) {
    ingredients.add(ingredient);
  }

  @override
  MargheritaPizzaBuilder fromJson(Map<String, dynamic> json) {
    return MargheritaPizzaBuilder(
      name: json['name'],
      dough: json['dough'],
      sauce: json['sauce'],
      ingredients: List<String>.from(json['ingredients']),
      price: json['price'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dough': dough,
      'sauce': sauce,
      'ingredients': ingredients,
      'price': price,
    };
  }
}

class PepperoniPizzaBuilder extends PizzaBuilder {
  String name = '';
  String dough = '';
  String sauce = '';
  double price = 0.0;
  List<String> ingredients = [];

  PepperoniPizzaBuilder({
    this.name = 'Pizza pepperoni',
    this.dough = 'Thick crust',
    this.sauce = 'Tomato sauce',
    this.price = 10.0,
    this.ingredients = const ['Pepperoni', 'Mozzarella cheese', 'Mushrooms', 'Onions', 'Tomato sauce'],
  });

  @override
  String getName() {
    return name;
  }

  @override
  double pizzaPrice() {
    return price;
  }

  @override
  void setIngredients() {
    ingredients = ['Pepperoni', 'Mozzarella cheese', 'Mushrooms', 'Onions', 'Tomato sauce'];
  }

  @override
  String getDough() {
    return dough;
  }

  @override
  String getSauce() {
    return sauce;
  }

  @override
  List<String> getIngredients() {
    return ingredients;
  }

  @override
  void addIngredient(String ingredient) {
    ingredients.add(ingredient);
  }

  @override
  PepperoniPizzaBuilder fromJson(Map<String, dynamic> json) {
    return PepperoniPizzaBuilder(
      name: json['name'],
      dough: json['dough'],
      sauce: json['sauce'],
      ingredients: List<String>.from(json['ingredients']),
      price: json['price'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dough': dough,
      'sauce': sauce,
      'ingredients': ingredients,
      'price': price,
    };
  }
}

class VeggiePizzaBuilder extends PizzaBuilder {
  String name = '';
  String dough = '';
  String sauce = '';
  double price = 0.0;
  List<String> ingredients = [];

  VeggiePizzaBuilder({
    this.name = 'Pizza vegetal',
    this.dough = 'Thin crust',
    this.sauce = 'Tomato sauce',
    this.price = 9.0,
    this.ingredients = const ['Mushrooms', 'Bell peppers', 'Onions', 'Black olives', 'Spinach', 'Tomato sauce'],
  });

  @override
  String getName() {
    return name;
  }

  @override
  double pizzaPrice() {
    return price;
  }

  @override
  void setIngredients() {
    ingredients = ['Mushrooms', 'Bell peppers', 'Onions', 'Black olives', 'Spinach', 'Tomato sauce'];
  }

  @override
  String getDough() {
    return dough;
  }

  @override
  String getSauce() {
    return sauce;
  }

  @override
  List<String> getIngredients() {
    return ingredients;
  }

  @override
  void addIngredient(String ingredient) {
    ingredients.add(ingredient);
  }

  @override
  VeggiePizzaBuilder fromJson(Map<String, dynamic> json) {
    return VeggiePizzaBuilder(
      name: json['name'],
      dough: json['dough'],
      sauce: json['sauce'],
      ingredients: List<String>.from(json['ingredients']),
      price: json['price'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dough': dough,
      'sauce': sauce,
      'ingredients': ingredients,
      'price': price,
    };
  }
}
