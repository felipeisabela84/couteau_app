import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Persona extends StatefulWidget {
  const Persona({super.key});
  @override
  State<Persona> createState() => _Persona();
}

class _Persona extends State<Persona> {
  Map<String, dynamic>? _p;
  bool _cargando = false;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    setState(() {
      _cargando = true;
      _error = '';
    });
    try {
      final r = await http
          .get(Uri.parse('https://randomuser.me/api/?results=1'));
      final d = jsonDecode(r.body);
      _p = d['results'][0];
    } catch (e) {
      _error = 'Error de conexión';
    }
    setState(() => _cargando = false);
  }

  @override
  Widget build(BuildContext context) {
    Widget cuerpo;
    if (_cargando) {
      cuerpo = const CircularProgressIndicator();
    } else if (_p == null) {
      cuerpo = Text(_error);
    } else {
      final fecha = DateTime.parse(_p!['dob']['date']).toLocal();
      cuerpo = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(_p!['picture']['large'])),
          const SizedBox(height: 16),
          Text('Nombre: ${_p!['name']['first']}',
              style: const TextStyle(fontSize: 20)),
          Text('Apellido: ${_p!['name']['last']}',
              style: const TextStyle(fontSize: 20)),
          Text('Nacimiento: ${DateFormat('dd/MM/yyyy').format(fecha)}',
              style: const TextStyle(fontSize: 20)),
          Text('Edad: ${_p!['dob']['age']} años',
              style: const TextStyle(fontSize: 20)),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Persona aleatoria')),
      body: Center(child: cuerpo),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _cargar,
        icon: const Icon(Icons.refresh),
        label: const Text('Otra persona'),
      ),
    );
  }
}