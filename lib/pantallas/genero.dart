import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GeneroPantalla extends StatefulWidget {
  const GeneroPantalla({super.key});
  @override
  State<GeneroPantalla> createState() => _GeneroPantallaState();
}

class _GeneroPantallaState extends State<GeneroPantalla> {
  final _ctrl = TextEditingController();
  Color _fondo = Colors.white;
  String _mensaje = '';
  bool _cargando = false;

  Future<void> _predecir() async {
    final nombre = _ctrl.text.trim();
    if (nombre.isEmpty) return;
    setState(() => _cargando = true);
    try {
      final r = await http.get(
          Uri.https('api.genderize.io', '/', {'name': nombre}));
      final d = jsonDecode(r.body);
      setState(() {
        if (d['gender'] == 'male') {
          _fondo = Colors.blue.shade300;
          _mensaje = 'Masculino';
        } else {
          _fondo = Colors.pink.shade200;
          _mensaje = 'Femenino';
        }
      });
    } catch (e) {
      setState(() => _mensaje = 'Error de conexión');
    }
    setState(() => _cargando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Predecir género')),
      body: Container(
        color: _fondo,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _ctrl,
              decoration: const InputDecoration(
                labelText: 'Escribe un nombre',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: _cargando ? null : _predecir,
                child: const Text('Predecir')),
            const SizedBox(height: 30),
            if (_cargando) const CircularProgressIndicator(),
            Text(_mensaje,
                style: const TextStyle(
                    fontSize: 32, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}