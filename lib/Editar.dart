import 'package:flutter/material.dart';
import 'db/transacciones.dart';

class Editar extends StatefulWidget {
  const Editar({super.key});

  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  TextEditingController cntNombre = TextEditingController();
  TextEditingController cntApellido = TextEditingController();
  TextEditingController cntFecha = TextEditingController();
  TextEditingController cntPeso = TextEditingController();
  String idUsuario = "";
  void cargarInfo(
      String id, String name, String last_name, String date_, String weigth) {
    setState(() {
      idUsuario = id;
      cntNombre.text = name;
      cntApellido.text = last_name;
      cntFecha.text = date_;
      cntPeso.text = weigth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map arg = ModalRoute.of(context)?.settings.arguments as Map;
    cargarInfo(arg["id"].toString(), arg["nombre"], arg["apellido"],
        arg["fecha"], arg["peso"].toString());

    return Scaffold(
      appBar: AppBar(title: const Text("Usuario")),
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
                EditarUsuario();
              },
              child: const Text("Actualizar")),
          ElevatedButton(
              onPressed: () {
                EliminarUsuario();
              },
              child: const Text("Eliminar"))
        ]),
      ),
    );
  }

  void EditarUsuario() async {
    String nombre = cntNombre.text;
    String apellido = cntApellido.text;
    String fecha = cntFecha.text;
    double peso = double.parse(cntPeso.text);
    Map arg = ModalRoute.of(context)?.settings.arguments as Map;
    int id = arg["id"];
    int r = await Transacciones.edtUsuario(nombre, apellido, fecha, peso, id);
    mostrarAlertaEditar();
  }

  void EliminarUsuario() async {
    Map arg = ModalRoute.of(context)?.settings.arguments as Map;
    int id = arg["id"];
    int r = await Transacciones.eliUsuario(id);
    mostrarAlertaEliminar();
  }

  mostrarAlertaEditar() {
    Widget ok = TextButton(
        onPressed: () {
          //Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        },
        child: const Text("Aceptar"));

    AlertDialog al = AlertDialog(
      title: const Text("Mensaje"),
      content: const Text("Se Actualizo el Usuario"),
      actions: [ok],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return al;
        });
  }

  mostrarAlertaEliminar() {
    Widget ok = TextButton(
        onPressed: () {
          //Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        },
        child: const Text("Aceptar"));

    AlertDialog borrar = AlertDialog(
      title: const Text("Mensaje"),
      content: const Text("Se Elimino el usuario"),
      actions: [ok],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return borrar;
        });
  }
}
