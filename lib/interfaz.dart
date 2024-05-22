import 'pizza_fachada.dart';
import 'package:flutter/material.dart';
import 'pizza_builder.dart';
import 'payment_method.dart';

class PizzaBuilderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Builder',
      home: PizzaBuilderScreen(),
    );
  }
}

class PizzaBuilderScreen extends StatefulWidget {
  @override
  _PizzaBuilderScreenState createState() => _PizzaBuilderScreenState();
}

class _PizzaBuilderScreenState extends State<PizzaBuilderScreen> {
  late PizzaFacade pizzaFacade;

  @override
  void initState() {
    super.initState();
    pizzaFacade = PizzaFacade();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizza Builder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PizzaButton(
              label: 'Margherita',
              onPressed: () {
                var builder = MargheritaPizzaBuilder();
                builder.setIngredients();
                _showPizzaDetailsDialog(builder);
              },
            ),
            PizzaButton(
              label: 'Pepperoni',
              onPressed: () {
                var builder = PepperoniPizzaBuilder();
                builder.setIngredients();
                _showPizzaDetailsDialog(builder);
              },
            ),
            PizzaButton(
              label: 'Veggie',
              onPressed: () {
                var builder = VeggiePizzaBuilder();
                builder.setIngredients();
                _showPizzaDetailsDialog(builder);
              },
            ),
            SizedBox(height: 20),
            if (pizzaFacade.selectedPizzas.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Pedido:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  for (var pizza in pizzaFacade.selectedPizzas)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(' ${pizza.getName()}'),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  pizzaFacade.eliminarPizza(pizza);
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(),
                      ],
                    ),
                  SizedBox(height: 10),
                  Text(
                    'Precio total: \$${pizzaFacade.totalPrice().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PaymentButton(
                        label: 'Pagar',
                        onPressed: () {
                          _showPaymentDialog();
                        },
                      ),
                      SizedBox(width: 20),
                      PaymentButton(
                        label: 'Borrar pedido',
                        onPressed: () {
                          setState(() {
                            pizzaFacade.clearPizzas();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
        // Hacemos un desplegable para cambiar de usuario
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Usuarios'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Francisco'),
              onTap: () {
                setState(() {
                  pizzaFacade = PizzaFacade();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Helena'),
              onTap: () {
                setState(() {
                  pizzaFacade = PizzaFacade();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Jorge'),
              onTap: () {
                setState(() {
                  pizzaFacade = PizzaFacade();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Benigno'),
              onTap: () {
                setState(() {
                  pizzaFacade = PizzaFacade();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Alejandra'),
              onTap: () {
                setState(() {
                  pizzaFacade = PizzaFacade();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPizzaDetailsDialog(PizzaBuilder pizzaBuilder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${pizzaBuilder.getName()}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ingredientes:'),
              for (var ingredient in pizzaBuilder.getIngredients())
                Text('- $ingredient'),
              SizedBox(height: 10),
              Text('Masa: ${pizzaBuilder.getDough()}'),
              Text('Salsa: ${pizzaBuilder.getSauce()}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Atrás'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  pizzaFacade.addPizza(pizzaBuilder);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('Has añadido la pizza ${pizzaBuilder.getName()}'),
                  ),
                );
              },
              child: Text('Pedir'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccionar método de pago'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PaymentButton(
                label: 'Pagar con tarjeta',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CardPaymentDialog(
                        onPaymentConfirmed: () {
                          pizzaFacade.selectPayment(CardPaymentStrategy());
                          _showOrderDialog();
                        },
                      );
                    },
                  );
                },
              ),
              PaymentButton(
                label: 'Pagar en efectivo',
                onPressed: () {
                  setState(() {
                    pizzaFacade.selectPayment(CashPaymentStrategy());
                    _showOrderDialog();
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showOrderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pedido realizado'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pedido:'),
                for (var pizza in pizzaFacade.selectedPizzas)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pizza: ${pizza.getName()}'),
                      Divider(),
                    ],
                  ),
                Text(
                    'Precio total: \$${pizzaFacade.totalPrice().toStringAsFixed(2)}'),
                Text(
                    'Sistema de pago: ${pizzaFacade.selectedPayment is CardPaymentStrategy ? 'Tarjeta de crédito' : 'Efectivo'}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                pizzaFacade.clearPizzas();
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

class PizzaButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  PizzaButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class PaymentButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  PaymentButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class CardPaymentDialog extends StatefulWidget {
  final VoidCallback onPaymentConfirmed;

  const CardPaymentDialog({Key? key, required this.onPaymentConfirmed})
      : super(key: key);

  @override
  _CardPaymentDialogState createState() => _CardPaymentDialogState();
}

class _CardPaymentDialogState extends State<CardPaymentDialog> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Información de la tarjeta'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: cardNumberController,
            decoration: InputDecoration(labelText: 'Número de tarjeta'),
          ),
          TextField(
            controller: expirationDateController,
            decoration:
                InputDecoration(labelText: 'Fecha de caducidad (MM/YY)'),
          ),
          TextField(
            controller: pinController,
            decoration: InputDecoration(labelText: 'PIN'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            String cardNumber = cardNumberController.text;
            String expirationDate = expirationDateController.text;
            String pin = pinController.text;

            // Validación de la longitud del número de tarjeta y el PIN
            if (cardNumber.length == 16 && pin.length == 4) {
              // Si la longitud es válida, llamamos a la función de devolución de llamada
              widget.onPaymentConfirmed();
            } else {
              // Si la longitud no es válida, mostramos un mensaje de error
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text(
                        'Número de tarjeta o PIN no válido. Por favor, inténtalo de nuevo.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Limpiar los controladores de texto cuando se elimina el widget
    cardNumberController.dispose();
    expirationDateController.dispose();
    pinController.dispose();
    super.dispose();
  }
}
