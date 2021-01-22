import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = ("Informe os seus dados:");

  void _resetfield() {
    pesoController.text = "";
    alturaController.text = "";
    setState(
      () {
        _info = ("Informe os seus dados:");
        _formKey = GlobalKey<FormState>();
      },
    );
  }

  void _calculate() {
    setState(
      () {
        double peso = double.parse(pesoController.text);
        double altura = double.parse(alturaController.text);
        double imc = peso / (altura * altura);
        if (imc < 20.00) {
          _info = "Abaixo do peso(${imc.toStringAsPrecision(4)})";
        } else if (imc >= 20.00 && imc < 25.00) {
          _info =
              "Você esta dentro do peso ideal(${imc.toStringAsPrecision(4)})";
        } else if (imc >= 25.00 && imc < 30.00) {
          _info =
              "Você esta com Obesidade Grau 1(${imc.toStringAsPrecision(4)})";
        } else if (imc >= 30.00 && imc < 40.00) {
          _info =
              "Você esta com Obesidade Grau 2(${imc.toStringAsPrecision(4)})";
        } else {
          _info =
              "Você esta com Obesidade Grau 3(${imc.toStringAsPrecision(4)})";
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CALC IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetfield,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 150.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso / [Kg]",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: pesoController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira o seu Peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura / [metros]",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: alturaController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira a sua Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Container(
                  height: 70.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  _info,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
