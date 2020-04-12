import 'package:flutter/material.dart';

///Método principal que inicia a aplicação
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    ///O home é chamado pela extensao do método createState, e logo pelo seu Widget build
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ///Controller responsavel por armazenar os textos de peso e altura
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  ///Analisa a situação do form para validação
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus Dados";

  ///Resetar os campos no refresh
  void _resetFields() {
    weightController.text = "";
    heightController.text = "";

    ///Atualiza o estado da activity
    setState(() {
      _infoText = "Informe seus Dados";
      _formKey = GlobalKey<FormState>(); // ADICIONE ESTA LINHA!
    });
  }

  ///Função que realiza o calculo
  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      String IMC = imc.toStringAsPrecision(3);

      ///Direciona o resultado de acordo com a situação
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${IMC})";
      } else if (imc >= 18.9 && imc < 24.9) {
        _infoText = "Peso Normal (${IMC})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${IMC})";
      } else if (imc >= 29.9 && imc < 34) {
        _infoText = "Obesidade GRAU I (${IMC})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade GRAU II (${IMC})";
      } else if (imc >= 40.0) {
        _infoText = "Obesidade GRAU III (${IMC})";
      }
    });
  }

  ///Inicia a criação da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso(kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: weightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu Peso";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura(cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua Altura";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                  )
                ],
              )),
        ));
  }
}
