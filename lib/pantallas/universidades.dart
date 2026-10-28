import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class Universidades extends StatefulWidget {
  const Universidades({super.key});
  @override
  State<Universidades> createState() =>
      _Universidades();
}

class _Universidades extends State<Universidades> {
  final _ctrl = TextEditingController();
  List _unis = [];
  bool _cargando = false;
  String _mensaje = '';

  Future<void> _buscar() async {
    final pais = _ctrl.text.trim();
    if (pais.isEmpty) return;
    setState(() {
      _cargando = true;
      _mensaje = '';
      _unis = [];
    });
    try {
      final r = await http.get(Uri.https(
          'adamix.net', '/proxy.php', {'country': pais}));
      final d = jsonDecode(r.body);
      _unis = d is List ? d : [];
      if (_unis.isEmpty) _mensaje = 'No se encontraron universidades';
    } catch (e) {
      _mensaje = 'Error de conexión';
    }
    setState(() => _cargando = false);
  }

  Future<void> _abrir(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Universidades')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: const InputDecoration(
                        labelText: 'País en inglés (Dominican Republic)',
                        border: OutlineInputBorder()),
                    onSubmitted: (_) => _buscar(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                    onPressed: _buscar, icon: const Icon(Icons.search)),
              ],
            ),
          ),
          if (_cargando) const LinearProgressIndicator(),
          if (_mensaje.isNotEmpty) Text(_mensaje),
          Expanded(
            child: ListView.builder(
              itemCount: _unis.length,
              itemBuilder: (_, i) {
                final u = _unis[i];
                final dominios = (u['domains'] as List? ?? []).join(', ');
                final webs = (u['web_pages'] as List? ?? []);
                return Card(
                  child: ListTile(
                    title: Text(u['name'] ?? ''),
                    subtitle: Text('Dominio: $dominios'),
                    trailing: webs.isEmpty
                        ? null
                        : TextButton(
                            onPressed: () => _abrir(webs[0]),
                            child: const Text('Visitar')),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}