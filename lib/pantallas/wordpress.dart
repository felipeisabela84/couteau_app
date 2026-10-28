import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Wordpress extends StatefulWidget {
  const Wordpress({super.key});
  @override
  State<Wordpress> createState() => _Wordpress();
}

class _Wordpress extends State<Wordpress> {
  List _posts = [];
  bool _cargando = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  String _limpiar(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&#8217;', "'")
        .replaceAll('&#8216;', "'")
        .replaceAll('&#8220;', '"')
        .replaceAll('&#8221;', '"')
        .replaceAll('&#8211;', '-')
        .replaceAll('&hellip;', '...')
        .replaceAll('&amp;', '&')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }

  Future<void> _cargar() async {
    try {
      final r = await http.get(Uri.parse(
          'https://wordpress.org/news/wp-json/wp/v2/posts?per_page=3'));
      _posts = jsonDecode(r.body);
    } catch (e) {
      _error = 'Error de conexión';
    }
    setState(() => _cargando = false);
  }

  Future<void> _abrir(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Noticias WordPress')),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                Center(
                  child: Image.network(
                    'https://s.w.org/style/images/about/WordPress-logotype-wmark.png',
                    height: 90,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.public, size: 90),
                  ),
                ),
                const SizedBox(height: 12),
                if (_error.isNotEmpty) Text(_error),
                for (final p in _posts)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_limpiar(p['title']['rendered']),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text(_limpiar(p['excerpt']['rendered'])),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () => _abrir(p['link']),
                                child: const Text('Visitar')),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}