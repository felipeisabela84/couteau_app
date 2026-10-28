import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pokemon extends StatefulWidget {
  const Pokemon({super.key});
  @override
  State<Pokemon> createState() => _Pokemon();
}

class _Pokemon extends State<Pokemon> {
  final _ctrl = TextEditingController();
  final _player = AudioPlayer();
  Map<String, dynamic>? _p;
  bool _cargando = false;
  String _error = '';

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _buscar() async {
    final nombre = _ctrl.text.trim().toLowerCase();
    if (nombre.isEmpty) return;
    setState(() {
      _cargando = true;
      _error = '';
      _p = null;
    });
    try {
      final r = await http
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$nombre'));
      if (r.statusCode == 200) {
        _p = jsonDecode(r.body);
      } else {
        _error = 'Pokémon no encontrado';
      }
    } catch (e) {
      _error = 'Error de conexión';
    }
    setState(() => _cargando = false);
  }

  Future<void> _sonido() async {
    final url = _p?['cries']?['latest'];
    if (url != null) await _player.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    final habilidades = _p == null
        ? ''
        : (_p!['abilities'] as List)
            .map((a) => a['ability']['name'])
            .join(', ');
    final foto = _p?['sprites']?['other']?['official-artwork']
            ?['front_default'] ??
        _p?['sprites']?['front_default'];

    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _ctrl,
              decoration: const InputDecoration(
                  labelText: 'Nombre del pokémon (pikachu)',
                  border: OutlineInputBorder()),
              onSubmitted: (_) => _buscar(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _buscar, child: const Text('Buscar')),
            const SizedBox(height: 20),
            if (_cargando) const CircularProgressIndicator(),
            if (_error.isNotEmpty) Text(_error),
            if (_p != null) ...[
              if (foto != null) Image.network(foto, height: 200),
              Text(_p!['name'].toString().toUpperCase(),
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold)),
              Text('Experiencia base: ${_p!['base_experience']}',
                  style: const TextStyle(fontSize: 18)),
              Text('Habilidades: $habilidades',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                  onPressed: _sonido,
                  icon: const Icon(Icons.volume_up),
                  label: const Text('Reproducir sonido')),
            ],
          ],
        ),
      ),
    );
  }
}