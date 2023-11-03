import 'package:flutter/material.dart';
import 'db/transacciones.dart';

class Registrar extends StatefulWidget {
  const Registrar({super.key});

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  TextEditingController cntNombre = TextEditingController();
  TextEditingController cntApellido = TextEditingController();
  TextEditingController cntFecha = TextEditingController();
  TextEditingController cntPeso = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrar")),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            controller: cntNombre,
            decoration: const InputDecoration(
              hintText: "Digite Nombres",
            ),
          ),
          TextField(
            controller: cntApellido,
            decoration: const InputDecoration(
              hintText: "Digite Apellidos",
            ),
          ),
          TextField(
            controller: cntFecha,
            decoration: const InputDecoration(
              hintText: "Digite la Fecha",
            ),
          ),
          TextField(
            controller: cntPeso,
            decoration: const InputDecoration(
              hintText: "Digite el Peso",
            ),
          ),
          ElevatedButton(
              onPressed: () {
                RegistrarUsuario();
              },
              child: const Text("Registrar"))
        ]),
      ),
    );
  }

  void RegistrarUsuario() async {
    String nombre = cntNombre.text;
    String apellido = cntApellido.text;
    String fecha = cntFecha.text;
    double peso = double.parse(cntPeso.text);
    int r = await Transacciones.regUsuario(nombre, apellido, fecha, peso);
    mostrarAlerta();
  }

  mostrarAlerta() {
    Widget ok = TextButton(
        onPressed: () {
          Navigator.pop(context);
          //Navigatior.pushNamedandRemoveUntil(context, '/', (route) => false);
        },
        child: const Text("Aceptar"));

    AlertDialog al = AlertDialog(
      title: const Text("Mensaje"),
      content: const Text("Se registro el Usuario"),
      actions: [ok],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return al;
        });
  }
}
