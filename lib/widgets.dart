import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ejercicios/stateful/stateful.dart';
import 'package:flutter_ejercicios/stateless/stateless.dart';

/**
 * Dos tipos de widgets
 * Stateless: inmutable, no cambia
 * Stateful: mutable, cambia
 */

class MiAplicacion extends StatelessWidget {
  //Identificador único para el widget
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Mi Aplicación',
      home: TuHomePage(),
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
      )
    );
  }
}

class TuHomePage extends StatelessWidget {
  const TuHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Tu Main Page'),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hello World 1'),
            Text('Hello World 2'),
            Text('Hello World 3'),
            MiTexto(texto: "Saludos a todos!"),
            Lista(),

            NewsCard(
              title: "Titulo de la noticia",
              source: "Fuente de la noticia",
              date: "Fecha de la noticia",
              imageUrl: "assets/images/uno.jpeg",
            ),  
            CambiaColor(),
            ContadorWidget(valorInicial: 10),
          ],
        ),
      ),
    );
  }
}
