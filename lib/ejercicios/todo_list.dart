import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tarea {
  final String titulo;
  final bool completada;

  Tarea({required this.titulo, required this.completada});
}

class MyTodoList extends StatelessWidget {
  final List<Tarea> tareas;
  const MyTodoList({Key? key, required this.tareas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Todo List',
      home: HomeTodoList(),
      theme: CupertinoThemeData(
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeTodoList extends StatelessWidget {
  const HomeTodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('My Todo List'),
        ),
        child: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Column(
                  children: [
                    const Text("Hello it´s me"),
                    //TaskItemWidget(title: "Task 1", completed: false,),
                    //TaskItemWidget(title: "Task 2", completed: true),

                    Expanded(
                        child: TareasWidget(tareas: [
                      Tarea(titulo: "Task 1", completada: false),
                      Tarea(titulo: "Task 2", completada: true),
                    ]))
                  ],
                ))));
  }
}

class TareasWidget extends StatefulWidget {
  final List<Tarea> tareas;

  const TareasWidget({Key? key, required this.tareas}) : super(key: key);

  @override
  State<TareasWidget> createState() => _TareasWidgetState();
}

class _TareasWidgetState extends State<TareasWidget> {
  final TextEditingController _myTaskController = TextEditingController();
  List<Tarea> _tareas = [];

  //Inicializar el estado del widget
  @override
  void initState() {
    super.initState();
    _tareas = [...widget.tareas];
  }

  void addTask(String task) {
    setState(() {
      _tareas.add(Tarea(titulo: task, completada: false));
    });
  }

  void deleteTask(int index) {
    setState(() {
      _tareas.removeAt(index);
    });
  }

  void showUpdateDialog(BuildContext context, int index) {
    final TextEditingController updateController = TextEditingController();
    updateController.text = _tareas[index].titulo;

    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text("Update Task"),
            content: CupertinoTextField(
              controller: updateController,
              placeholder: "Task name",
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("Cancel"), 
                onPressed: () {
                Navigator.of(context).pop();

              }),
              CupertinoDialogAction(child: const Text("Update"), onPressed: () {
                setState(() {
                  _tareas[index] = Tarea(titulo: updateController.text, completada: _tareas[index].completada);
                });
                Navigator.of(context).pop();

              },),
              
              
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _tareas.length > 10
            ? const Text("Too many tasks")
            : const SizedBox.shrink(),
        Row(
          children: [
            Flexible(
                child: CupertinoTextField(
              placeholder: "Add task",
              controller: _myTaskController,
            )),
            CupertinoButton(
              // () => //Correcta 2 -> Retorno 1 línea
              // () {} //Correcta 1 ->
              // () => {} //No debería ser correcta
              onPressed: () {
                if (_myTaskController.text.isEmpty) return;
                setState(() {
                  addTask(_myTaskController.text);
                  _myTaskController.clear();
                });
              },
              child: const Row(
                children: [
                  Text("Add"),
                  SizedBox(width: 10),
                  Icon(CupertinoIcons.add_circled)
                ],
              ),
            )
          ],
        ),
        Expanded(
            child: ListView.builder(
                itemCount: _tareas.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onDoubleTap: () {
                      showUpdateDialog(context, index);
                    
                    },
                    onTap: () {
                      setState(() {
                        _tareas[index] = Tarea(
                            titulo: _tareas[index].titulo,
                            completada: !_tareas[index].completada);
                      });
                    },
                    child: Dismissible(
                      key: Key(_tareas[index].titulo),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          deleteTask(index);
                        }
                      },
                      child: TaskItemWidget(
                        title: _tareas[index].titulo,
                        completed: _tareas[index].completada,
                      ),
                    ),
                  );
                })),
      ],
    );
  }
}

class TaskItemWidget extends StatelessWidget {
  final String title;
  final bool completed;

  const TaskItemWidget({Key? key, required this.title, required this.completed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(
          color: CupertinoColors.extraLightBackgroundGray,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            CupertinoCheckbox(value: completed, onChanged: (v) => {})
          ],
        ),
      ),
    );
  }
}
