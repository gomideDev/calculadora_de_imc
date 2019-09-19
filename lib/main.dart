import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

void main() {
  runApp(MaterialApp(
    home: Home()
  ));  
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetField(){
      weightController.clear();
      heightController.clear();
      setState(() {
    _infoText = "Informe seus dados";
    _formKey.currentState.reset();
    });
  }

  void _calculate(){
    setState(() {
    double _peso = double.parse(weightController.text);
    double _altura = double.parse(heightController.text) / 100;
    double _imc = _peso / (_altura * _altura);
    print(_imc);
    if(_imc < 18.6){
      _infoText = "Abaixo do peso (${_imc.toStringAsPrecision(3)})";
    } else if(_imc >= 18.6 && _imc < 24.9){
      _infoText = "Peso Ideal (${_imc.toStringAsPrecision(3)})";
    }else if(_imc >= 24.9 && _imc < 29.9){
      _infoText = "Levemente acima do peso (${_imc.toStringAsPrecision(3)})";
    }else if(_imc >= 29.9 && _imc < 34.9){
      _infoText = "Obesidade grau I (${_imc.toStringAsPrecision(3)})";
    }else if(_imc >= 34.9 && _imc < 39.9){
      _infoText = "Obesidade grau II (${_imc.toStringAsPrecision(3)})";
    }else if(_imc >= 40.0){
      _infoText = "Obesidade grau III (${_imc.toStringAsPrecision(3)})";
    }
    });
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de Imc"),
        centerTitle: true,
        backgroundColor:  Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              _resetField();
            },
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
        Icon(
          Icons.person_outline, 
          size: 120.0, 
          color: Colors.green,
          ),
        TextFormField(keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Peso (Kg)",
          labelStyle: TextStyle(color: Colors.green)
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.green,
            fontSize: 25.0
            ),
            controller: weightController,
            validator: (value){
              if(value.isEmpty){
                return "Insira o seu peso!";
              }
            },
          ),
          TextFormField(keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Altura (Cm)",
          labelStyle: TextStyle(color: Colors.green)
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.green,
            fontSize: 25.0
            ),
            controller: heightController,
            validator: (value){
              if(value.isEmpty){
                return "Insira a sua altura!";
              }
            },
          ),
          Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)
          ),
         Container(
           height: 50.0,
           child: RaisedButton(
            onPressed: (){
              if(_formKey.currentState.validate()){
                _calculate();
              }
            },
            child: Text("Calcular", style: TextStyle(
              color: Colors.white,
              fontSize: 25.0
            ),),
            color: Colors.green,
          ),
          ),
          Text(_infoText, textAlign: TextAlign.center, style: TextStyle(
            fontSize: 25.0,
            color: Colors.green
          ),)
    ],
    ),
    )
    )
    );
  }
}