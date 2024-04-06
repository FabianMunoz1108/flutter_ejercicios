import 'package:flutter/cupertino.dart';
import 'dart:math';

/**
 * Los widgets stateful tienen dos clases
 * 1. La clase que extiende de StatefulWidget -> Se va a encargar de definir el estado
 * 2. La clase que extiende de State -> Se encaaga de construir el widget y manejar el estado
 * --
 * StatefulWidget: -> Inmutable (No cambia sus propiedades internas)
 * State: -> Mutable (Puede cambiar sus propiedades internas)
 */

class CambiaColor extends StatefulWidget {
   const CambiaColor({Key? key}) : super(key: key);

  @override
  State<CambiaColor> createState() => _CambiaColorState();
}

class _CambiaColorState extends State<CambiaColor> {
  Color _color = CupertinoColors.activeBlue;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
      CupertinoButton(
        child: const Text("Cambiar color"), 
        onPressed: () => {
          setState(() {
            _color = Color.fromRGBO(Random().nextInt(255), 
            Random().nextInt(255), 
            Random().nextInt(255), 1);
          })
        }),
        Container(
          width: 100,
          height: 100,
          color: _color)
      ],
    );
  }
}

class ContadorWidget extends StatefulWidget {
  final int valorInicial;
  const ContadorWidget({Key? key, this.valorInicial = 0}) : super(key: key);

  @override
  State<ContadorWidget> createState() => _ContadorWidgetState();
}

class _ContadorWidgetState extends State<ContadorWidget> {
  int _contador = 0;

  @override
  void initState() {
    super.initState();
    _contador = widget.valorInicial;
  }
  void _incrementar() {
    setState(() {
      _contador++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton(
          child: Text("$_contador | Incrementar"),
          onPressed: () {
            _incrementar();
          },
        )
      ],
    );
  }
}