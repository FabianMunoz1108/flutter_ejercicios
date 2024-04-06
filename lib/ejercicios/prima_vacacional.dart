import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PrimaVacacional extends StatelessWidget {
  const PrimaVacacional({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: HomePrimaVacacional(),
      title: 'Prima Vacacional',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemIndigo,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

/*
* Widget con el listado de items de primas vacacionales
*/
class HomePrimaVacacional extends StatefulWidget {
  const HomePrimaVacacional({Key? key}) : super(key: key);

  @override
  State<HomePrimaVacacional> createState() => _HomePrimaVacacionalState();
}

class _HomePrimaVacacionalState extends State<HomePrimaVacacional> {
  final List<PrimaVacacionalItem> _items = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Listado'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {

/*
            Navigator.of(context).push(
              CupertinoPageRoute<void>(
                builder: (BuildContext context) => const AgregarPrimavacacional(),
              ),
            );
*/

            Navigator.of(context).push(
              CupertinoPageRoute<void>(
                builder: (BuildContext context) => AgregarPrimavacacional(
                  onAgregarItem: (item) {

                    setState(() {
                      _items.add(item);
                    });

                    Navigator.of(context).pop();
                  
                },
                ),
              ),
            );
          },
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          itemCount: _items.length, 
          itemBuilder: (context, index) {

            return CupertinoListTile(title: Text(_items[index].nombreCompleto),
            subtitle: Text('Prima: ${NumberFormat.currency(symbol: '\$').format(_items[index].primaVacacionalBruta)}'),
            );

      },)),
    );
  }
}
class PrimaVacacionalItem {
  final String id;
  final String nombreCompleto;
  final double sueldoMensualBruto;
  final int diasVacaciones;
  final int porcentajePrima;
  final double primaVacacionalBruta;

  PrimaVacacionalItem({

    required this.nombreCompleto,
    required this.sueldoMensualBruto,
    required this.diasVacaciones,
    required this.porcentajePrima,
    required this.primaVacacionalBruta,
  }) : id = UniqueKey().toString();

}

/*
 * Widget para agregar items en la lista de prima vacacional
 */
class AgregarPrimavacacional extends StatefulWidget{
  const AgregarPrimavacacional({Key? key, required this.onAgregarItem}) : super(key: key);
  final Function(PrimaVacacionalItem) onAgregarItem;

  @override
  State<AgregarPrimavacacional> createState() => _AgregarPrimavacacionalState();
}

class _AgregarPrimavacacionalState extends State<AgregarPrimavacacional> {
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _sueldoMensualController = TextEditingController();
  final _diasVacacionesController = TextEditingController();
  final _porcentajePrimaController = TextEditingController();
  double _primaVacacionalBruta = 0.0;

    void _calcularPrimaVacacional() {
    setState(() {

_primaVacacionalBruta =
          ((double.tryParse(_sueldoMensualController.text)! / 30) *
                  int.tryParse(_diasVacacionesController.text)!) *
              (double.tryParse(_porcentajePrimaController.text)! /
                  100);

    });
  }

  @override
  void initState() {
    //La llamada a super debe ser la primera en el método
    super.initState();

    _nombreController.addListener(_calcularPrimaVacacional);
    _apellidoController.addListener(_calcularPrimaVacacional);
    _sueldoMensualController.addListener(_calcularPrimaVacacional);
    _diasVacacionesController.addListener(_calcularPrimaVacacional);
    _porcentajePrimaController.addListener(_calcularPrimaVacacional);
  }
  @override
  void dispose() {
    _nombreController.removeListener(_calcularPrimaVacacional);
    _apellidoController.removeListener(_calcularPrimaVacacional);
    _sueldoMensualController.removeListener(_calcularPrimaVacacional);
    _diasVacacionesController.removeListener(_calcularPrimaVacacional);

    //Se llama al método dispose de la clase padre hasta el final, para liberar los recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Agregar Prima'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            widget.onAgregarItem(
              PrimaVacacionalItem(
                nombreCompleto: "${_nombreController.text} ${_apellidoController.text}",
                sueldoMensualBruto: double.tryParse(_sueldoMensualController.text)!,
                diasVacaciones: int.tryParse(_diasVacacionesController.text)!,
                porcentajePrima: int.tryParse(_porcentajePrimaController.text)!,
                primaVacacionalBruta: _primaVacacionalBruta,
              ),
            );
          },
          child: const Icon(CupertinoIcons.add_circled),
        ),
      ),


      child: SafeArea(child: 
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Nombre + Apellido
              Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Nombre:'),
                        CupertinoTextField(
                          controller: _nombreController,
                        ),
                      ],
                    ),
                  ), 
                  
                  const SizedBox(width: 8), 

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Apellido:'),
                        CupertinoTextField(
                          controller: _apellidoController,
                        ),
                      ],
                    ),
                  )

                ],
              ),
              const SizedBox(height: 8,),

              const Text("Sueldo mensual bruto:"),
              CupertinoTextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                controller: _sueldoMensualController,
              ),
              
              const SizedBox(height: 8,),

              const Text("Días de vacaciones:"),
              CupertinoTextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _diasVacacionesController,
              ),

              const SizedBox(height: 8,),

              const Text("Porcentaje de prima vacacional:"),
              CupertinoTextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _porcentajePrimaController,
              ),

              const SizedBox(height: 30,),

              const Divider(height: 1, indent: 20, endIndent: 20,),

              const SizedBox(height: 30,),

              const Text(
                'Prima Vacacional', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Empleado:'), 
                  Text("${_nombreController.text} ${_apellidoController.text}")
                ],
              ),

              const SizedBox(height: 8,),

               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Prima vacacional:'), 
                  Text(NumberFormat.currency(symbol: '\$').format(_primaVacacionalBruta))
                ],
              ),              

            ],
          ),
          ),
      )
      ),


    );
  }
}