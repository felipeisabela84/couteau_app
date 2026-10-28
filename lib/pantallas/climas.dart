import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Climas extends StatefulWidget {
  const Climas({super.key});
  @override
  State<Climas> createState() => _Clima();
}

class _Clima extends State<Climas> {
  Map<String, dynamic>? _d;
  bool _cargando = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    try {
      final url = Uri.parse(
          'https://api.open-meteo.com/v1/forecast'
          '?latitude=18.4861&longitude=-69.9312'
          '&daily=temperature_2m_max,temperature_2m_min,'
          'precipitation_probability_max,weathercode'
          '&timezone=America/Santo_Domingo&forecast_days=1');
      final r = await http.get(url);
      _d = jsonDecode(r.body)['daily'];
    } catch (e) {
      _error = 'Error de conexión';
    }
    setState(() => _cargando = false);
  }

  String _descripcion(int c) {
    if (c == 0) return 'Despejado';
    if (c <= 3) return 'Parcialmente nublado';
    if (c <= 48) return 'Niebla';
    if (c <= 67) return 'Lluvia';
    if (c <= 82) return 'Chubascos';
    return 'Tormenta';
  }

  IconData _icono(int c) {
    if (c == 0) return Icons.wb_sunny;
    if (c <= 3) return Icons.wb_cloudy;
    if (c <= 48) return Icons.foggy;
    if (c <= 82) return Icons.umbrella;
    return Icons.thunderstorm;
  }

  @override
  Widget build(BuildContext context) {
    Widget cuerpo;
    if (_cargando) {
      cuerpo = const CircularProgressIndicator();
    } else if (_d == null) {
      cuerpo = Text(_error);
    } else {
      final codigo = _d!['weathercode'][0] as int;
      cuerpo = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Santo Domingo, RD',
              style: const TextStyle(fontSize: 22)),
          Text(DateFormat('dd/MM/yyyy').format(DateTime.now())),
          Icon(_icono(codigo), size: 100, color: Colors.orange),
          Text(_descripcion(codigo),
              style: const TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text('Máxima: ${_d!['temperature_2m_max'][0]} °C',
              style: const TextStyle(fontSize: 20)),
          Text('Mínima: ${_d!['temperature_2m_min'][0]} °C',
              style: const TextStyle(fontSize: 20)),
          Text(
              'Prob. de lluvia: ${_d!['precipitation_probability_max'][0]} %',
              style: const TextStyle(fontSize: 20)),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Clima en RD')),
      body: Center(child: cuerpo),
    );
  }
}