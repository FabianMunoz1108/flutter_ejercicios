import 'package:flutter/cupertino.dart';

class MiTexto extends StatelessWidget {
  final String texto;
  const MiTexto({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text(texto,
        style: const TextStyle(
            fontSize: 30,
            color: CupertinoColors.activeBlue,
            decoration: TextDecoration.underline));
  }
}
class Personaje{

  String nombre;
  String estatus;
  String imagen;
  String especie;

  Personaje({required this.nombre, required this.estatus, required this.imagen, required this.especie});

}

class Lista extends StatelessWidget {
  const Lista({super.key});
/*
 List<Personaje> personajes = [
      Personaje(
        nombre: "Rick Sanchez",
        estatus: "Vivo",
        imagen:
            "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        especie: "Human",
      ),
      Personaje(
        nombre: "Morty Smith",
        estatus: "Vivo",
        imagen:
            "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
        especie: "Human",
      ),
      Personaje(
        nombre: "Summer Smith",
        estatus: "Vivo",
        imagen:
            "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
        especie: "Human",
      ),
      // Add more Personaje instances as needed
    ];

*/
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          //Crear un contenedor para ajustar el tamaño del contenido -> scroll
          shrinkWrap: true,
          children: [for (var i = 0; i < 5; i++) Text("Elemento $i")],
        )
      ],
    );
  }
}
//Styles
var cardBoxDecoration = BoxDecoration(
    color: CupertinoColors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: const [
      BoxShadow(
          color: CupertinoColors.systemGrey, blurRadius: 5, offset: Offset(2, 2))
    ]);
var titleStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
var dateStyle = TextStyle(fontSize: 10, color: CupertinoColors.systemGrey.withOpacity(0.5));

//Widget tarjeta
class NewsCard extends StatelessWidget {
  final String title;
  final String source;
  final String date;
  final String imageUrl;

  const NewsCard(
      {super.key,
      required this.title,
      required this.source,
      required this.date,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: cardBoxDecoration,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Image.asset(imageUrl, width: 100, height: 100, fit: BoxFit.cover),
          const SizedBox(width: 10), //Separación entre la imagen y el texto (10px
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(title, style: titleStyle),
            const SizedBox(height: 5),
            Text(source, style:  const TextStyle(fontSize: 15 , color: CupertinoColors.activeOrange)),
            const SizedBox(height: 5),
            Text(date, style: dateStyle)
          ])
        ],
      ),
    );
  }
}
/*
class ContadorSinEstadoWidget extends StatelessWidget {
  ContadorSinEstadoWidget({super.key});
  var contador = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Contador: $contador"),
        CupertinoButton(
          child: const Text("Incrementar"),
          onPressed: () {
            contador++;
            print(contador);
          },
        )
      ],
    );
  }
}*/