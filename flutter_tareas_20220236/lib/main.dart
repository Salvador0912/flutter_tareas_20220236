import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tareas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tareas'),
    );
  }
}

class TareaIndividual {
  String nombreTarea;
  bool completada;

  TareaIndividual(this.nombreTarea, this.completada);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TareaIndividual> listaTareas = [];
  String _currentTaskName = '';

  void agregarTarea() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Añadir tarea'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(hintText: 'Ingresa el nombre de la tarea'),
          onChanged: (text) => _currentTaskName = text,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                listaTareas.add(TareaIndividual(_currentTaskName, false));
              });
              Navigator.pop(context);
            },
            child: Text('Añadir'),
          ),
        ],
      ),
    );
  }

  void _editTaskName(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar nombre de la tarea'),
        content: TextField(
          controller: TextEditingController(text: listaTareas[index].nombreTarea),
          onChanged: (text) => _currentTaskName = text,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                listaTareas[index].nombreTarea = _currentTaskName;
              });
              Navigator.pop(context);
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Tus tareas:',
            ),
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listaTareas.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(listaTareas[index].nombreTarea),
                    leading: Checkbox(
                      value: listaTareas[index].completada,
                      onChanged: (bool? value) {
                        setState(() {
                          listaTareas[index].completada = value!;
                        });
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editTaskName(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: agregarTarea,
        tooltip: 'Añadir tarea',
        child: const Icon(Icons.add),
      ),
    );
  }
}
